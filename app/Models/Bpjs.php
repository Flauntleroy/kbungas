<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Exception;
use LZCompressor\LZString;

class Bpjs extends Model
{
    protected $table = 'bpjs_api_logs';
    
    protected $fillable = [
        'endpoint',
        'request_data',
        'response_data',
        'status_code',
        'error_message',
        'created_at'
    ];

    
    private $api_url = 'https://apijkn.bpjs-kesehatan.go.id/vclaim-rest/';
    private $consid;
    private $secretkey;
    private $userkey;

    public function __construct()
    {
        parent::__construct();
        
        
        $this->consid = env('BPJS_CONSID', '17432');
        $this->secretkey = env('BPJS_SECRET_KEY', '3nK53BBE23');
        $this->userkey = env('BPJS_USER_KEY', '1823bb1d8015aee02180ee12d2af2b2c');
    }

    /**
     * Generate timestamp untuk API BPJS
     */
    private function generateTimestamp()
    {
        return strval(time() - strtotime("1970-01-01 00:00:00"));
    }

    /**
     * Generate signature untuk API BPJS
     */
    private function generateSignature($timestamp)
    {
        $key = $this->consid . '&' . $timestamp;
        return base64_encode(hash_hmac('sha256', $key, $this->secretkey, true));
    }

    /**
     * Generate headers untuk API BPJS
     */
    private function generateHeaders()
    {
        $timestamp = $this->generateTimestamp();
        $signature = $this->generateSignature($timestamp);

        return [
            'X-cons-id' => $this->consid,
            'X-timestamp' => $timestamp,
            'X-signature' => $signature,
            'user_key' => $this->userkey,
            'Accept' => 'application/json',
            'Content-Type' => 'application/json; charset=utf-8'
        ];
    }

