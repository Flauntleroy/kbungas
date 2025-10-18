<?php

namespace App\Http\Controllers;

use App\Models\Bpjs;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Exception;

class BpjsController extends Controller
{
    protected $bpjsModel;

    public function __construct()
    {
        $this->bpjsModel = new Bpjs();
    }

    /**
     * Check data peserta BPJS berdasarkan NIK
     */
    public function checkNik(Request $request): JsonResponse
    {
        try {
            // Validasi input
            $validator = Validator::make($request->all(), [
                'nik' => 'required|string|size:16|regex:/^[0-9]{16}$/',
                'tgl_sep' => 'nullable|date_format:Y-m-d'
            ], [
                'nik.required' => 'NIK tidak boleh kosong',
                'nik.size' => 'NIK harus 16 digit',
                'nik.regex' => 'NIK hanya boleh berisi angka',
                'tgl_sep.date_format' => 'Format tanggal SEP harus Y-m-d'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'metaData' => [
                        'code' => '400',
                        'message' => $validator->errors()->first()
                    ]
                ], 400);
            }

            $nik = $request->input('nik');
            $tglSep = $request->input('tgl_sep', date('Y-m-d'));

            // Panggil method dari model
            $result = $this->bpjsModel->checkPesertaByNik($nik, $tglSep);

            if ($result['success']) {
                return response()->json([
                    'metaData' => [
                        'code' => '200',
                        'message' => $result['message']
                    ],
                    'response' => [
                        'peserta' => $result['data']
                    ]
                ]);
            } else {
                return response()->json([
                    'metaData' => [
                        'code' => '201',
                        'message' => $result['message']
                    ]
                ]);
            }

        } catch (Exception $e) {
            Log::error('BPJS Check NIK Error: ' . $e->getMessage());

            return response()->json([
                'metaData' => [
                    'code' => '500',
                    'message' => 'Terjadi kesalahan sistem'
                ]
            ], 500);
        }
    }

    /**
     * Check data peserta BPJS berdasarkan nomor kartu
     */
    public function checkKartu(Request $request): JsonResponse
    {
        try {
            // Validasi input
            $validator = Validator::make($request->all(), [
                'nomor_kartu' => 'required|string|size:13|regex:/^[0-9]{13}$/',
                'tgl_sep' => 'nullable|date_format:Y-m-d'
            ], [
                'nomor_kartu.required' => 'Nomor kartu BPJS tidak boleh kosong',
                'nomor_kartu.size' => 'Nomor kartu BPJS harus 13 digit',
                'nomor_kartu.regex' => 'Nomor kartu BPJS hanya boleh berisi angka',
                'tgl_sep.date_format' => 'Format tanggal SEP harus Y-m-d'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'metaData' => [
                        'code' => '400',
                        'message' => $validator->errors()->first()
                    ]
                ], 400);
            }

            $noKartu = $request->input('nomor_kartu');
            $tglSep = $request->input('tgl_sep', date('Y-m-d'));

            // Panggil method dari model
            $result = $this->bpjsModel->checkPesertaByKartu($noKartu, $tglSep);

            if ($result['success']) {
                return response()->json([
                    'metaData' => [
                        'code' => '200',
                        'message' => $result['message']
                    ],
                    'response' => [
                        'peserta' => $result['data']
                    ]
                ]);
            } else {
                return response()->json([
                    'metaData' => [
                        'code' => '201',
                        'message' => $result['message']
                    ]
                ]);
            }

        } catch (Exception $e) {
            Log::error('BPJS Check Kartu Error: ' . $e->getMessage());

            return response()->json([
                'metaData' => [
                    'code' => '500',
                    'message' => 'Terjadi kesalahan sistem'
                ]
            ], 500);
        }
    }

    /**
     * Validasi NIK format saja (untuk frontend validation)
     */
    public function validateNik(Request $request): JsonResponse
    {
        try {
            $validator = Validator::make($request->all(), [
                'nik' => 'required|string|size:16|regex:/^[0-9]{16}$/'
            ], [
                'nik.required' => 'NIK tidak boleh kosong',
                'nik.size' => 'NIK harus 16 digit',
                'nik.regex' => 'NIK hanya boleh berisi angka'
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'valid' => false,
                    'message' => $validator->errors()->first()
                ]);
            }

            return response()->json([
                'valid' => true,
                'message' => 'Format NIK valid'
            ]);

        } catch (Exception $e) {
            Log::error('BPJS Validate NIK Error: ' . $e->getMessage());

            return response()->json([
                'valid' => false,
                'message' => 'Terjadi kesalahan validasi'
            ], 500);
        }
    }

    /**
     * Get API status untuk monitoring
     */
    public function getApiStatus(): JsonResponse
    {
        try {
            // Test koneksi ke API BPJS dengan NIK dummy
            $testNik = '1234567890123456';
            $tglSep = date('Y-m-d');

            $result = $this->bpjsModel->checkPesertaByNik($testNik, $tglSep);

            // Jika response diterima (meskipun data tidak ditemukan), API aktif
            if (isset($result['message'])) {
                return response()->json([
                    'status' => 'active',
                    'message' => 'API BPJS dapat diakses',
                    'timestamp' => now()->toISOString()
                ]);
            } else {
                return response()->json([
                    'status' => 'error',
                    'message' => 'API BPJS tidak dapat diakses',
                    'timestamp' => now()->toISOString()
                ]);
            }

        } catch (Exception $e) {
            Log::error('BPJS API Status Check Error: ' . $e->getMessage());

            return response()->json([
                'status' => 'error',
                'message' => 'Tidak dapat mengecek status API BPJS',
                'timestamp' => now()->toISOString()
            ], 500);
        }
    }
}