<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ClinicDoctor extends Model
{
    protected $fillable = [
        'name',
        'specialization',
        'description',
        'photo',
        'whatsapp',
        'available',
        'is_primary',
        'order',
        'is_active'
    ];

    protected $casts = [
        'available' => 'boolean',
        'is_primary' => 'boolean',
        'is_active' => 'boolean',
        'order' => 'integer'
    ];

    /**
     * Scope to get only active doctors
     */
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    /**
     * Scope to get only available doctors
     */
    public function scopeAvailable($query)
    {
        return $query->where('available', true);
    }

    /**
     * Scope to get primary doctor
     */
    public function scopePrimary($query)
    {
        return $query->where('is_primary', true);
    }

    /**
     * Scope to order doctors by order field
     */
    public function scopeOrdered($query)
    {
        return $query->orderBy('order', 'asc');
    }
}
