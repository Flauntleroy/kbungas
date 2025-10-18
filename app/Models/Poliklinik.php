<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Poliklinik extends Model
{
    protected $table = 'poliklinik';
    protected $primaryKey = 'kd_poli';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;

    protected $fillable = [
        'kd_poli',
        'nm_poli',
        'registrasi',
        'registrasilama',
        'status'
    ];

    protected $casts = [
        'registrasi' => 'decimal:2',
        'registrasilama' => 'decimal:2',
    ];

    // Status constants
    const STATUS_AKTIF = '1';
    const STATUS_NONAKTIF = '0';

    /**
     * Relationship dengan tabel booking_periksa
     */
    public function bookingPeriksa(): HasMany
    {
        return $this->hasMany(BookingPeriksa::class, 'kd_poli', 'kd_poli');
    }

    /**
     * Scope untuk poliklinik aktif
     */
    public function scopeAktif($query)
    {
        return $query->where('status', self::STATUS_AKTIF);
    }

    /**
     * Accessor untuk status text
     */
    public function getStatusTextAttribute(): string
    {
        return match($this->status) {
            self::STATUS_AKTIF => 'Aktif',
            self::STATUS_NONAKTIF => 'Non Aktif',
            default => 'Tidak Diketahui'
        };
    }

    /**
     * Accessor untuk format biaya registrasi
     */
    public function getBiayaRegistrasiFormattedAttribute(): string
    {
        return 'Rp ' . number_format($this->registrasi, 0, ',', '.');
    }

    /**
     * Accessor untuk format biaya registrasi lama
     */
    public function getBiayaRegistrasiLamaFormattedAttribute(): string
    {
        return 'Rp ' . number_format($this->registrasilama, 0, ',', '.');
    }

    /**
     * Get poliklinik aktif
     */
    public static function getAktif()
    {
        return self::aktif()->orderBy('nm_poli');
    }

    /**
     * Cari poliklinik berdasarkan nama
     */
    public static function cariByNama($nama)
    {
        return self::where('nm_poli', 'like', "%{$nama}%");
    }

    /**
     * Get poliklinik untuk dropdown/select
     */
    public static function getForSelect()
    {
        return self::aktif()
            ->orderBy('nm_poli')
            ->get()
            ->map(function ($poli) {
                return [
                    'value' => $poli->kd_poli,
                    'label' => $poli->nm_poli,
                    'biaya_registrasi' => $poli->registrasi,
                    'biaya_registrasi_lama' => $poli->registrasilama
                ];
            });
    }

    /**
     * Get booking count untuk poliklinik
     */
    public function getBookingCount($startDate = null, $endDate = null): int
    {
        $query = $this->bookingPeriksa();
        
        if ($startDate) {
            $query->whereDate('tanggal', '>=', $startDate);
        }
        
        if ($endDate) {
            $query->whereDate('tanggal', '<=', $endDate);
        }
        
        return $query->count();
    }

    /**
     * Get dokter yang tersedia di poliklinik ini
     * Asumsi ada tabel jadwal_dokter atau relasi dokter-poliklinik
     */
    public function getDokterTersedia($tanggal = null)
    {
        // Implementasi sesuai dengan struktur tabel jadwal dokter
        // Untuk sementara return semua dokter aktif
        return Dokter::aktif()->get();
    }

    /**
     * Cek apakah poliklinik buka pada tanggal tertentu
     */
    public function isBukaOnDate($date): bool
    {
        // Implementasi sesuai dengan jadwal poliklinik jika ada
        // Untuk sementara return true jika status aktif
        return $this->status === self::STATUS_AKTIF;
    }

    /**
     * Get statistik booking untuk poliklinik
     */
    public function getBookingStats($startDate = null, $endDate = null): array
    {
        $query = $this->bookingPeriksa();
        
        if ($startDate) {
            $query->whereDate('tanggal', '>=', $startDate);
        }
        
        if ($endDate) {
            $query->whereDate('tanggal', '<=', $endDate);
        }
        
        $total = $query->count();
        $diterima = $query->where('status', BookingPeriksa::STATUS_DITERIMA)->count();
        $ditolak = $query->where('status', BookingPeriksa::STATUS_DITOLAK)->count();
        $belumDibalas = $query->where('status', BookingPeriksa::STATUS_BELUM_DIBALAS)->count();
        $checkIn = $query->whereIn('status', [
            BookingPeriksa::STATUS_CHECK_IN, 
            BookingPeriksa::STATUS_CHECKIN
        ])->count();

        return [
            'total' => $total,
            'diterima' => $diterima,
            'ditolak' => $ditolak,
            'belum_dibalas' => $belumDibalas,
            'check_in' => $checkIn,
            'persentase_diterima' => $total > 0 ? round(($diterima / $total) * 100, 2) : 0,
        ];
    }
}