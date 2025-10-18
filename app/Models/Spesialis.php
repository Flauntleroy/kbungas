<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Spesialis extends Model
{
    protected $table = 'spesialis';
    protected $primaryKey = 'kd_sps';
    public $incrementing = false;
    protected $keyType = 'string';
    public $timestamps = false;

    protected $fillable = [
        'kd_sps',
        'nm_sps'
    ];

    /**
     * Relationship dengan tabel dokter
     */
    public function dokter(): HasMany
    {
        return $this->hasMany(Dokter::class, 'kd_sps', 'kd_sps');
    }

    /**
     * Get spesialis untuk dropdown/select
     */
    public static function getForSelect()
    {
        return self::orderBy('nm_sps')
            ->get()
            ->map(function ($spesialis) {
                return [
                    'value' => $spesialis->kd_sps,
                    'label' => $spesialis->nm_sps
                ];
            });
    }

    /**
     * Cari spesialis berdasarkan nama
     */
    public static function cariByNama($nama)
    {
        return self::where('nm_sps', 'like', "%{$nama}%");
    }

    /**
     * Get dokter count untuk spesialis
     */
    public function getDokterCount(): int
    {
        return $this->dokter()->count();
    }

    /**
     * Get dokter aktif untuk spesialis
     */
    public function getDokterAktif()
    {
        return $this->dokter()->aktif()->get();
    }
}