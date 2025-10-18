<?php

namespace App\Services;

use App\Models\Bpjs;
use Illuminate\Support\Facades\Log;
use Exception;

class BpjsService
{
    protected $bpjsModel;

    public function __construct()
    {
        $this->bpjsModel = new Bpjs();
    }

    /**
     * Get patient data by NIK from BPJS API
     */
    public function getPatientByNik($nik)
    {
        try {
            // Validate NIK format
            if (!$this->validateNik($nik)) {
                throw new Exception('Format NIK tidak valid. NIK harus 16 digit angka.');
            }

            // Get current date for tglSep
            $tglSep = date('Y-m-d');

            // Call BPJS API through model
            $result = $this->bpjsModel->checkPesertaByNik($nik, $tglSep);

            if ($result['success']) {
                return [
                    'success' => true,
                    'response' => $result['data'],
                    'message' => $result['message']
                ];
            } else {
                return [
                    'success' => false,
                    'response' => null,
                    'message' => $result['message']
                ];
            }

        } catch (Exception $e) {
            Log::error('BpjsService getPatientByNik Error: ' . $e->getMessage());
            
            return [
                'success' => false,
                'response' => null,
                'message' => $e->getMessage()
            ];
        }
    }

    /**
     * Get patient data by BPJS card number
     */
    public function getPatientByKartu($noKartu)
    {
        try {
            // Validate card number format
            if (!$this->validateKartu($noKartu)) {
                throw new Exception('Format nomor kartu BPJS tidak valid. Nomor kartu harus 13 digit.');
            }

            // Get current date for tglSep
            $tglSep = date('Y-m-d');

            // Call BPJS API through model
            $result = $this->bpjsModel->checkPesertaByKartu($noKartu, $tglSep);

            if ($result['success']) {
                return [
                    'success' => true,
                    'response' => $result['data'],
                    'message' => $result['message']
                ];
            } else {
                return [
                    'success' => false,
                    'response' => null,
                    'message' => $result['message']
                ];
            }

        } catch (Exception $e) {
            Log::error('BpjsService getPatientByKartu Error: ' . $e->getMessage());
            
            return [
                'success' => false,
                'response' => null,
                'message' => $e->getMessage()
            ];
        }
    }

    /**
     * Check BPJS API status
     */
    public function checkApiStatus()
    {
        try {
            // Test with dummy NIK
            $testNik = '1234567890123456';
            $tglSep = date('Y-m-d');

            $result = $this->bpjsModel->checkPesertaByNik($testNik, $tglSep);

            // If we get any response (even error), API is accessible
            return [
                'status' => 'active',
                'message' => 'API BPJS dapat diakses',
                'timestamp' => now()->toISOString()
            ];

        } catch (Exception $e) {
            Log::error('BPJS API Status Check Error: ' . $e->getMessage());

            return [
                'status' => 'error',
                'message' => 'API BPJS tidak dapat diakses: ' . $e->getMessage(),
                'timestamp' => now()->toISOString()
            ];
        }
    }

    /**
     * Validate NIK format
     */
    private function validateNik($nik)
    {
        // NIK must be exactly 16 digits
        return preg_match('/^\d{16}$/', $nik);
    }

    /**
     * Validate BPJS card number format
     */
    private function validateKartu($noKartu)
    {
        // BPJS card number must be exactly 13 digits
        return preg_match('/^\d{13}$/', $noKartu);
    }

    /**
     * Parse BPJS response data for patient registration
     */
    public function parseBpjsDataForPatient($bpjsData)
    {
        if (!$bpjsData || !is_array($bpjsData)) {
            return null;
        }

        return [
            'nik' => $bpjsData['nik'] ?? '',
            'nama' => $bpjsData['nama'] ?? '',
            'sex' => $bpjsData['sex'] ?? '',
            'tglLahir' => $bpjsData['tglLahir'] ?? '',
            'noKartu' => $bpjsData['noKartu'] ?? '',
            'alamat' => '', // BPJS API doesn't provide address
            'pekerjaan' => '', // BPJS API doesn't provide occupation
            'kdProviderPeserta' => $bpjsData['provUmum']['kdProvider'] ?? 'BPJ',
            'nmProviderPeserta' => $bpjsData['provUmum']['nmProvider'] ?? '',
            'statusPeserta' => $bpjsData['statusPeserta']['keterangan'] ?? '',
            'hakKelas' => $bpjsData['hakKelas']['keterangan'] ?? '',
            'jenisPeserta' => $bpjsData['jenisPeserta']['keterangan'] ?? ''
        ];
    }

    /**
     * Format BPJS data for frontend display
     */
    public function formatBpjsDataForDisplay($bpjsData)
    {
        if (!$bpjsData || !is_array($bpjsData)) {
            return null;
        }

        return [
            'nik' => $bpjsData['nik'] ?? '',
            'nama' => $bpjsData['nama'] ?? '',
            'jenis_kelamin' => $bpjsData['sex'] === 'L' ? 'Laki-laki' : 'Perempuan',
            'tanggal_lahir' => $bpjsData['tglLahir'] ?? '',
            'nomor_kartu' => $bpjsData['noKartu'] ?? '',
            'status_peserta' => $bpjsData['statusPeserta']['keterangan'] ?? '',
            'hak_kelas' => $bpjsData['hakKelas']['keterangan'] ?? '',
            'jenis_peserta' => $bpjsData['jenisPeserta']['keterangan'] ?? '',
            'provider' => $bpjsData['provUmum']['nmProvider'] ?? '',
            'umur' => $bpjsData['umur']['umurSekarang'] ?? ''
        ];
    }
}