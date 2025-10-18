<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Pasien extends Model
{
    use HasFactory;

    protected $table = 'pasien';
    protected $primaryKey = 'no_rkm_medis';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'no_rkm_medis',
        'nm_pasien',
        'no_ktp',
        'jk',
        'tmp_lahir',
        'tgl_lahir',
        'nm_ibu',
        'alamat',
        'gol_darah',
        'pekerjaan',
        'stts_nikah',
        'agama',
        'tgl_daftar',
        'no_tlp',
        'umur',
        'pnd',
        'keluarga',
        'namakeluarga',
        'kd_pj',
        'no_peserta',
        'kd_kel',
        'kd_kec',
        'kd_kab',
        'pekerjaanpj',
        'alamatpj',
        'kelurahanpj',
        'kecamatanpj',
        'kabupatenpj',
        'perusahaan_pasien',
        'suku_bangsa',
        'bahasa_pasien',
        'cacat_fisik',
        'email',
        'nip',
        'kd_prop',
        'propinsipj'
    ];

    protected $casts = [
        'tgl_lahir' => 'date',
        'tgl_daftar' => 'date',
        'kd_kec' => 'integer',
        'kd_kab' => 'integer',
        'suku_bangsa' => 'integer',
        'bahasa_pasien' => 'integer',
        'cacat_fisik' => 'integer',
        'kd_prop' => 'integer'
    ];

    /**
     * Relasi dengan tabel penjab (penanggung jawab)
     */
    public function penjab()
    {
        return $this->belongsTo(Penjab::class, 'kd_pj', 'kd_pj');
    }

    /**
     * Relasi dengan booking periksa
     */
    public function bookings()
    {
        return $this->hasMany(BookingPeriksa::class, 'nik', 'no_ktp');
    }

    /**
     * Check if NIK exists in pasien table
     */
    public static function checkNikExists($nik)
    {
        return self::where('no_ktp', $nik)->exists();
    }

    /**
     * Get pasien by NIK
     */
    public static function getByNik($nik)
    {
        return self::where('no_ktp', $nik)->first();
    }

    /**
     * Generate nomor rekam medis
     */
    public static function generateNoRkmMedis()
    {
        $lastPatient = self::orderBy('no_rkm_medis', 'desc')->first();
        
        if (!$lastPatient) {
            return '000001';
        }

        $lastNumber = intval($lastPatient->no_rkm_medis);
        $newNumber = $lastNumber + 1;
        
        return str_pad($newNumber, 6, '0', STR_PAD_LEFT);
    }

    /**
     * Create new patient from BPJS data
     */
    public static function createFromBpjsData($bpjsData, $additionalData = [])
    {
        $noRkmMedis = self::generateNoRkmMedis();
        
        // Calculate age from birth date
        $tglLahir = Carbon::parse($bpjsData['tglLahir'] ?? null);
        $umur = $tglLahir ? $tglLahir->age . ' Th' : '';

        return self::create([
            'no_rkm_medis' => $noRkmMedis,
            'nm_pasien' => $bpjsData['nama'] ?? '',
            'no_ktp' => $bpjsData['nik'] ?? '',
            'jk' => $bpjsData['sex'] === 'L' ? 'L' : 'P',
            'tmp_lahir' => $bpjsData['tglLahir'] ? Carbon::parse($bpjsData['tglLahir'])->format('Y-m-d') : null,
            'tgl_lahir' => $bpjsData['tglLahir'] ? Carbon::parse($bpjsData['tglLahir'])->format('Y-m-d') : null,
            'nm_ibu' => $additionalData['nm_ibu'] ?? '',
            'alamat' => $bpjsData['alamat'] ?? '',
            'gol_darah' => $additionalData['gol_darah'] ?? '-',
            'pekerjaan' => $bpjsData['pekerjaan'] ?? '',
            'stts_nikah' => $additionalData['stts_nikah'] ?? 'BELUM MENIKAH',
            'agama' => $additionalData['agama'] ?? 'ISLAM',
            'tgl_daftar' => Carbon::now()->format('Y-m-d'),
            'no_tlp' => $additionalData['no_tlp'] ?? '',
            'umur' => $umur,
            'pnd' => $additionalData['pnd'] ?? '-',
            'keluarga' => $additionalData['keluarga'] ?? 'AYAH',
            'namakeluarga' => $additionalData['namakeluarga'] ?? '',
            'kd_pj' => $bpjsData['kdProviderPeserta'] ?? 'BPJ',
            'no_peserta' => $bpjsData['noKartu'] ?? '',
            'kd_kel' => $additionalData['kd_kel'] ?? '',
            'kd_kec' => $additionalData['kd_kec'] ?? 0,
            'kd_kab' => $additionalData['kd_kab'] ?? 0,
            'pekerjaanpj' => $additionalData['pekerjaanpj'] ?? '',
            'alamatpj' => $additionalData['alamatpj'] ?? '',
            'kelurahanpj' => $additionalData['kelurahanpj'] ?? '',
            'kecamatanpj' => $additionalData['kecamatanpj'] ?? '',
            'kabupatenpj' => $additionalData['kabupatenpj'] ?? '',
            'perusahaan_pasien' => $additionalData['perusahaan_pasien'] ?? '',
            'suku_bangsa' => $additionalData['suku_bangsa'] ?? 1,
            'bahasa_pasien' => $additionalData['bahasa_pasien'] ?? 1,
            'cacat_fisik' => $additionalData['cacat_fisik'] ?? 1,
            'email' => $additionalData['email'] ?? '',
            'nip' => $additionalData['nip'] ?? '',
            'kd_prop' => $additionalData['kd_prop'] ?? 0,
            'propinsipj' => $additionalData['propinsipj'] ?? ''
        ]);
    }

    /**
     * Get formatted name
     */
    public function getFormattedNameAttribute()
    {
        return strtoupper($this->nm_pasien);
    }

    /**
     * Get age in years
     */
    public function getAgeAttribute()
    {
        if (!$this->tgl_lahir) {
            return 0;
        }
        
        return Carbon::parse($this->tgl_lahir)->age;
    }

    /**
     * Get formatted address
     */
    public function getFormattedAddressAttribute()
    {
        return $this->alamat ?: 'Alamat tidak tersedia';
    }
}