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

    
    const STATUS_AKTIF = '1';
    const STATUS_NONAKTIF = '0';

    public function bookingPeriksa(): HasMany
    {
        return $this->hasMany(BookingPeriksa::class, 'kd_poli', 'kd_poli');
    }

    public function scopeAktif($query)
    {
        return $query->where('status', self::STATUS_AKTIF);
    }

    public function getStatusTextAttribute(): string
    {
        return match($this->status) {
            self::STATUS_AKTIF => 'Aktif',
            self::STATUS_NONAKTIF => 'Non Aktif',
            default => 'Tidak Diketahui'
        };
    }

    public function getBiayaRegistrasiFormattedAttribute(): string
    {
        return 'Rp ' . number_format($this->registrasi, 0, ',', '.');
    }

    public function getBiayaRegistrasiLamaFormattedAttribute(): string
    {
        return 'Rp ' . number_format($this->registrasilama, 0, ',', '.');
    }

    public static function getAktif()
    {
        return self::aktif()->orderBy('nm_poli');
    }

    public static function cariByNama($nama)
    {
        return self::where('nm_poli', 'like', "%{$nama}%");
    }

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

    public function getDokterTersedia($tanggal = null)
    {
        
        
        return Dokter::aktif()->get();
    }

    public function isBukaOnDate($date): bool
    {
        
        
        return $this->status === self::STATUS_AKTIF;
    }

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