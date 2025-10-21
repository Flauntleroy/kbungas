<?php

namespace App\Services;

use App\Models\BookingPeriksa;
use App\Models\RegPeriksa;
use App\Models\Pasien;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;
use Exception;

class BookingToRegPeriksa
{
    /**
     * Transfer data dari booking_periksa ke reg_periksa
     * 
     * @param string $noBooking
     * @param array $additionalData Data tambahan yang diperlukan untuk reg_periksa
     * @return array
     */
    public function transferBookingToRegPeriksa(string $noBooking, array $additionalData = []): array
    {
        try {
            DB::beginTransaction();

            // 1. Ambil data booking
            $booking = BookingPeriksa::where('no_booking', $noBooking)->first();
            
            if (!$booking) {
                throw new Exception("Booking dengan nomor {$noBooking} tidak ditemukan");
            }

            // 2. Validasi status booking
            if (!in_array($booking->status, [
                BookingPeriksa::STATUS_DITERIMA,
                BookingPeriksa::STATUS_CHECK_IN,
                BookingPeriksa::STATUS_CHECKIN
            ])) {
                throw new Exception("Status booking harus 'Diterima', 'Check In', atau 'CheckIn' untuk dapat ditransfer");
            }

            // 3. Cari pasien berdasarkan NIK
            $pasien = null;
            if (!empty($booking->nik)) {
                $pasien = Pasien::getByNik($booking->nik);
            }

            if (!$pasien) {
                throw new Exception("Pasien dengan NIK {$booking->nik} belum terdaftar di SIMRS. Silakan daftarkan pasien terlebih dahulu.");
            }

            // 4. Cek apakah sudah ada registrasi pada tanggal yang sama
            $existingReg = RegPeriksa::where('no_rkm_medis', $pasien->no_rkm_medis)
                ->whereDate('tgl_registrasi', $booking->tanggal)
                ->where('kd_poli', $booking->kd_poli)
                ->first();

            if ($existingReg) {
                throw new Exception("Pasien sudah terdaftar pada tanggal {$booking->tanggal} di poli yang sama dengan nomor rawat {$existingReg->no_rawat}");
            }

            // 5. Generate nomor rawat dan nomor registrasi
            $noRawat = RegPeriksa::generateNoRawat($booking->tanggal);
            $noReg = RegPeriksa::generateNoReg($booking->tanggal);

            // 6. Mapping data dari booking ke reg_periksa
            $regData = $this->mapBookingToRegPeriksa($booking, $pasien, $noRawat, $noReg, $additionalData);

            // 7. Simpan data ke reg_periksa
            $regPeriksa = RegPeriksa::create($regData);

            // 8. Update status booking menjadi 'Check In' atau 'CheckIn'
            $booking->update([
                'status' => BookingPeriksa::STATUS_CHECKIN
            ]);

            DB::commit();

            Log::info("Transfer booking ke reg_periksa berhasil", [
                'no_booking' => $noBooking,
                'no_rawat' => $noRawat,
                'no_rkm_medis' => $pasien->no_rkm_medis
            ]);

            return [
                'success' => true,
                'message' => 'Transfer data berhasil',
                'data' => [
                    'no_rawat' => $noRawat,
                    'no_reg' => $noReg,
                    'no_rkm_medis' => $pasien->no_rkm_medis,
                    'nama_pasien' => $pasien->nm_pasien,
                    'tgl_registrasi' => $regPeriksa->tgl_registrasi,
                    'jam_reg' => $regPeriksa->jam_reg,
                    'poli' => $regPeriksa->poliklinik->nm_poli ?? '',
                    'dokter' => $regPeriksa->dokter->nm_dokter ?? ''
                ]
            ];

        } catch (Exception $e) {
            DB::rollBack();
            
            Log::error("Transfer booking ke reg_periksa gagal", [
                'no_booking' => $noBooking,
                'error' => $e->getMessage()
            ]);

            return [
                'success' => false,
                'message' => $e->getMessage()
            ];
        }
    }

