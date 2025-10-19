<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Carbon\Carbon;

class RegPeriksa extends Model
{
    protected $table = 'reg_periksa';
    protected $primaryKey = 'no_rawat';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false; // Disable timestamps karena tabel tidak memiliki kolom updated_at dan created_at
    
    protected $fillable = [
        'no_reg',
        'no_rawat',
        'tgl_registrasi',
        'jam_reg',
        'kd_dokter',
        'no_rkm_medis',
        'kd_poli',
        'p_jawab',
        'almt_pj',
        'hubunganpj',
        'biaya_reg',
        'stts',
        'stts_daftar',
        'status_lanjut',
        'kd_pj',
        'umurdaftar',
        'sttsumur',
        'status_bayar',
        'status_poli'
    ];

    protected $casts = [
        'tgl_registrasi' => 'date',
        'jam_reg' => 'datetime:H:i:s',
        'biaya_reg' => 'double',
        'umurdaftar' => 'integer',
    ];

    // Status constants
    const STATUS_BELUM = 'Belum';
    const STATUS_SUDAH = 'Sudah';
    const STATUS_BATAL = 'Batal';
    const STATUS_BERKAS_DITERIMA = 'Berkas Diterima';
    const STATUS_DIRUJUK = 'Dirujuk';
    const STATUS_MENINGGAL = 'Meninggal';
    const STATUS_DIRAWAT = 'Dirawat';
    const STATUS_PULANG_PAKSA = 'Pulang Paksa';

    const STTS_DAFTAR_LAMA = 'Lama';
    const STTS_DAFTAR_BARU = 'Baru';

    const STATUS_LANJUT_RALAN = 'Ralan';
    const STATUS_LANJUT_RANAP = 'Ranap';

    const STATUS_BAYAR_SUDAH = 'Sudah Bayar';
    const STATUS_BAYAR_BELUM = 'Belum Bayar';

    const STATUS_POLI_LAMA = 'Lama';
    const STATUS_POLI_BARU = 'Baru';

    const STTS_UMUR_TAHUN = 'Th';
    const STTS_UMUR_BULAN = 'Bl';
    const STTS_UMUR_HARI = 'Hr';

    /**
     * Relationship dengan tabel dokter
     */
    public function dokter(): BelongsTo
    {
        return $this->belongsTo(Dokter::class, 'kd_dokter', 'kd_dokter');
    }

    /**
     * Relationship dengan tabel poliklinik
     */
    public function poliklinik(): BelongsTo
    {
        return $this->belongsTo(Poliklinik::class, 'kd_poli', 'kd_poli');
    }

    /**
     * Relationship dengan tabel penjab (penanggung jawab)
     */
    public function penjab(): BelongsTo
    {
        return $this->belongsTo(Penjab::class, 'kd_pj', 'kd_pj');
    }

    /**
     * Relationship dengan tabel pasien
     */
    public function pasien(): BelongsTo
    {
        return $this->belongsTo(Pasien::class, 'no_rkm_medis', 'no_rkm_medis');
    }

    /**
     * Generate nomor rawat otomatis
     */
    public static function generateNoRawat($tanggal = null): string
    {
        if (!$tanggal) {
            $tanggal = Carbon::now();
        } else {
            $tanggal = Carbon::parse($tanggal);
        }

        $prefix = $tanggal->format('Y/m/d');
        
        // Cari nomor rawat terakhir pada tanggal tersebut
        $lastReg = self::where('no_rawat', 'like', $prefix . '%')
            ->orderBy('no_rawat', 'desc')
            ->first();

        if ($lastReg) {
            // Ambil nomor urut terakhir dan tambah 1
            $lastNumber = (int) substr($lastReg->no_rawat, -6);
            $newNumber = $lastNumber + 1;
        } else {
            $newNumber = 1;
        }

        return $prefix . '/' . str_pad($newNumber, 6, '0', STR_PAD_LEFT);
    }

    /**
     * Generate nomor registrasi otomatis
     */
    public static function generateNoReg($tanggal = null): string
    {
        if (!$tanggal) {
            $tanggal = Carbon::now();
        } else {
            $tanggal = Carbon::parse($tanggal);
        }

        // Cari nomor registrasi terakhir pada tanggal tersebut
        $lastReg = self::whereDate('tgl_registrasi', $tanggal->format('Y-m-d'))
            ->orderBy('no_reg', 'desc')
            ->first();

        if ($lastReg && $lastReg->no_reg) {
            $newNumber = (int) $lastReg->no_reg + 1;
        } else {
            $newNumber = 1;
        }

        return str_pad($newNumber, 3, '0', STR_PAD_LEFT);
    }
}