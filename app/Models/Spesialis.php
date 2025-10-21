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

    public function dokter(): HasMany
    {
        return $this->hasMany(Dokter::class, 'kd_sps', 'kd_sps');
    }

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

    public static function cariByNama($nama)
    {
        return self::where('nm_sps', 'like', "%{$nama}%");
    }

    public function getDokterCount(): int
    {
        return $this->dokter()->count();
    }

    public function getDokterAktif()
    {
        return $this->dokter()->aktif()->get();
    }
}