    /**
     * Mapping data dari booking_periksa ke reg_periksa
     * 
     * @param BookingPeriksa $booking
     * @param Pasien $pasien
     * @param string $noRawat
     * @param string $noReg
     * @param array $additionalData
     * @return array
     */
    private function mapBookingToRegPeriksa(BookingPeriksa $booking, Pasien $pasien, string $noRawat, string $noReg, array $additionalData): array
    {
        // Hitung umur pasien saat registrasi
        $umurData = $this->calculateAge($pasien->tgl_lahir, $booking->tanggal);

        // Determine registration time based on booking data
        $jamReg = $additionalData['jam_reg'] ?? null;
        
        if (!$jamReg) {
            // Use the time from tanggal field (visit time) if available
            if ($booking->tanggal) {
                $jamReg = Carbon::parse($booking->tanggal)->format('H:i:s');
            } elseif ($booking->tanggal_booking) {
                // Fallback to tanggal_booking if tanggal is not available
                $jamReg = Carbon::parse($booking->tanggal_booking)->format('H:i:s');
            } else {
                // Final fallback to current server time
                $jamReg = Carbon::now('Asia/Jakarta')->format('H:i:s');
            }
        }

        // Use the visit date from booking, ensuring it's properly formatted
        $tglRegistrasi = $booking->tanggal ? Carbon::parse($booking->tanggal)->format('Y-m-d') : Carbon::now('Asia/Jakarta')->format('Y-m-d');

        return [
            'no_reg' => $noReg,
            'no_rawat' => $noRawat,
            'tgl_registrasi' => $tglRegistrasi,
            'jam_reg' => $jamReg,
            'kd_dokter' => $booking->kd_dokter,
            'no_rkm_medis' => $pasien->no_rkm_medis,
            'kd_poli' => $booking->kd_poli,
            'p_jawab' => $additionalData['p_jawab'] ?? $pasien->nm_pasien, // Default: nama pasien sendiri
            'almt_pj' => $additionalData['almt_pj'] ?? $pasien->alamat,
            'hubunganpj' => $additionalData['hubunganpj'] ?? 'DIRI SENDIRI',
            'biaya_reg' => $additionalData['biaya_reg'] ?? 0,
            'stts' => RegPeriksa::STATUS_BELUM,
            'stts_daftar' => $this->determineSttsDataftar($pasien->no_rkm_medis),
            'status_lanjut' => $additionalData['status_lanjut'] ?? RegPeriksa::STATUS_LANJUT_RALAN,
            'kd_pj' => $booking->kd_pj ?? 'BPJ', // Default BPJS jika tidak ada
            'umurdaftar' => $umurData['umur'],
            'sttsumur' => $umurData['satuan'],
            'status_bayar' => $additionalData['status_bayar'] ?? RegPeriksa::STATUS_BAYAR_BELUM,
            'status_poli' => $this->determineStatusPoli($pasien->no_rkm_medis, $booking->kd_poli)
        ];
    }

    /**
     * Hitung umur pasien
     * 
     * @param string $tglLahir
     * @param string $tglRegistrasi
     * @return array
     */
    private function calculateAge(string $tglLahir, string $tglRegistrasi): array
    {
        $lahir = Carbon::parse($tglLahir);
        $registrasi = Carbon::parse($tglRegistrasi);

        $diffInYears = $lahir->diffInYears($registrasi);
        $diffInMonths = $lahir->diffInMonths($registrasi);
        $diffInDays = $lahir->diffInDays($registrasi);

        if ($diffInYears > 0) {
            return [
                'umur' => $diffInYears,
                'satuan' => RegPeriksa::STTS_UMUR_TAHUN
            ];
        } elseif ($diffInMonths > 0) {
            return [
                'umur' => $diffInMonths,
                'satuan' => RegPeriksa::STTS_UMUR_BULAN
            ];
        } else {
            return [
                'umur' => $diffInDays,
                'satuan' => RegPeriksa::STTS_UMUR_HARI
            ];
        }
    }

