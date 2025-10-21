<?php

namespace App\Http\Controllers;

use App\Models\RegPeriksa;
use App\Models\BookingPeriksa;
use App\Services\BookingToRegPeriksa;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\Rule;

class RegPeriksaController extends Controller
{
    protected $bookingToRegService;

    public function __construct(BookingToRegPeriksa $bookingToRegService)
    {
        $this->bookingToRegService = $bookingToRegService;
    }

    public function index(Request $request): JsonResponse
    {
        try {
            $query = RegPeriksa::with(['dokter', 'poliklinik', 'pasien', 'penjab']);

            
            if ($request->has('tanggal_dari') && $request->has('tanggal_sampai')) {
                $query->whereBetween('tgl_registrasi', [
                    $request->tanggal_dari,
                    $request->tanggal_sampai
                ]);
            } elseif ($request->has('tanggal')) {
                $query->whereDate('tgl_registrasi', $request->tanggal);
            }

            
            if ($request->has('kd_poli')) {
                $query->where('kd_poli', $request->kd_poli);
            }

            
            if ($request->has('kd_dokter')) {
                $query->where('kd_dokter', $request->kd_dokter);
            }

            
            if ($request->has('stts')) {
                $query->where('stts', $request->stts);
            }

            
            if ($request->has('search')) {
                $search = $request->search;
                $query->where(function($q) use ($search) {
                    $q->where('no_rawat', 'like', "%{$search}%")
                      ->orWhere('no_rkm_medis', 'like', "%{$search}%")
                      ->orWhereHas('pasien', function($pq) use ($search) {
                          $pq->where('nm_pasien', 'like', "%{$search}%");
                      });
                });
            }

            
            $perPage = $request->get('per_page', 15);
            $registrations = $query->orderBy('tgl_registrasi', 'desc')
                                  ->orderBy('jam_reg', 'desc')
                                  ->paginate($perPage);

            return response()->json([
                'success' => true,
                'data' => $registrations
            ]);

        } catch (\Exception $e) {
            Log::error('Error fetching reg_periksa data: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil data registrasi periksa'
            ], 500);
        }
    }

    public function store(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'tgl_registrasi' => 'required|date',
                'jam_reg' => 'nullable|date_format:H:i:s',
                'kd_dokter' => 'required|string|max:20',
                'no_rkm_medis' => 'required|string|max:15',
                'kd_poli' => 'required|string|max:5',
                'p_jawab' => 'nullable|string|max:100',
                'almt_pj' => 'nullable|string|max:200',
                'hubunganpj' => 'nullable|string|max:20',
                'biaya_reg' => 'nullable|numeric',
                'stts' => ['nullable', Rule::in(['Belum', 'Sudah', 'Batal', 'Berkas Diterima', 'Dirujuk', 'Meninggal', 'Dirawat', 'Pulang Paksa'])],
                'stts_daftar' => ['required', Rule::in(['-', 'Lama', 'Baru'])],
                'status_lanjut' => ['required', Rule::in(['Ralan', 'Ranap'])],
                'kd_pj' => 'required|string|max:3',
                'umurdaftar' => 'nullable|integer',
                'sttsumur' => ['nullable', Rule::in(['Th', 'Bl', 'Hr'])],
                'status_bayar' => ['required', Rule::in(['Sudah Bayar', 'Belum Bayar'])],
                'status_poli' => ['required', Rule::in(['Lama', 'Baru'])]
            ]);

            
            $validated['no_rawat'] = RegPeriksa::generateNoRawat($validated['tgl_registrasi']);
            $validated['no_reg'] = RegPeriksa::generateNoReg($validated['tgl_registrasi']);
            
            
            $validated['jam_reg'] = $validated['jam_reg'] ?? now()->format('H:i:s');
            $validated['stts'] = $validated['stts'] ?? RegPeriksa::STATUS_BELUM;

            $regPeriksa = RegPeriksa::create($validated);

            return response()->json([
                'success' => true,
                'message' => 'Registrasi periksa berhasil dibuat',
                'data' => $regPeriksa->load(['dokter', 'poliklinik', 'pasien', 'penjab'])
            ], 201);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Data tidak valid',
                'errors' => $e->errors()
            ], 422);

        } catch (\Exception $e) {
            Log::error('Error creating reg_periksa: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal membuat registrasi periksa'
            ], 500);
        }
    }

    public function show(string $noRawat): JsonResponse
    {
        try {
            $regPeriksa = RegPeriksa::with(['dokter', 'poliklinik', 'pasien', 'penjab'])
                                   ->where('no_rawat', $noRawat)
                                   ->first();

            if (!$regPeriksa) {
                return response()->json([
                    'success' => false,
                    'message' => 'Registrasi periksa tidak ditemukan'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'data' => $regPeriksa
            ]);

        } catch (\Exception $e) {
            Log::error('Error fetching reg_periksa: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengambil data registrasi periksa'
            ], 500);
        }
    }

    public function update(Request $request, string $noRawat): JsonResponse
    {
        try {
            $regPeriksa = RegPeriksa::where('no_rawat', $noRawat)->first();

            if (!$regPeriksa) {
                return response()->json([
                    'success' => false,
                    'message' => 'Registrasi periksa tidak ditemukan'
                ], 404);
            }

            $validated = $request->validate([
                'tgl_registrasi' => 'sometimes|date',
                'jam_reg' => 'sometimes|date_format:H:i:s',
                'kd_dokter' => 'sometimes|string|max:20',
                'no_rkm_medis' => 'sometimes|string|max:15',
                'kd_poli' => 'sometimes|string|max:5',
                'p_jawab' => 'nullable|string|max:100',
                'almt_pj' => 'nullable|string|max:200',
                'hubunganpj' => 'nullable|string|max:20',
                'biaya_reg' => 'nullable|numeric',
                'stts' => ['nullable', Rule::in(['Belum', 'Sudah', 'Batal', 'Berkas Diterima', 'Dirujuk', 'Meninggal', 'Dirawat', 'Pulang Paksa'])],
                'stts_daftar' => ['sometimes', Rule::in(['-', 'Lama', 'Baru'])],
                'status_lanjut' => ['sometimes', Rule::in(['Ralan', 'Ranap'])],
                'kd_pj' => 'sometimes|string|max:3',
                'umurdaftar' => 'nullable|integer',
                'sttsumur' => ['nullable', Rule::in(['Th', 'Bl', 'Hr'])],
                'status_bayar' => ['sometimes', Rule::in(['Sudah Bayar', 'Belum Bayar'])],
                'status_poli' => ['sometimes', Rule::in(['Lama', 'Baru'])]
            ]);

            $regPeriksa->update($validated);

            return response()->json([
                'success' => true,
                'message' => 'Registrasi periksa berhasil diupdate',
                'data' => $regPeriksa->load(['dokter', 'poliklinik', 'pasien', 'penjab'])
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Data tidak valid',
                'errors' => $e->errors()
            ], 422);

        } catch (\Exception $e) {
            Log::error('Error updating reg_periksa: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mengupdate registrasi periksa'
            ], 500);
        }
    }

    public function destroy(string $noRawat): JsonResponse
    {
        try {
            $regPeriksa = RegPeriksa::where('no_rawat', $noRawat)->first();

            if (!$regPeriksa) {
                return response()->json([
                    'success' => false,
                    'message' => 'Registrasi periksa tidak ditemukan'
                ], 404);
            }

            $regPeriksa->delete();

            return response()->json([
                'success' => true,
                'message' => 'Registrasi periksa berhasil dihapus'
            ]);

        } catch (\Exception $e) {
            Log::error('Error deleting reg_periksa: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal menghapus registrasi periksa'
            ], 500);
        }
    }

    public function transferFromBooking(Request $request, string $noBooking): JsonResponse
    {
        try {
            $validated = $request->validate([
                'jam_reg' => 'nullable|date_format:H:i:s',
                'p_jawab' => 'nullable|string|max:100',
                'almt_pj' => 'nullable|string|max:200',
                'hubunganpj' => 'nullable|string|max:20',
                'biaya_reg' => 'nullable|numeric',
                'status_lanjut' => ['nullable', Rule::in(['Ralan', 'Ranap'])],
                'status_bayar' => ['nullable', Rule::in(['Sudah Bayar', 'Belum Bayar'])]
            ]);

            $result = $this->bookingToRegService->transferBookingToRegPeriksa($noBooking, $validated);

            if ($result['success']) {
                return response()->json($result, 201);
            } else {
                return response()->json($result, 422);
            }

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Data tidak valid',
                'errors' => $e->errors()
            ], 422);

        } catch (\Exception $e) {
            Log::error('Error transferring booking to reg_periksa: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mentransfer booking ke registrasi periksa'
            ], 500);
        }
    }

    public function transferMultipleBookings(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'booking_numbers' => 'required|array|min:1',
                'booking_numbers.*' => 'required|string',
                'jam_reg' => 'nullable|date_format:H:i:s',
                'p_jawab' => 'nullable|string|max:100',
                'almt_pj' => 'nullable|string|max:200',
                'hubunganpj' => 'nullable|string|max:20',
                'biaya_reg' => 'nullable|numeric',
                'status_lanjut' => ['nullable', Rule::in(['Ralan', 'Ranap'])],
                'status_bayar' => ['nullable', Rule::in(['Sudah Bayar', 'Belum Bayar'])]
            ]);

            $additionalData = collect($validated)->except('booking_numbers')->toArray();
            
            $result = $this->bookingToRegService->transferMultipleBookings(
                $validated['booking_numbers'], 
                $additionalData
            );

            return response()->json($result);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Data tidak valid',
                'errors' => $e->errors()
            ], 422);

        } catch (\Exception $e) {
            Log::error('Error transferring multiple bookings: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal mentransfer multiple booking'
            ], 500);
        }
    }

    public function validateBookingForTransfer(string $noBooking): JsonResponse
    {
        try {
            $result = $this->bookingToRegService->validateBookingForTransfer($noBooking);

            return response()->json([
                'success' => true,
                'data' => $result
            ]);

        } catch (\Exception $e) {
            Log::error('Error validating booking: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Gagal memvalidasi booking'
            ], 500);
        }
    }
}