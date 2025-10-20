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

    // Removed automatic JSON casting to handle different data types properly

    /**
     * Get setting value by key with proper type handling
     */
    public static function get($key, $default = null)
    {
        $setting = static::where('key', $key)->first();
        
        if (!$setting) {
            return $default;
        }

        // Handle different data types based on the type column
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
     * Get all settings as key-value pairs with proper type handling
     */
    public static function getAll()
    {
        $settings = static::all();
        $result = [];
        
        foreach ($settings as $setting) {
            // Handle different data types based on the type column
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