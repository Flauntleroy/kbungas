<?php

namespace App\Http\Controllers;

use App\Models\Pasien;
use App\Models\BookingPeriksa;
use App\Services\BpjsService;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Carbon\Carbon;

class PasienController extends Controller
{
    protected $bpjsService;

    public function __construct(BpjsService $bpjsService)
    {
        $this->bpjsService = $bpjsService;
    }

    /**
     * Validate NIK and check if patient exists
     */
    public function validateNik(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'nik' => 'required|string|min:16|max:16'
            ]);

            $nik = $request->nik;

            // Check if NIK exists in pasien table
            $existingPatient = Pasien::getByNik($nik);

            if ($existingPatient) {
                return response()->json([
                    'success' => true,
                    'exists' => true,
                    'patient' => [
                        'no_rkm_medis' => $existingPatient->no_rkm_medis,
                        'nama' => $existingPatient->nm_pasien,
                        'nik' => $existingPatient->no_ktp,
                        'jk' => $existingPatient->jk,
                        'tgl_lahir' => $existingPatient->tgl_lahir,
                        'alamat' => $existingPatient->alamat,
                        'no_tlp' => $existingPatient->no_tlp,
                        'email' => $existingPatient->email
                    ]
                ]);
            }

            // If NIK doesn't exist, try to get data from BPJS
            try {
                $bpjsData = $this->bpjsService->getPatientByNik($nik);
                
                if ($bpjsData && isset($bpjsData['response'])) {
                    return response()->json([
                        'success' => true,
                        'exists' => false,
                        'bpjs_data' => $bpjsData['response'],
                        'message' => 'NIK belum terdaftar. Data BPJS ditemukan, silakan lengkapi form pendaftaran.'
                    ]);
                } else {
                    return response()->json([
                        'success' => true,
                        'exists' => false,
                        'bpjs_data' => null,
                        'message' => 'NIK belum terdaftar dan tidak ditemukan di BPJS. Silakan lengkapi form pendaftaran manual.'
                    ]);
                }
            } catch (\Exception $bpjsError) {
                Log::warning('BPJS API Error: ' . $bpjsError->getMessage());
                
                return response()->json([
                    'success' => true,
                    'exists' => false,
                    'bpjs_data' => null,
                    'message' => 'NIK belum terdaftar. BPJS tidak dapat diakses, silakan lengkapi form pendaftaran manual.'
                ]);
            }

        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'NIK harus 16 digit',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('NIK Validation Error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat validasi NIK'
            ], 500);
        }
    }

    /**
     * Register new patient
     */
    public function register(Request $request): JsonResponse
    {
        try {
            $validated = $request->validate([
                'nik' => 'required|string|min:16|max:16|unique:pasien,no_ktp',
                'nama' => 'required|string|max:40',
                'jk' => 'required|in:L,P',
                'tmp_lahir' => 'required|string|max:15',
                'tgl_lahir' => 'required|date',
                'nm_ibu' => 'required|string|max:40',
                'alamat' => 'required|string|max:200',
                'gol_darah' => 'nullable|string|max:2',
                'pekerjaan' => 'nullable|string|max:60',
                'stts_nikah' => 'required|in:BELUM MENIKAH,MENIKAH,JANDA,DUDHA,JANDA MATI',
                'agama' => 'required|in:ISLAM,KRISTEN,KATHOLIK,HINDU,BUDHA,KONGHUCU,KEPERCAYAAN',
                'no_tlp' => 'nullable|string|max:40',
                'pnd' => 'nullable|string|max:60',
                'keluarga' => 'required|in:AYAH,IBU,ISTRI,SUAMI,SAUDARA,ANAK',
                'namakeluarga' => 'nullable|string|max:40',
                'kd_pj' => 'nullable|string|max:3',
                'no_peserta' => 'nullable|string|max:25',
                'email' => 'nullable|email|max:50',
                // BPJS data (optional, for auto-fill)
                'bpjs_data' => 'nullable|array'
            ]);

            DB::beginTransaction();

            // Create new patient
            if (isset($validated['bpjs_data'])) {
                // Create from BPJS data
                $patient = Pasien::createFromBpjsData($validated['bpjs_data'], $validated);
            } else {
                // Create manually
                $noRkmMedis = Pasien::generateNoRkmMedis();
                
                // Calculate age
                $tglLahir = Carbon::parse($validated['tgl_lahir']);
                $umur = $tglLahir->age . ' Th';

                $patient = Pasien::create([
                    'no_rkm_medis' => $noRkmMedis,
                    'nm_pasien' => strtoupper($validated['nama']),
                    'no_ktp' => $validated['nik'],
                    'jk' => $validated['jk'],
                    'tmp_lahir' => $validated['tmp_lahir'],
                    'tgl_lahir' => $validated['tgl_lahir'],
                    'nm_ibu' => strtoupper($validated['nm_ibu']),
                    'alamat' => $validated['alamat'],
                    'gol_darah' => $validated['gol_darah'] ?? '-',
                    'pekerjaan' => $validated['pekerjaan'] ?? '',
                    'stts_nikah' => $validated['stts_nikah'],
                    'agama' => $validated['agama'],
                    'tgl_daftar' => Carbon::now()->format('Y-m-d'),
                    'no_tlp' => $validated['no_tlp'] ?? '',
                    'umur' => $umur,
                    'pnd' => $validated['pnd'] ?? '-',
                    'keluarga' => $validated['keluarga'],
                    'namakeluarga' => $validated['namakeluarga'] ?? '',
                    'kd_pj' => $validated['kd_pj'] ?? 'BPJ',
                    'no_peserta' => $validated['no_peserta'] ?? '',
                    'email' => $validated['email'] ?? '',
                    'kd_kel' => '',
                    'kd_kec' => 0,
                    'kd_kab' => 0,
                    'pekerjaanpj' => '',
                    'alamatpj' => '',
                    'kelurahanpj' => '',
                    'kecamatanpj' => '',
                    'kabupatenpj' => '',
                    'perusahaan_pasien' => '',
                    'suku_bangsa' => 1,
                    'bahasa_pasien' => 1,
                    'cacat_fisik' => 1,
                    'nip' => '',
                    'kd_prop' => 0,
                    'propinsipj' => ''
                ]);
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => 'Pasien berhasil didaftarkan',
                'patient' => [
                    'no_rkm_medis' => $patient->no_rkm_medis,
                    'nama' => $patient->nm_pasien,
                    'nik' => $patient->no_ktp,
                    'jk' => $patient->jk,
                    'tgl_lahir' => $patient->tgl_lahir,
                    'alamat' => $patient->alamat,
                    'no_tlp' => $patient->no_tlp,
                    'email' => $patient->email
                ]
            ]);

        } catch (ValidationException $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Data tidak valid',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Patient Registration Error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat mendaftarkan pasien'
            ], 500);
        }
    }

    /**
     * Get patient by NIK
     */
    public function getByNik(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'nik' => 'required|string|min:16|max:16'
            ]);

            $patient = Pasien::getByNik($request->nik);

            if (!$patient) {
                return response()->json([
                    'success' => false,
                    'message' => 'Pasien tidak ditemukan'
                ], 404);
            }

            return response()->json([
                'success' => true,
                'patient' => [
                    'no_rkm_medis' => $patient->no_rkm_medis,
                    'nama' => $patient->nm_pasien,
                    'nik' => $patient->no_ktp,
                    'jk' => $patient->jk,
                    'tgl_lahir' => $patient->tgl_lahir,
                    'alamat' => $patient->alamat,
                    'no_tlp' => $patient->no_tlp,
                    'email' => $patient->email,
                    'umur' => $patient->age
                ]
            ]);

        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'NIK harus 16 digit',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Get Patient Error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat mengambil data pasien'
            ], 500);
        }
    }

    /**
     * Update patient data
     */
    public function update(Request $request, $noRkmMedis): JsonResponse
    {
        try {
            $patient = Pasien::where('no_rkm_medis', $noRkmMedis)->first();

            if (!$patient) {
                return response()->json([
                    'success' => false,
                    'message' => 'Pasien tidak ditemukan'
                ], 404);
            }

            $validated = $request->validate([
                'nama' => 'sometimes|string|max:40',
                'alamat' => 'sometimes|string|max:200',
                'no_tlp' => 'sometimes|string|max:40',
                'email' => 'sometimes|email|max:50',
                'pekerjaan' => 'sometimes|string|max:60',
                'stts_nikah' => 'sometimes|in:BELUM MENIKAH,MENIKAH,JANDA,DUDHA,JANDA MATI',
                'agama' => 'sometimes|in:ISLAM,KRISTEN,KATHOLIK,HINDU,BUDHA,KONGHUCU,KEPERCAYAAN'
            ]);

            $patient->update($validated);

            return response()->json([
                'success' => true,
                'message' => 'Data pasien berhasil diperbarui',
                'patient' => [
                    'no_rkm_medis' => $patient->no_rkm_medis,
                    'nama' => $patient->nm_pasien,
                    'nik' => $patient->no_ktp,
                    'alamat' => $patient->alamat,
                    'no_tlp' => $patient->no_tlp,
                    'email' => $patient->email
                ]
            ]);

        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Data tidak valid',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Update Patient Error: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat memperbarui data pasien'
            ], 500);
        }
    }
}