    /**
     * Decrypt AES-256-CBC encrypted string from BPJS
     */
    private function stringDecrypt($key, $string)
    {
        try {
            $encrypt_method = 'AES-256-CBC';
            
            
            $key_hash = hex2bin(hash('sha256', $key));
            
            
            $iv = substr(hex2bin(hash('sha256', $key)), 0, 16);
            
            $output = openssl_decrypt(base64_decode($string), $encrypt_method, $key_hash, OPENSSL_RAW_DATA, $iv);
            
            return $output;
        } catch (Exception $e) {
            Log::error('AES Decryption failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Decompress LZ-String compressed data
     */
    private function decompress($string)
    {
        try {
            return LZString::decompressFromEncodedURIComponent($string);
        } catch (Exception $e) {
            Log::error('LZ-String decompression failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Decrypt and decompress BPJS response
     */
    private function decryptBpjsResponse($encryptedResponse, $timestamp)
    {
        try {
            
            $key = $this->consid . $this->secretkey . $timestamp;
            
            Log::info('BPJS Decryption Process', [
                'consid' => $this->consid,
                'secretkey' => $this->secretkey,
                'timestamp' => $timestamp,
                'key' => $key,
                'encrypted_response_length' => strlen($encryptedResponse)
            ]);
            
            
            $decrypted = $this->stringDecrypt($key, $encryptedResponse);
            
            if ($decrypted === false) {
                Log::error('Failed to decrypt BPJS response');
                return false;
            }
            
            Log::info('BPJS Decryption Step 1 (AES)', [
                'decrypted_length' => strlen($decrypted),
                'decrypted_preview' => substr($decrypted, 0, 100)
            ]);
            
            
            $decompressed = $this->decompress($decrypted);
            
            if ($decompressed === false) {
                Log::error('Failed to decompress BPJS response');
                return false;
            }
            
            Log::info('BPJS Decryption Step 2 (LZ-String)', [
                'decompressed_length' => strlen($decompressed),
                'decompressed_data' => $decompressed
            ]);
            
            return $decompressed;
            
        } catch (Exception $e) {
            Log::error('BPJS Response decryption failed: ' . $e->getMessage());
            return false;
        }
    }

    /**
     * Decompress LZString response dari BPJS (Legacy method - kept for backward compatibility)
     */
    private function decompressResponse($response)
    {
        
        
        if (empty($response)) {
            return $response;
        }

        
        if (is_array($response) || is_object($response)) {
            return $response;
        }

        
        $decoded = json_decode($response, true);
        if (json_last_error() === JSON_ERROR_NONE) {
            return $decoded;
        }

        
        
        try {
            
            if (base64_encode(base64_decode($response, true)) === $response) {
                $decodedBase64 = base64_decode($response);
                $jsonDecoded = json_decode($decodedBase64, true);
                if (json_last_error() === JSON_ERROR_NONE) {
                    return $jsonDecoded;
                }
            }
            
            
            $inflated = @gzinflate($response);
            if ($inflated !== false) {
                $jsonDecoded = json_decode($inflated, true);
                if (json_last_error() === JSON_ERROR_NONE) {
                    return $jsonDecoded;
                }
            }
            
            
            return $response;
            
        } catch (Exception $e) {
            Log::warning('Failed to decompress BPJS response: ' . $e->getMessage());
            return $response;
        }
    }

    /**
     * Log API request dan response
     */
    private function logApiCall($endpoint, $requestData, $responseData, $statusCode, $errorMessage = null)
    {
        try {
            $this->create([
                'endpoint' => $endpoint,
                'request_data' => json_encode($requestData),
                'response_data' => json_encode($responseData),
                'status_code' => $statusCode,
                'error_message' => $errorMessage,
                'created_at' => now()
            ]);
        } catch (Exception $e) {
            Log::error('Failed to log BPJS API call: ' . $e->getMessage());
        }
    }

    /**
     * Cek data peserta BPJS berdasarkan NIK
     */
    public function checkPesertaByNik($nik, $tglSep)
    {
        try {
            
            if (empty($nik) || strlen($nik) !== 16) {
                throw new Exception('NIK harus 16 digit');
            }

            if (empty($tglSep)) {
                throw new Exception('Tanggal SEP tidak boleh kosong');
            }

            
            $tglSep = date('Y-m-d', strtotime($tglSep));

            
            $endpoint = "Peserta/nik/{$nik}/tglSEP/{$tglSep}";
            $url = $this->api_url . $endpoint;

            
            $headers = $this->generateHeaders();
            $timestamp = $headers['X-timestamp']; 

            
            $requestData = [
                'nik' => $nik,
                'tgl_sep' => $tglSep,
                'url' => $url,
                'headers' => $headers
            ];

            
            Log::info('BPJS API Request', [
                'url' => $url,
                'headers' => $headers,
                'method' => 'GET'
            ]);

            
            $response = Http::withHeaders($headers)
                ->timeout(30)
                ->get($url);

            $statusCode = $response->status();
            $rawResponse = $response->body();
            
            
            Log::info('BPJS API Raw Response', [
                'status_code' => $statusCode,
                'raw_response' => $rawResponse,
                'response_length' => strlen($rawResponse)
            ]);
            
            
            $initialResponse = json_decode($rawResponse, true);
            if (json_last_error() !== JSON_ERROR_NONE) {
                throw new Exception('Invalid JSON response from BPJS API: ' . json_last_error_msg());
            }
            
            
            if (isset($initialResponse['response']) && is_string($initialResponse['response'])) {
                
                $decryptedData = $this->decryptBpjsResponse($initialResponse['response'], $timestamp);
                
                if ($decryptedData !== false) {
                    
                    $pesertaData = json_decode($decryptedData, true);
                    if (json_last_error() === JSON_ERROR_NONE) {
                        
                        $initialResponse['response'] = $pesertaData;
                    } else {
                        Log::error('Failed to parse decrypted JSON: ' . json_last_error_msg());
                    }
                } else {
                    Log::error('Failed to decrypt BPJS response');
                }
            }
            
            $responseData = $initialResponse;

            
            Log::info('BPJS API Parsed Response', [
                'parsed_response' => $responseData
            ]);

            
            $this->logApiCall($endpoint, $requestData, $responseData, $statusCode);

            
            if ($statusCode === 200 && is_array($responseData) && isset($responseData['metaData'])) {
                if ($responseData['metaData']['code'] === '200') {
                    
                    $pesertaData = $responseData['response']['peserta'] ?? null;
                    
                    if ($pesertaData === null) {
                        
                        return [
                            'success' => false,
                            'data' => null,
                            'message' => 'NIK valid tetapi tidak terdaftar sebagai peserta BPJS aktif'
                        ];
                    }
                    
                    return [
                        'success' => true,
                        'data' => $pesertaData,
                        'message' => 'Data peserta ditemukan'
                    ];
                } elseif ($responseData['metaData']['code'] === '201') {
                    
                    return [
                        'success' => false,
                        'data' => null,
                        'message' => 'Data peserta tidak ditemukan'
                    ];
                } else {
                    
                    throw new Exception($responseData['metaData']['message'] ?? 'Unknown error from BPJS');
                }
            } else {
                throw new Exception('Response tidak valid dari server BPJS. Status: ' . $statusCode);
            }

        } catch (Exception $e) {
            
            Log::error('BPJS API Error', [
                'error' => $e->getMessage(),
                'nik' => $nik,
                'tgl_sep' => $tglSep ?? null
            ]);
            
            $this->logApiCall(
                $endpoint ?? 'check_nik',
                $requestData ?? ['nik' => $nik],
                null,
                $statusCode ?? 500,
                $e->getMessage()
            );

            return [
                'success' => false,
                'data' => null,
                'message' => $e->getMessage()
            ];
        }
    }

    /**
     * Cek data peserta BPJS berdasarkan nomor kartu
     */
    public function checkPesertaByKartu($noKartu, $tglSep)
    {
        try {
            
            if (empty($noKartu) || strlen($noKartu) !== 13) {
                throw new Exception('Nomor kartu BPJS harus 13 digit');
            }

            if (empty($tglSep)) {
                throw new Exception('Tanggal SEP tidak boleh kosong');
            }

            
            $tglSep = date('Y-m-d', strtotime($tglSep));

            
            $endpoint = "Peserta/nokartu/{$noKartu}/tglSEP/{$tglSep}";
            $url = $this->api_url . $endpoint;

            
            $headers = $this->generateHeaders();

            
            $requestData = [
                'no_kartu' => $noKartu,
                'tgl_sep' => $tglSep
            ];

            
            $response = Http::withHeaders($headers)
                ->timeout(30)
                ->get($url);

            $statusCode = $response->status();
            $rawResponse = $response->body();
            
            
            $decompressedResponse = $this->decompressResponse($rawResponse);
            
            
            if (is_string($decompressedResponse)) {
                $responseData = json_decode($decompressedResponse, true);
                if (json_last_error() !== JSON_ERROR_NONE) {
                    throw new Exception('Invalid JSON response from BPJS API: ' . json_last_error_msg());
                }
            } else {
                $responseData = $decompressedResponse;
            }

            
            $this->logApiCall($endpoint, $requestData, $responseData, $statusCode);

            
            if ($statusCode === 200 && is_array($responseData) && isset($responseData['metaData'])) {
                if ($responseData['metaData']['code'] === '200') {
                    
                    return [
                        'success' => true,
                        'data' => $responseData['response']['peserta'] ?? null,
                        'message' => 'Data peserta ditemukan'
                    ];
                } elseif ($responseData['metaData']['code'] === '201') {
                    
                    return [
                        'success' => false,
                        'data' => null,
                        'message' => 'Data peserta tidak ditemukan'
                    ];
                } else {
                    
                    throw new Exception($responseData['metaData']['message'] ?? 'Unknown error from BPJS');
                }
            } else {
                throw new Exception('Response tidak valid dari server BPJS. Status: ' . $statusCode);
            }

        } catch (Exception $e) {
            
            $this->logApiCall(
                $endpoint ?? 'check_kartu',
                $requestData ?? ['no_kartu' => $noKartu],
                null,
                $statusCode ?? 500,
                $e->getMessage()
            );

            return [
                'success' => false,
                'data' => null,
                'message' => $e->getMessage()
            ];
        }
    }

    /**
     * Validasi format NIK
     */
    public static function validateNik($nik)
    {
        return preg_match('/^[0-9]{16}$/', $nik);
    }

    /**
     * Validasi format nomor kartu BPJS
     */
    public static function validateKartuBpjs($noKartu)
    {
        return preg_match('/^[0-9]{13}$/', $noKartu);
    }
}