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
    public $timestamps = false; 
    
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
        'tanggal' => 'datetime',
        'tanggal_booking' => 'datetime',
    ];

    
    const STATUS_DITERIMA = 'Diterima';
    const STATUS_DITOLAK = 'Ditolak';
    const STATUS_BELUM_DIBALAS = 'Belum Dibalas';
    const STATUS_CHECK_IN = 'Check In';
    const STATUS_CHECKIN = 'CheckIn';

    public function poliklinik(): BelongsTo
    {
        return $this->belongsTo(Poliklinik::class, 'kd_poli', 'kd_poli');
    }

    public function dokter(): BelongsTo
    {
        return $this->belongsTo(Dokter::class, 'kd_dokter', 'kd_dokter');
    }

    public function penjab(): BelongsTo
    {
        return $this->belongsTo(Penjab::class, 'kd_pj', 'kd_pj');
    }

    public function pasien(): BelongsTo
    {
        return $this->belongsTo(Pasien::class, 'nik', 'no_ktp');
    }

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

    public function scopeByStatus($query, $status)
    {
        return $query->where('status', $status);
    }

    public function scopeByDate($query, $date)
    {
        return $query->whereDate('tanggal', $date);
    }

    public function scopeByDateTime($query, $datetime)
    {
        return $query->where('tanggal', $datetime);
    }

    public function scopeByDokter($query, $kdDokter)
    {
        return $query->where('kd_dokter', $kdDokter);
    }

    public function scopeByPoliklinik($query, $kdPoli)
    {
        return $query->where('kd_poli', $kdPoli);
    }

    public function getTanggalFormattedAttribute(): string
    {
        if (!$this->tanggal) {
            return '';
        }
        
        
        Carbon::setLocale('id');
        
        
        $namaHari = [
            'Sunday' => 'Minggu',
            'Monday' => 'Senin', 
            'Tuesday' => 'Selasa',
            'Wednesday' => 'Rabu',
            'Thursday' => 'Kamis',
            'Friday' => 'Jumat',
            'Saturday' => 'Sabtu'
        ];
        
        
        $namaBulan = [
            1 => 'Januari', 2 => 'Februari', 3 => 'Maret', 4 => 'April',
            5 => 'Mei', 6 => 'Juni', 7 => 'Juli', 8 => 'Agustus',
            9 => 'September', 10 => 'Oktober', 11 => 'November', 12 => 'Desember'
        ];
        
        $tanggal = $this->tanggal;
        $hari = $namaHari[$tanggal->format('l')];
        $bulan = $namaBulan[(int)$tanggal->format('n')];
        
        return sprintf(
            '%s, %d %s %d Pukul %s WITA',
            $hari,
            $tanggal->day,
            $bulan,
            $tanggal->year,
            $tanggal->format('H.i')
        );
    }

    public function getTanggalBookingFormattedAttribute(): string
    {
        return $this->tanggal_booking ? $this->tanggal_booking->format('d/m/Y H:i') : '';
    }

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

    public function setNikAttribute($value)
    {
        $this->attributes['nik'] = $value ? str_pad($value, 16, '0', STR_PAD_LEFT) : null;
    }

    public function setNomorKartuAttribute($value)
    {
        $this->attributes['nomor_kartu'] = $value ? str_pad($value, 13, '0', STR_PAD_LEFT) : null;
    }

    public static function validateNik($nik): bool
    {
        return preg_match('/^[0-9]{16}$/', $nik);
    }

    public static function validateNomorKartu($nomorKartu): bool
    {
        return preg_match('/^[0-9]{13}$/', $nomorKartu);
    }

    public static function getWithRelations()
    {
        return self::with(['poliklinik', 'dokter', 'penjab']);
    }

    public function canChangeStatus(): bool
    {
        return !in_array($this->status, [self::STATUS_CHECK_IN, self::STATUS_CHECKIN]);
    }

    public function updateStatus(string $status, string $catatan = null): bool
    {
        if (!$this->canChangeStatus()) {
            return false;
        }

        $this->status = $status;
        
        if ($catatan && !empty(trim($catatan))) {
            $this->catatan = $catatan;
        }

        return $this->save();
    }
}