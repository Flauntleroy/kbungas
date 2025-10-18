<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Penjab extends Model
{
    protected $table = 'penjab';
    protected $primaryKey = 'kd_pj';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;

    protected $fillable = [
        'kd_pj',
        'png_jawab',
        'nama_perusahaan',
        'alamat_asuransi',
        'no_telp',
        'attn'
    ];

    /**
     * Relationship dengan tabel booking_periksa
     */
    public function bookingPeriksa(): HasMany
    {
        return $this->hasMany(BookingPeriksa::class, 'kd_pj', 'kd_pj');
    }

    /**
     * Scope untuk penjab berdasarkan jenis
     */
    public function scopeByJenis($query, $jenis)
    {
        return $query->where('png_jawab', 'like', "%{$jenis}%");
    }

    /**
     * Accessor untuk nama lengkap penanggung jawab
     */
    public function getNamaLengkapAttribute(): string
    {
        $nama = $this->png_jawab;
        if ($this->nama_perusahaan && $this->nama_perusahaan !== $this->png_jawab) {
            $nama .= ' (' . $this->nama_perusahaan . ')';
        }
        return $nama;
    }

    /**
     * Cari penjab berdasarkan nama
     */
    public static function cariByNama($nama)
    {
        return self::where('png_jawab', 'like', "%{$nama}%")
            ->orWhere('nama_perusahaan', 'like', "%{$nama}%");
    }

    /**
     * Get penjab untuk dropdown/select
     */
    public static function getForSelect()
    {
        return self::orderBy('png_jawab')
            ->get()
            ->map(function ($penjab) {
                return [
                    'value' => $penjab->kd_pj,
                    'label' => $penjab->nama_lengkap
                ];
            });
    }

    /**
     * Get penjab umum (biasanya kode 'A01' atau 'UMUM')
     */
    public static function getUmum()
    {
        return self::where('kd_pj', 'A01')
            ->orWhere('png_jawab', 'like', '%UMUM%')
            ->first();
    }

    /**
     * Get penjab BPJS (biasanya mengandung kata 'BPJS')
     */
    public static function getBpjs()
    {
        return self::where('png_jawab', 'like', '%BPJS%')
            ->orWhere('nama_perusahaan', 'like', '%BPJS%')
            ->get();
    }

    /**
     * Get penjab asuransi swasta
     */
    public static function getAsuransiSwasta()
    {
        return self::where('png_jawab', 'not like', '%BPJS%')
            ->where('png_jawab', 'not like', '%UMUM%')
            ->where('nama_perusahaan', '!=', '')
            ->whereNotNull('nama_perusahaan')
            ->get();
    }

    /**
     * Cek apakah penjab adalah BPJS
     */
    public function isBpjs(): bool
    {
        return stripos($this->png_jawab, 'bpjs') !== false || 
               stripos($this->nama_perusahaan, 'bpjs') !== false;
    }

    /**
     * Cek apakah penjab adalah umum
     */
    public function isUmum(): bool
    {
        return stripos($this->png_jawab, 'umum') !== false || 
               $this->kd_pj === 'A01';
    }

    /**
     * Get booking count untuk penjab
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
     * Get statistik booking untuk penjab
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

    /**
     * Get top penjab berdasarkan jumlah booking
     */
    public static function getTopByBooking($limit = 10, $startDate = null, $endDate = null)
    {
        $query = self::withCount(['bookingPeriksa' => function ($q) use ($startDate, $endDate) {
            if ($startDate) {
                $q->whereDate('tanggal', '>=', $startDate);
            }
            if ($endDate) {
                $q->whereDate('tanggal', '<=', $endDate);
            }
        }]);

        return $query->orderBy('booking_periksa_count', 'desc')
            ->limit($limit)
            ->get();
    }
}