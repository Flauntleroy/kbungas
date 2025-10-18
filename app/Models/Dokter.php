<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Dokter extends Model
{
    protected $table = 'dokter';
    protected $primaryKey = 'kd_dokter';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;

    protected $fillable = [
        'kd_dokter',
        'nm_dokter',
        'jk',
        'tmp_lahir',
        'tgl_lahir',
        'gol_drh',
        'agama',
        'almt_tgl',
        'no_telp',
        'stts_nikah',
        'kd_sps',
        'alumni',
        'no_ijn_praktek',
        'status'
    ];

    protected $casts = [
        'tgl_lahir' => 'date',
    ];

    // Status constants
    const STATUS_AKTIF = '1';
    const STATUS_NONAKTIF = '0';

    // Jenis kelamin constants
    const JK_LAKI = 'L';
    const JK_PEREMPUAN = 'P';

    // Golongan darah constants
    const GOL_DARAH_A = 'A';
    const GOL_DARAH_B = 'B';
    const GOL_DARAH_O = 'O';
    const GOL_DARAH_AB = 'AB';
    const GOL_DARAH_UNKNOWN = '-';

    // Status nikah constants
    const NIKAH_BELUM = 'BELUM MENIKAH';
    const NIKAH_MENIKAH = 'MENIKAH';
    const NIKAH_JANDA = 'JANDA';
    const NIKAH_DUDHA = 'DUDHA';
    const NIKAH_JOMBLO = 'JOMBLO';

    /**
     * Relationship dengan tabel spesialis
     */
    public function spesialis(): BelongsTo
    {
        return $this->belongsTo(Spesialis::class, 'kd_sps', 'kd_sps');
    }

    /**
     * Relationship dengan tabel booking_periksa
     */
    public function bookingPeriksa(): HasMany
    {
        return $this->hasMany(BookingPeriksa::class, 'kd_dokter', 'kd_dokter');
    }

    /**
     * Scope untuk dokter aktif
     */
    public function scopeAktif($query)
    {
        return $query->where('status', self::STATUS_AKTIF);
    }

    /**
     * Scope untuk dokter berdasarkan jenis kelamin
     */
    public function scopeByJenisKelamin($query, $jk)
    {
        return $query->where('jk', $jk);
    }

    /**
     * Scope untuk dokter berdasarkan spesialis
     */
    public function scopeBySpesialis($query, $kdSps)
    {
        return $query->where('kd_sps', $kdSps);
    }

    /**
     * Accessor untuk nama lengkap dengan gelar
     */
    public function getNamaLengkapAttribute(): string
    {
        $nama = $this->nm_dokter;
        if ($this->spesialis) {
            $nama .= ', ' . $this->spesialis->nm_sps;
        }
        return $nama;
    }

    /**
     * Accessor untuk jenis kelamin text
     */
    public function getJenisKelaminTextAttribute(): string
    {
        return match($this->jk) {
            self::JK_LAKI => 'Laki-laki',
            self::JK_PEREMPUAN => 'Perempuan',
            default => 'Tidak Diketahui'
        };
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
     * Accessor untuk umur
     */
    public function getUmurAttribute(): ?int
    {
        if (!$this->tgl_lahir) {
            return null;
        }
        return $this->tgl_lahir->diffInYears(now());
    }

    /**
     * Accessor untuk format tanggal lahir Indonesia
     */
    public function getTanggalLahirFormattedAttribute(): string
    {
        return $this->tgl_lahir ? $this->tgl_lahir->format('d/m/Y') : '';
    }

    /**
     * Get dokter aktif dengan spesialis
     */
    public static function getAktifWithSpesialis()
    {
        return self::aktif()->with('spesialis')->orderBy('nm_dokter');
    }

    /**
     * Cari dokter berdasarkan nama
     */
    public static function cariByNama($nama)
    {
        return self::where('nm_dokter', 'like', "%{$nama}%");
    }

    /**
     * Get dokter untuk dropdown/select
     */
    public static function getForSelect()
    {
        return self::aktif()
            ->with('spesialis')
            ->orderBy('nm_dokter')
            ->get()
            ->map(function ($dokter) {
                return [
                    'value' => $dokter->kd_dokter,
                    'label' => $dokter->nama_lengkap
                ];
            });
    }

    /**
     * Cek apakah dokter memiliki jadwal pada tanggal tertentu
     */
    public function hasScheduleOnDate($date): bool
    {
        // Implementasi sesuai dengan tabel jadwal dokter jika ada
        // Untuk sementara return true
        return true;
    }

    /**
     * Get booking count untuk dokter
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
}