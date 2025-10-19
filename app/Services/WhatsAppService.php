<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Exception;

class WhatsAppService
{
    private $apiUrl;
    private $token;

    public function __construct()
    {
        $this->apiUrl = 'https://api.fonnte.com/send';
        $this->token = 'nFi7goGNVJiG25gCbL7k';
    }

    /**
     * Kirim pesan WhatsApp
     */
    public function sendMessage($phoneNumber, $message, $type = 'text')
    {
        try {
            // Format nomor telepon (hapus karakter non-digit dan tambahkan 62 jika perlu)
            $formattedPhone = $this->formatPhoneNumber($phoneNumber);
            
            if (!$formattedPhone) {
                throw new Exception('Nomor telepon tidak valid: ' . $phoneNumber);
            }

            $payload = [
                'target' => $formattedPhone,
                'message' => $message,
                'type' => $type,
            ];

            Log::info('WhatsApp: Mengirim pesan', [
                'phone' => $formattedPhone,
                'message_length' => strlen($message),
                'type' => $type
            ]);

            $response = Http::withHeaders([
                'Authorization' => $this->token,
            ])->post($this->apiUrl, $payload);

            $responseData = $response->json();

            if ($response->successful() && isset($responseData['status']) && $responseData['status']) {
                Log::info('WhatsApp: Pesan berhasil dikirim', [
                    'phone' => $formattedPhone,
                    'response' => $responseData
                ]);

                return [
                    'success' => true,
                    'message' => 'Pesan WhatsApp berhasil dikirim',
                    'data' => $responseData
                ];
            } else {
                $errorMessage = $responseData['reason'] ?? 'Gagal mengirim pesan WhatsApp';
                
                Log::error('WhatsApp: Gagal mengirim pesan', [
                    'phone' => $formattedPhone,
                    'error' => $errorMessage,
                    'response' => $responseData
                ]);

                return [
                    'success' => false,
                    'message' => $errorMessage,
                    'data' => $responseData
                ];
            }

        } catch (Exception $e) {
            Log::error('WhatsApp: Exception saat mengirim pesan', [
                'phone' => $phoneNumber,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);

            return [
                'success' => false,
                'message' => 'Terjadi kesalahan: ' . $e->getMessage(),
                'data' => null
            ];
        }
    }

    /**
     * Kirim notifikasi booking ke pasien
     */
    public function sendBookingConfirmationToPatient($booking)
    {
        $message = $this->generatePatientMessage($booking);
        return $this->sendMessage($booking->no_telp, $message);
    }

    /**
     * Kirim notifikasi booking ke dokter
     */
    public function sendBookingNotificationToDoctor($booking)
    {
        $message = $this->generateDoctorMessage($booking);
        return $this->sendMessage($booking->dokter->no_telp, $message);
    }

    /**
     * Kirim notifikasi penerimaan booking ke pasien
     */
    public function sendBookingAcceptanceNotification($booking)
    {
        $message = $this->generateAcceptanceMessage($booking);
        return $this->sendMessage($booking->no_telp, $message);
    }

    /**
     * Generate pesan untuk pasien
     */
    private function generatePatientMessage($booking)
    {
        return "*KONFIRMASI BOOKING KLINIK BUNGAS*\n\n" .
               "Halo {$booking->nama},\n\n" .
               "Booking Anda telah berhasil diterima dengan detail:\n\n" .
               "*No. Booking:* {$booking->no_booking}\n" .
               "*Nama:* {$booking->nama}\n" .
               "*Tanggal:* {$booking->tanggal_formatted}\n" .
               "*Dokter:* {$booking->dokter->nm_dokter}\n" .
               "*Status:* {$booking->status}\n\n" .
               "Kami akan segera menghubungi Anda untuk konfirmasi booking.\n\n" .
               "Terima kasih telah mempercayai Klinik Bungas! 🙏";
    }

    /**
     * Generate pesan untuk dokter
     */
    private function generateDoctorMessage($booking)
    {
        // Generate token konfirmasi untuk dokter
        $confirmationToken = $this->generateConfirmationToken($booking->no_booking, $booking->kd_dokter);
        $confirmationUrl = url("/booking/confirm/{$confirmationToken}");
        
        return "*NOTIFIKASI BOOKING BARU - KLINIK BUNGAS*\n\n" .
               "Dokter {$booking->dokter->nm_dokter},\n\n" .
               "Anda memiliki booking baru dengan detail:\n\n" .
               "*No. Booking:* {$booking->no_booking}\n" .
               "*Nama Pasien:* {$booking->nama}\n" .
               "*No. Telepon:* {$booking->no_telp}\n" .
               "*Tanggal Konsultasi:* {$booking->tanggal_formatted}\n" .
               ($booking->catatan ? "*Catatan/Keluhan:* {$booking->catatan}\n" : "") .
               "*Status:* {$booking->status}\n\n" .

               " *KONFIRMASI BOOKING:*\n" .
               "Klik link berikut untuk MENERIMA booking ini :\n" .
               "{$confirmationUrl}\n\n" .
               "⚠️ *Perhatian:*\n" .
               "• Link berlaku selama 24 jam\n" .
               "• Setelah dikonfirmasi, pasien akan mendapat notifikasi otomatis\n" .
               "R'Bungas ";
    }

    /**
     * Generate pesan penerimaan booking untuk pasien
     */
    private function generateAcceptanceMessage($booking)
    {
        return "*BOOKING DITERIMA - KLINIK BUNGAS* ✅\n\n" .
               "Halo {$booking->nama},\n\n" .
               "Kabar baik! Booking Anda telah *DITERIMA* oleh dokter.\n\n" .
               "*Detail Booking:*\n" .
               "📋 *No. Booking:* {$booking->no_booking}\n" .
               "👤 *Nama:* {$booking->nama}\n" .
               "📅 *Tanggal:* {$booking->tanggal_formatted}\n" .
               "👨‍⚕️ *Dokter:* {$booking->dokter->nm_dokter}\n" .
               "🏥 *Poliklinik:* {$booking->poliklinik->nm_poli}\n" .
               "✅ *Status:* DITERIMA\n\n" .
               "📍 *Alamat Klinik:*\n" .
               "Jl. Contoh No. 123, Kota Anda\n\n" .
               "⏰ *Harap datang 15 menit sebelum jadwal*\n" .
               "📋 *Bawa dokumen:* KTP, Kartu BPJS (jika ada)\n\n" .
               "Jika ada pertanyaan, silakan hubungi kami.\n\n" .
               "Terima kasih telah mempercayai Klinik Bungas! 🙏\n\n" .
               "_Pesan otomatis dari Sistem Klinik Bungas_";
    }

    /**
     * Format nomor telepon ke format internasional
     */
    private function formatPhoneNumber($phoneNumber)
    {
        if (empty($phoneNumber)) {
            return null;
        }

        // Hapus semua karakter non-digit
        $phone = preg_replace('/[^0-9]/', '', $phoneNumber);

        // Jika nomor dimulai dengan 0, ganti dengan 62
        if (substr($phone, 0, 1) === '0') {
            $phone = '62' . substr($phone, 1);
        }
        // Jika nomor dimulai dengan 8, tambahkan 62
        elseif (substr($phone, 0, 1) === '8') {
            $phone = '62' . $phone;
        }
        // Jika nomor sudah dimulai dengan 62, biarkan
        elseif (substr($phone, 0, 2) !== '62') {
            // Jika tidak dimulai dengan 62, 0, atau 8, anggap tidak valid
            return null;
        }

        // Validasi panjang nomor (minimal 10 digit setelah 62)
        if (strlen($phone) < 12 || strlen($phone) > 15) {
            return null;
        }

        return $phone;
    }

    /**
     * Cek status koneksi ke API Fonnte
     */
    public function checkConnection()
    {
        try {
            // Gunakan endpoint yang benar untuk validasi token
            $response = Http::withHeaders([
                'Authorization' => $this->token,
            ])->post('https://api.fonnte.com/validate');

            if ($response->successful()) {
                $responseData = $response->json();
                return [
                    'success' => true,
                    'message' => 'Koneksi ke Fonnte API berhasil',
                    'data' => $responseData
                ];
            } else {
                $responseData = $response->json();
                return [
                    'success' => false,
                    'message' => 'Gagal terhubung ke Fonnte API: ' . ($responseData['reason'] ?? 'Unknown error'),
                    'data' => $responseData
                ];
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error koneksi: ' . $e->getMessage(),
                'data' => null
            ];
        }
    }

    /**
     * Generate secure confirmation token for booking
     */
    private function generateConfirmationToken($bookingId, $doctorId)
    {
        // Tambahkan salt untuk keamanan ekstra
        $salt = config('app.key') . date('Y-m-d'); // Salt berubah setiap hari
        
        $data = [
            'booking_id' => $bookingId,
            'doctor_id' => $doctorId,
            'expires_at' => now()->addHours(24)->toISOString(), // Token berlaku 24 jam
            'created_at' => now()->toISOString(),
            'hash' => hash('sha256', $bookingId . $doctorId . $salt) // Hash untuk validasi integritas
        ];

        // Encode data sebagai JSON kemudian base64
        $jsonData = json_encode($data);
        $token = base64_encode($jsonData);

        return $token;
    }
}