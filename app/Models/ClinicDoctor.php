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

    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    public function scopeAvailable($query)
    {
        return $query->where('available', true);
    }

    public function scopePrimary($query)
    {
        return $query->where('is_primary', true);
    }

    public function scopeOrdered($query)
    {
        return $query->orderBy('order', 'asc');
    }
}
