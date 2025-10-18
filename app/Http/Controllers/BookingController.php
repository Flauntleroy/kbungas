<?php

namespace App\Http\Controllers;

use App\Models\BookingPeriksa;
use App\Models\Dokter;
use App\Models\Poliklinik;
use App\Models\Penjab;
use App\Services\WhatsAppService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\Rule;
use Carbon\Carbon;

class BookingController extends Controller
{
    protected $whatsAppService;

    public function __construct(WhatsAppService $whatsAppService)
    {
        $this->whatsAppService = $whatsAppService;
    }

    /**
     * Get booking form data (dokter, poliklinik, penjab)
     */
    public function getFormData(): JsonResponse
    {
        try {
            $data = [
                'dokter' => Dokter::getForSelect(),
                'poliklinik' => Poliklinik::getForSelect(),
                'penjab' => Penjab::getForSelect(),
            ];

            return response()->json([
                'success' => true,
                'data' => $data
            ]);
        } catch (\Exception $e) {
            Log::error('Error getting booking form data: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil data formulir'
            ], 500);
        }
    }

    /**
     * Store new booking
     */
    public function store(Request $request): JsonResponse
    {
        try {
            // Validasi input
            $validated = $request->validate([
                'nik' => 'required|string|size:16|regex:/^[0-9]{16}$/',
                'nomor_kartu' => 'nullable|string|max:13',
                'nama' => 'required|string|max:40',
                'tanggal' => 'required|date|after_or_equal:today',
                'alamat' => 'nullable|string|max:200',
                'no_telp' => 'required|string|max:40',
                'email' => 'nullable|email|max:50',
                'kd_poli' => 'required|string|exists:poliklinik,kd_poli',
                'kd_dokter' => 'required|string|exists:dokter,kd_dokter',
                'kd_pj' => 'required|string|exists:penjab,kd_pj',
                'catatan' => 'nullable|string|max:255',
            ]);

            // Cek apakah sudah ada booking dengan NIK dan tanggal yang sama
            $existingBooking = BookingPeriksa::where('nik', $validated['nik'])
                ->whereDate('tanggal', $validated['tanggal'])
                ->whereIn('status', [
                    BookingPeriksa::STATUS_DITERIMA,
                    BookingPeriksa::STATUS_BELUM_DIBALAS
                ])
                ->first();

            if ($existingBooking) {
                return response()->json([
                    'success' => false,
                    'message' => 'Anda sudah memiliki booking pada tanggal tersebut dengan status ' . $existingBooking->status
                ], 422);
            }

            // Cek kapasitas dokter pada tanggal tersebut (maksimal 20 booking per hari)
            $bookingCount = BookingPeriksa::where('kd_dokter', $validated['kd_dokter'])
                ->whereDate('tanggal', $validated['tanggal'])
                ->whereIn('status', [
                    BookingPeriksa::STATUS_DITERIMA,
                    BookingPeriksa::STATUS_BELUM_DIBALAS,
                    BookingPeriksa::STATUS_CHECK_IN,
                    BookingPeriksa::STATUS_CHECKIN
                ])
                ->count();

            if ($bookingCount >= 20) {
                return response()->json([
                    'success' => false,
                    'message' => 'Kuota booking untuk dokter pada tanggal tersebut sudah penuh'
                ], 422);
            }

            DB::beginTransaction();

            // Generate nomor booking
            $noBooking = BookingPeriksa::generateBookingNumber();

            // Buat booking baru
            $booking = BookingPeriksa::create([
                'no_booking' => $noBooking,
                'nik' => $validated['nik'],
                'nomor_kartu' => $validated['nomor_kartu'],
                'nama' => $validated['nama'],
                'tanggal' => $validated['tanggal'],
                'alamat' => $validated['alamat'],
                'no_telp' => $validated['no_telp'],
                'email' => $validated['email'],
                'kd_poli' => $validated['kd_poli'],
                'kd_dokter' => $validated['kd_dokter'],
                'kd_pj' => $validated['kd_pj'],
                'status' => BookingPeriksa::STATUS_BELUM_DIBALAS,
                'catatan' => $validated['catatan'],
                'tanggal_booking' => Carbon::now(),
            ]);

            // Load relasi untuk response
            $booking->load(['poliklinik', 'dokter', 'penjab']);

            DB::commit();

            // Kirim notifikasi WhatsApp setelah booking berhasil
            $this->sendWhatsAppNotifications($booking);

            return response()->json([
                'success' => true,
                'message' => 'Booking berhasil dibuat',
                'data' => [
                    'no_booking' => $booking->no_booking,
                    'nama' => $booking->nama,
                    'tanggal' => $booking->tanggal_formatted,
                    'dokter' => $booking->dokter->nm_dokter,
                    'poliklinik' => $booking->poliklinik->nm_poli,
                    'status' => $booking->status
                ]
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Data tidak valid',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error creating booking: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat membuat booking'
            ], 500);
        }
    }

    /**
     * Get booking by NIK
     */
    public function getByNik(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'nik' => 'required|string|size:16|regex:/^[0-9]{16}$/'
            ]);

            $bookings = BookingPeriksa::where('nik', $request->nik)
                ->with(['poliklinik', 'dokter', 'penjab'])
                ->orderBy('tanggal_booking', 'desc')
                ->get();

            return response()->json([
                'success' => true,
                'data' => $bookings->map(function ($booking) {
                    return [
                        'no_booking' => $booking->no_booking,
                        'nama' => $booking->nama,
                        'tanggal' => $booking->tanggal_formatted,
                        'tanggal_booking' => $booking->tanggal_booking_formatted,
                        'dokter' => $booking->dokter->nm_dokter,
                        'poliklinik' => $booking->poliklinik->nm_poli,
                        'penjab' => $booking->penjab->png_jawab,
                        'status' => $booking->status,
                        'status_badge_class' => $booking->status_badge_class,
                        'catatan' => $booking->catatan
                    ];
                })
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'NIK tidak valid',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Error getting booking by NIK: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil data booking'
            ], 500);
        }
    }

    /**
     * Get booking by booking number
     */
    public function getByBookingNumber(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'no_booking' => 'required|string'
            ]);

            $booking = BookingPeriksa::where('no_booking', $request->no_booking)
                ->with(['poliklinik', 'dokter', 'penjab'])
                ->first();

            if (!$booking) {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking tidak ditemukan'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => [
                    'no_booking' => $booking->no_booking,
                    'nik' => $booking->nik,
                    'nomor_kartu' => $booking->nomor_kartu,
                    'nama' => $booking->nama,
                    'tanggal' => $booking->tanggal_formatted,
                    'tanggal_booking' => $booking->tanggal_booking_formatted,
                    'alamat' => $booking->alamat,
                    'no_telp' => $booking->no_telp,
                    'email' => $booking->email,
                    'dokter' => $booking->dokter->nm_dokter,
                    'poliklinik' => $booking->poliklinik->nm_poli,
                    'penjab' => $booking->penjab->png_jawab,
                    'status' => $booking->status,
                    'status_badge_class' => $booking->status_badge_class,
                    'catatan' => $booking->catatan
                ]
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Nomor booking tidak valid',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Error getting booking by number: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil data booking'
            ], 500);
        }
    }

    /**
     * Update booking status
     */
    public function updateStatus(Request $request, $noBooking): JsonResponse
    {
        try {
            $validated = $request->validate([
                'status' => [
                    'required',
                    'string',
                    Rule::in([
                        BookingPeriksa::STATUS_DITERIMA,
                        BookingPeriksa::STATUS_DITOLAK,
                        BookingPeriksa::STATUS_BELUM_DIBALAS,
                        BookingPeriksa::STATUS_CHECK_IN,
                        BookingPeriksa::STATUS_CHECKIN
                    ])
                ],
                'catatan' => 'nullable|string|max:255'
            ]);

            $booking = BookingPeriksa::where('no_booking', $noBooking)->first();

            if (!$booking) {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking tidak ditemukan'
                ], 404);
            }

            if (!$booking->canChangeStatus()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Status booking tidak dapat diubah'
                ], 422);
            }

            $booking->updateStatus($validated['status'], $validated['catatan'] ?? null);

            return response()->json([
                'success' => true,
                'message' => 'Status booking berhasil diperbarui',
                'data' => [
                    'no_booking' => $booking->no_booking,
                    'status' => $booking->status,
                    'catatan' => $booking->catatan
                ]
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Data tidak valid',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Error updating booking status: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal memperbarui status booking'
            ], 500);
        }
    }

    /**
     * Confirm booking by doctor via WhatsApp link
     */
    public function confirmBooking(Request $request, $token): JsonResponse
    {
        try {
            // Rate limiting untuk mencegah spam
            $clientIp = $request->ip();
            $rateLimitKey = "booking_confirm:{$clientIp}";
            
            if (cache()->has($rateLimitKey)) {
                $attempts = cache()->get($rateLimitKey, 0);
                if ($attempts >= 5) { // Maksimal 5 percobaan per IP per menit
                    Log::warning('Rate limit exceeded for booking confirmation', ['ip' => $clientIp]);
                    return response()->json([
                        'success' => false,
                        'message' => 'Terlalu banyak percobaan. Silakan coba lagi dalam 1 menit.'
                    ], 429);
                }
                cache()->put($rateLimitKey, $attempts + 1, 60); // 60 detik
            } else {
                cache()->put($rateLimitKey, 1, 60);
            }

            // Decode token untuk mendapatkan booking ID dan validasi keamanan
            $decodedData = $this->decodeConfirmationToken($token);
            
            if (!$decodedData) {
                return response()->json([
                    'success' => false,
                    'message' => 'Token konfirmasi tidak valid atau sudah kedaluwarsa'
                ], 400);
            }

            $booking = BookingPeriksa::where('no_booking', $decodedData['booking_id'])->first();

            if (!$booking) {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking tidak ditemukan'
                ], 404);
            }

            // Validasi bahwa dokter yang mengonfirmasi sesuai dengan booking
            if ($booking->kd_dokter !== $decodedData['doctor_id']) {
                Log::warning('Unauthorized confirmation attempt', [
                    'booking_id' => $booking->no_booking,
                    'expected_doctor' => $booking->kd_dokter,
                    'attempted_doctor' => $decodedData['doctor_id'],
                    'ip' => $clientIp
                ]);
                return response()->json([
                    'success' => false,
                    'message' => 'Anda tidak memiliki akses untuk mengonfirmasi booking ini'
                ], 403);
            }

            // Cek apakah booking masih bisa dikonfirmasi
            if (!in_array($booking->status, [BookingPeriksa::STATUS_BELUM_DIBALAS])) {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking sudah dikonfirmasi sebelumnya atau tidak dapat dikonfirmasi',
                    'current_status' => $booking->status
                ], 422);
            }

            // Update status booking menjadi diterima tanpa mengubah catatan
            $booking->updateStatus(BookingPeriksa::STATUS_DITERIMA);

            // Log konfirmasi yang berhasil
            Log::info('Booking confirmed successfully', [
                'booking_id' => $booking->no_booking,
                'doctor_id' => $booking->kd_dokter,
                'patient_name' => $booking->nama,
                'confirmed_at' => now(),
                'ip' => $clientIp
            ]);

            // Kirim notifikasi konfirmasi ke pasien
            $this->sendConfirmationNotificationToPatient($booking);

            return response()->json([
                'success' => true,
                'message' => 'Booking berhasil dikonfirmasi! Pasien akan mendapat notifikasi.',
                'data' => [
                    'no_booking' => $booking->no_booking,
                    'status' => $booking->status,
                    'patient_name' => $booking->nama,
                    'appointment_date' => Carbon::parse($booking->tanggal)->format('d/m/Y H:i'),
                    'confirmed_at' => now()->format('d/m/Y H:i')
                ]
            ]);

        } catch (\Exception $e) {
            Log::error('Error confirming booking: ' . $e->getMessage(), [
                'token' => substr($token, 0, 20) . '...',
                'ip' => $request->ip()
            ]);
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengonfirmasi booking. Silakan coba lagi.'
            ], 500);
        }
    }

    /**
     * Decode and validate confirmation token
     */
    private function decodeConfirmationToken($token)
    {
        try {
            // Decode base64 token
            $decoded = base64_decode($token);
            $data = json_decode($decoded, true);

            if (!$data || !isset($data['booking_id'], $data['doctor_id'], $data['expires_at'], $data['hash'])) {
                Log::warning('Invalid token structure', ['token' => substr($token, 0, 20) . '...']);
                return false;
            }

            // Cek apakah token sudah kedaluwarsa (24 jam)
            if (Carbon::parse($data['expires_at'])->isPast()) {
                Log::warning('Expired token', ['booking_id' => $data['booking_id'], 'expires_at' => $data['expires_at']]);
                return false;
            }

            // Validasi hash untuk memastikan integritas token
            $salt = config('app.key') . date('Y-m-d');
            $expectedHash = hash('sha256', $data['booking_id'] . $data['doctor_id'] . $salt);
            
            if (!hash_equals($expectedHash, $data['hash'])) {
                // Coba dengan salt hari sebelumnya (untuk token yang dibuat menjelang tengah malam)
                $yesterdaySalt = config('app.key') . date('Y-m-d', strtotime('-1 day'));
                $yesterdayHash = hash('sha256', $data['booking_id'] . $data['doctor_id'] . $yesterdaySalt);
                
                if (!hash_equals($yesterdayHash, $data['hash'])) {
                    Log::warning('Invalid token hash', ['booking_id' => $data['booking_id']]);
                    return false;
                }
            }

            // Validasi tambahan: pastikan booking dan dokter masih ada di database
            $booking = BookingPeriksa::where('no_booking', $data['booking_id'])
                                   ->where('kd_dokter', $data['doctor_id'])
                                   ->first();
            
            if (!$booking) {
                Log::warning('Booking not found for token', ['booking_id' => $data['booking_id'], 'doctor_id' => $data['doctor_id']]);
                return false;
            }

            return $data;
        } catch (\Exception $e) {
            Log::error('Error decoding confirmation token: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Send confirmation notification to patient
     */
    private function sendConfirmationNotificationToPatient($booking)
    {
        try {
            if (empty($booking->no_telp)) {
                Log::warning("Tidak dapat mengirim notifikasi konfirmasi: nomor telepon pasien kosong untuk booking {$booking->no_booking}");
                return;
            }

            $message = "BOOKING DIKONFIRMASI - KLINIK BUNGAS\n\n" .
                      "Halo {$booking->nama},\n\n" .
                      "Booking Anda telah Diterima oleh Dokter kami:\n\n" .
                      "Dokter: {$booking->dokter->nm_dokter}\n" .
                      "Tanggal: " . Carbon::parse($booking->tanggal)->format('d/m/Y H:i') . "\n" .
                      "Status: DITERIMA\n\n" .
                      "Silakan datang 15 menit sebelum jadwal konsultasi.\n" .
                      "Terima kasih telah mempercayai R'Bungas! 🙏";

            $result = $this->whatsAppService->sendMessage($booking->no_telp, $message);
            
            if ($result['success']) {
                Log::info("Notifikasi konfirmasi berhasil dikirim ke pasien {$booking->nama} ({$booking->no_telp}) untuk booking {$booking->no_booking}");
            } else {
                Log::error("Gagal mengirim notifikasi konfirmasi ke pasien {$booking->nama}: " . $result['message']);
            }
        } catch (\Exception $e) {
            Log::error("Error sending confirmation notification to patient: " . $e->getMessage());
        }
    }

    /**
     * Get available time slots for a doctor on a specific date
     */
    public function getAvailableSlots(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'kd_dokter' => 'required|string|exists:dokter,kd_dokter',
                'tanggal' => 'required|date|after_or_equal:today'
            ]);

            // Slot waktu yang tersedia (bisa disesuaikan dengan jadwal dokter)
            $allSlots = [
                '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
                '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30'
            ];

            // Ambil booking yang sudah ada pada tanggal tersebut
            $bookedSlots = BookingPeriksa::where('kd_dokter', $validated['kd_dokter'])
                ->whereDate('tanggal', $validated['tanggal'])
                ->whereIn('status', [
                    BookingPeriksa::STATUS_DITERIMA,
                    BookingPeriksa::STATUS_BELUM_DIBALAS,
                    BookingPeriksa::STATUS_CHECK_IN,
                    BookingPeriksa::STATUS_CHECKIN
                ])
                ->pluck('tanggal')
                ->map(function ($datetime) {
                    return Carbon::parse($datetime)->format('H:i');
                })
                ->toArray();

            // Filter slot yang masih tersedia
            $availableSlots = array_diff($allSlots, $bookedSlots);

            return response()->json([
                'success' => true,
                'data' => [
                    'available_slots' => array_values($availableSlots),
                    'booked_slots' => $bookedSlots,
                    'total_available' => count($availableSlots)
                ]
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Data tidak valid',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Error getting available slots: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil slot waktu'
            ], 500);
        }
    }

    /**
     * Get booking statistics
     */
    public function getStatistics(): JsonResponse
    {
        try {
            $today = Carbon::today();
            $thisMonth = Carbon::now()->startOfMonth();

            $stats = [
                'today' => [
                    'total' => BookingPeriksa::whereDate('tanggal', $today)->count(),
                    'diterima' => BookingPeriksa::whereDate('tanggal', $today)
                        ->where('status', BookingPeriksa::STATUS_DITERIMA)->count(),
                    'belum_dibalas' => BookingPeriksa::whereDate('tanggal', $today)
                        ->where('status', BookingPeriksa::STATUS_BELUM_DIBALAS)->count(),
                ],
                'this_month' => [
                    'total' => BookingPeriksa::where('tanggal_booking', '>=', $thisMonth)->count(),
                    'diterima' => BookingPeriksa::where('tanggal_booking', '>=', $thisMonth)
                        ->where('status', BookingPeriksa::STATUS_DITERIMA)->count(),
                    'ditolak' => BookingPeriksa::where('tanggal_booking', '>=', $thisMonth)
                        ->where('status', BookingPeriksa::STATUS_DITOLAK)->count(),
                ]
            ];

            return response()->json([
                'success' => true,
                'data' => $stats
            ]);

        } catch (\Exception $e) {
            Log::error('Error getting booking statistics: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil statistik booking'
            ], 500);
        }
    }

    /**
     * Kirim notifikasi WhatsApp ke pasien dan dokter
     */
    private function sendWhatsAppNotifications($booking)
    {
        try {
            // Kirim notifikasi ke pasien
            if (!empty($booking->no_telp)) {
                $patientResult = $this->whatsAppService->sendBookingConfirmationToPatient($booking);
                
                Log::info('WhatsApp notification to patient', [
                    'booking_id' => $booking->no_booking,
                    'patient_phone' => $booking->no_telp,
                    'success' => $patientResult['success'],
                    'message' => $patientResult['message']
                ]);
            } else {
                Log::warning('Patient phone number is empty', [
                    'booking_id' => $booking->no_booking,
                    'patient_name' => $booking->nama
                ]);
            }

            // Kirim notifikasi ke dokter
            if (!empty($booking->dokter->no_telp)) {
                $doctorResult = $this->whatsAppService->sendBookingNotificationToDoctor($booking);
                
                Log::info('WhatsApp notification to doctor', [
                    'booking_id' => $booking->no_booking,
                    'doctor_phone' => $booking->dokter->no_telp,
                    'doctor_name' => $booking->dokter->nm_dokter,
                    'success' => $doctorResult['success'],
                    'message' => $doctorResult['message']
                ]);
            } else {
                Log::warning('Doctor phone number is empty', [
                    'booking_id' => $booking->no_booking,
                    'doctor_name' => $booking->dokter->nm_dokter
                ]);
            }

        } catch (\Exception $e) {
            Log::error('Error sending WhatsApp notifications', [
                'booking_id' => $booking->no_booking,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
        }
    }
}