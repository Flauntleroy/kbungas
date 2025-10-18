<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Carbon\Carbon;

class BookingPeriksa extends Model
{
    protected $table = 'booking_periksa';
    protected $primaryKey = 'no_booking';
    public $incrementing = false;
    protected $keyType = 'string';
    
    protected $fillable = [
        'no_booking',
        'nik',
        'nomor_kartu',
        'nama',
        'tanggal',
        'alamat',
        'no_telp',
        'email',
        'kd_poli',
        'kd_dokter',
        'kd_pj',
        'status',
        'catatan',
        'tanggal_booking'
    ];

    protected $casts = [
        'tanggal' => 'date',
        'tanggal_booking' => 'datetime',
    ];

    // Status constants
    const STATUS_DITERIMA = 'Diterima';
    const STATUS_DITOLAK = 'Ditolak';
    const STATUS_BELUM_DIBALAS = 'Belum Dibalas';
    const STATUS_CHECK_IN = 'Check In';
    const STATUS_CHECKIN = 'CheckIn';

    /**
     * Relationship dengan tabel poliklinik
     */
    public function poliklinik(): BelongsTo
    {
        return $this->belongsTo(Poliklinik::class, 'kd_poli', 'kd_poli');
    }

    /**
     * Relationship dengan tabel dokter
     */
    public function dokter(): BelongsTo
    {
        return $this->belongsTo(Dokter::class, 'kd_dokter', 'kd_dokter');
    }

    /**
     * Relationship dengan tabel penjab (penanggung jawab)
     */
    public function penjab(): BelongsTo
    {
        return $this->belongsTo(Penjab::class, 'kd_pj', 'kd_pj');
    }

    /**
     * Generate nomor booking otomatis
     */
    public static function generateBookingNumber(): string
    {
        $date = Carbon::now()->format('Ymd');
        $lastBooking = self::where('no_booking', 'like', "BK{$date}%")
            ->orderBy('no_booking', 'desc')
            ->first();

        if ($lastBooking) {
            $lastNumber = (int) substr($lastBooking->no_booking, -4);
            $newNumber = str_pad($lastNumber + 1, 4, '0', STR_PAD_LEFT);
        } else {
            $newNumber = '0001';
        }

        return "BK{$date}{$newNumber}";
    }

    /**
     * Scope untuk filter berdasarkan status
     */
    public function scopeByStatus($query, $status)
    {
        return $query->where('status', $status);
    }

    /**
     * Scope untuk filter berdasarkan tanggal
     */
    public function scopeByDate($query, $date)
    {
        return $query->whereDate('tanggal', $date);
    }

    /**
     * Scope untuk filter berdasarkan dokter
     */
    public function scopeByDokter($query, $kdDokter)
    {
        return $query->where('kd_dokter', $kdDokter);
    }

    /**
     * Scope untuk filter berdasarkan poliklinik
     */
    public function scopeByPoliklinik($query, $kdPoli)
    {
        return $query->where('kd_poli', $kdPoli);
    }

    /**
     * Accessor untuk format tanggal Indonesia
     */
    public function getTanggalFormattedAttribute(): string
    {
        return $this->tanggal ? $this->tanggal->format('d/m/Y') : '';
    }

    /**
     * Accessor untuk format tanggal booking Indonesia
     */
    public function getTanggalBookingFormattedAttribute(): string
    {
        return $this->tanggal_booking ? $this->tanggal_booking->format('d/m/Y H:i') : '';
    }

    /**
     * Accessor untuk status badge class
     */
    public function getStatusBadgeClassAttribute(): string
    {
        return match($this->status) {
            self::STATUS_DITERIMA => 'bg-green-100 text-green-800',
            self::STATUS_DITOLAK => 'bg-red-100 text-red-800',
            self::STATUS_BELUM_DIBALAS => 'bg-yellow-100 text-yellow-800',
            self::STATUS_CHECK_IN, self::STATUS_CHECKIN => 'bg-blue-100 text-blue-800',
            default => 'bg-gray-100 text-gray-800'
        };
    }

    /**
     * Mutator untuk NIK - pastikan 16 digit
     */
    public function setNikAttribute($value)
    {
        $this->attributes['nik'] = $value ? str_pad($value, 16, '0', STR_PAD_LEFT) : null;
    }

    /**
     * Mutator untuk nomor kartu - pastikan 13 digit
     */
    public function setNomorKartuAttribute($value)
    {
        $this->attributes['nomor_kartu'] = $value ? str_pad($value, 13, '0', STR_PAD_LEFT) : null;
    }

    /**
     * Validasi NIK
     */
    public static function validateNik($nik): bool
    {
        return preg_match('/^[0-9]{16}$/', $nik);
    }

    /**
     * Validasi nomor kartu BPJS
     */
    public static function validateNomorKartu($nomorKartu): bool
    {
        return preg_match('/^[0-9]{13}$/', $nomorKartu);
    }

    /**
     * Get booking dengan relasi lengkap
     */
    public static function getWithRelations()
    {
        return self::with(['poliklinik', 'dokter', 'penjab']);
    }

    /**
     * Cek apakah booking dapat diubah statusnya
     */
    public function canChangeStatus(): bool
    {
        return !in_array($this->status, [self::STATUS_CHECK_IN, self::STATUS_CHECKIN]);
    }

    /**
     * Update status booking
     */
    public function updateStatus(string $status, string $catatan = null): bool
    {
        if (!$this->canChangeStatus()) {
            return false;
        }

        $this->status = $status;
        if ($catatan) {
            $this->catatan = $catatan;
        }

        return $this->save();
    }
}