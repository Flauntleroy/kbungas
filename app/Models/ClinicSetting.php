<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClinicSetting extends Model
{
    use HasFactory;

    protected $table = 'clinic_settings';

    protected $fillable = [
        'key',
        'value',
        'type',
        'description'
    ];

    protected $casts = [
        'value' => 'json'
    ];

    /**
     * Get setting value by key
     */
    public static function get($key, $default = null)
    {
        $setting = static::where('key', $key)->first();
        return $setting ? $setting->value : $default;
    }

    /**
     * Set setting value by key
     */
    public static function set($key, $value, $type = 'json', $description = null)
    {
        return static::updateOrCreate(
            ['key' => $key],
            [
                'value' => $value,
                'type' => $type,
                'description' => $description
            ]
        );
    }

    /**
     * Get all settings as key-value pairs
     */
    public static function getAll()
    {
        return static::pluck('value', 'key')->toArray();
    }

    /**
     * Get settings by prefix
     */
    public static function getByPrefix($prefix)
    {
        return static::where('key', 'LIKE', $prefix . '%')
            ->pluck('value', 'key')
            ->toArray();
    }
}