    /**
     * Tentukan status daftar (Lama/Baru)
     * 
     * @param string $noRkmMedis
     * @return string
     */
    private function determineSttsDataftar(string $noRkmMedis): string
    {
        $existingReg = RegPeriksa::where('no_rkm_medis', $noRkmMedis)->first();
        
        return $existingReg ? RegPeriksa::STTS_DAFTAR_LAMA : RegPeriksa::STTS_DAFTAR_BARU;
    }

    /**
     * Tentukan status poli (Lama/Baru)
     * 
     * @param string $noRkmMedis
     * @param string $kdPoli
     * @return string
     */
    private function determineStatusPoli(string $noRkmMedis, string $kdPoli): string
    {
        $existingReg = RegPeriksa::where('no_rkm_medis', $noRkmMedis)
            ->where('kd_poli', $kdPoli)
            ->first();
        
        return $existingReg ? RegPeriksa::STATUS_POLI_LAMA : RegPeriksa::STATUS_POLI_BARU;
    }

    /**
     * Transfer multiple bookings sekaligus
     * 
     * @param array $bookingNumbers
     * @param array $additionalData
     * @return array
     */
    public function transferMultipleBookings(array $bookingNumbers, array $additionalData = []): array
    {
        $results = [];
        $successCount = 0;
        $failedCount = 0;

        foreach ($bookingNumbers as $noBooking) {
            $result = $this->transferBookingToRegPeriksa($noBooking, $additionalData);
            $results[] = [
                'no_booking' => $noBooking,
                'result' => $result
            ];

            if ($result['success']) {
                $successCount++;
            } else {
                $failedCount++;
            }
        }

        return [
            'success' => $failedCount === 0,
            'message' => "Transfer selesai. Berhasil: {$successCount}, Gagal: {$failedCount}",
            'summary' => [
                'total' => count($bookingNumbers),
                'success' => $successCount,
                'failed' => $failedCount
            ],
            'details' => $results
        ];
    }

    /**
     * Validasi data sebelum transfer
     * 
     * @param string $noBooking
     * @return array
     */
    public function validateBookingForTransfer(string $noBooking): array
    {
        $booking = BookingPeriksa::where('no_booking', $noBooking)->first();
        
        if (!$booking) {
            return [
                'valid' => false,
                'message' => "Booking dengan nomor {$noBooking} tidak ditemukan"
            ];
        }

        $errors = [];

        // Validasi status
        if (!in_array($booking->status, [
            BookingPeriksa::STATUS_DITERIMA,
            BookingPeriksa::STATUS_CHECK_IN,
            BookingPeriksa::STATUS_CHECKIN
        ])) {
            $errors[] = "Status booking harus 'Diterima', 'Check In', atau 'CheckIn'";
        }

        // Validasi NIK
        if (empty($booking->nik)) {
            $errors[] = "NIK pasien tidak boleh kosong";
        }

        // Validasi pasien terdaftar
        if (!empty($booking->nik)) {
            $pasien = Pasien::getByNik($booking->nik);
            if (!$pasien) {
                $errors[] = "Pasien dengan NIK {$booking->nik} belum terdaftar di SIMRS";
            }
        }

        // Validasi data wajib
        if (empty($booking->kd_dokter)) {
            $errors[] = "Kode dokter tidak boleh kosong";
        }

        if (empty($booking->kd_poli)) {
            $errors[] = "Kode poli tidak boleh kosong";
        }

        if (empty($booking->tanggal)) {
            $errors[] = "Tanggal booking tidak boleh kosong";
        }

        return [
            'valid' => empty($errors),
            'message' => empty($errors) ? 'Data valid untuk transfer' : implode(', ', $errors),
            'errors' => $errors
        ];
    }
}