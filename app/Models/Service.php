<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Service extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
        'price',
        'duration_minutes',
        'category',
        'icon',
        'is_active',
        'requires_appointment'
    ];

    protected $casts = [
        'is_active' => 'boolean',
        'requires_appointment' => 'boolean',
        'price' => 'decimal:2',
        'duration_minutes' => 'integer'
    ];

    /**
     * Scope to get only active services
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    /**
     * Scope to order services by category and name
     */
    public function scopeOrdered($query)
    {
        return $query->orderBy('category')->orderBy('name');
    }
}
