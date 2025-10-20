<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Carbon\Carbon;

class DoctorReview extends Model
{
    use HasFactory;

    protected $table = 'doctor_reviews';

    protected $fillable = [
        'id_pasien',
        'nama_dokter',
        'rating',
        'ulasan',
        'tanggal_penilaian',
        'email_pasien',
        'nama_pasien',
        'is_approved',
        'is_featured'
    ];

    protected $casts = [
        'tanggal_penilaian' => 'datetime',
        'is_approved' => 'boolean',
        'is_featured' => 'boolean',
        'rating' => 'integer'
    ];

    protected $dates = [
        'tanggal_penilaian',
        'created_at',
        'updated_at'
    ];

    // Scopes untuk query yang sering digunakan
    public function scopeApproved($query)
    {
        return $query->where('is_approved', true);
    }

    public function scopeFeatured($query)
    {
        return $query->where('is_featured', true);
    }

    public function scopeByDoctor($query, $doctorName)
    {
        return $query->where('nama_dokter', $doctorName);
    }

    public function scopeByRating($query, $rating)
    {
        return $query->where('rating', $rating);
    }

    public function scopeRecent($query, $days = 30)
    {
        return $query->where('tanggal_penilaian', '>=', Carbon::now()->subDays($days));
    }

    // Accessor untuk format rating
    public function getRatingStarsAttribute()
    {
        return str_repeat('★', $this->rating) . str_repeat('☆', 5 - $this->rating);
    }

    // Accessor untuk format tanggal
    public function getFormattedDateAttribute()
    {
        return $this->tanggal_penilaian->format('d M Y');
    }

    // Method untuk mendapatkan rata-rata rating per dokter
    public static function getAverageRatingByDoctor($doctorName)
    {
        return self::approved()
            ->byDoctor($doctorName)
            ->avg('rating');
    }

    // Method untuk mendapatkan total review per dokter
    public static function getTotalReviewsByDoctor($doctorName)
    {
        return self::approved()
            ->byDoctor($doctorName)
            ->count();
    }

    // Method untuk mendapatkan review terbaru untuk landing page
    public static function getFeaturedReviews($limit = 6)
    {
        return self::approved()
            ->featured()
            ->orderBy('tanggal_penilaian', 'desc')
            ->limit($limit)
            ->get();
    }

    // Method untuk mendapatkan review dengan rating tinggi
    public static function getHighRatedReviews($minRating = 4, $limit = 10)
    {
        return self::approved()
            ->where('rating', '>=', $minRating)
            ->orderBy('tanggal_penilaian', 'desc')
            ->limit($limit)
            ->get();
    }
}
