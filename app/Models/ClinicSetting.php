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

    public static function get($key, $default = null)
    {
        $setting = static::where('key', $key)->first();
        
        if (!$setting) {
            return $default;
        }

        
        switch ($setting->type) {
            case 'json':
                return json_decode($setting->value, true);
            case 'boolean':
                return filter_var($setting->value, FILTER_VALIDATE_BOOLEAN);
            case 'number':
                return is_numeric($setting->value) ? (float)$setting->value : $setting->value;
            case 'string':
            default:
                return $setting->value;
        }
    }

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

    public static function getAll()
    {
        $settings = static::all();
        $result = [];
        
        foreach ($settings as $setting) {
            
            switch ($setting->type) {
                case 'json':
                    $result[$setting->key] = json_decode($setting->value, true);
                    break;
                case 'boolean':
                    $result[$setting->key] = filter_var($setting->value, FILTER_VALIDATE_BOOLEAN);
                    break;
                case 'number':
                    $result[$setting->key] = is_numeric($setting->value) ? (float)$setting->value : $setting->value;
                    break;
                case 'string':
                default:
                    $result[$setting->key] = $setting->value;
                    break;
            }
        }
        
        return $result;
    }

    public static function getByPrefix($prefix)
    {
        return static::where('key', 'LIKE', $prefix . '%')
            ->pluck('value', 'key')
            ->toArray();
    }
}