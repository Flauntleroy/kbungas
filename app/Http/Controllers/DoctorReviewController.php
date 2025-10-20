<?php

namespace App\Http\Controllers;

use App\Models\DoctorReview;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;

class DoctorReviewController extends Controller
{
    /**
     * Display a listing of the resource for admin.
     */
    public function index(Request $request)
    {
        $query = DoctorReview::query();

        // Filter berdasarkan status approval
        if ($request->has('status')) {
            if ($request->status === 'approved') {
                $query->approved();
            } elseif ($request->status === 'pending') {
                $query->where('is_approved', false);
            }
        }

        // Filter berdasarkan dokter
        if ($request->has('doctor') && $request->doctor) {
            $query->byDoctor($request->doctor);
        }

        // Filter berdasarkan rating
        if ($request->has('rating') && $request->rating) {
            $query->byRating($request->rating);
        }

        $reviews = $query->orderBy('created_at', 'desc')
            ->paginate(15)
            ->withQueryString();

        return Inertia::render('Admin/DoctorReviews', [
            'reviews' => $reviews,
            'filters' => $request->only(['status', 'doctor', 'rating'])
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return Inertia::render('DoctorReview/Create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'id_pasien' => 'required|string|max:255',
            'nama_dokter' => 'required|string|max:255',
            'rating' => 'required|integer|min:1|max:5',
            'ulasan' => 'nullable|string|max:1000',
            'email_pasien' => 'nullable|email|max:255',
            'nama_pasien' => 'nullable|string|max:255'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $review = DoctorReview::create([
            'id_pasien' => $request->id_pasien,
            'nama_dokter' => $request->nama_dokter,
            'rating' => $request->rating,
            'ulasan' => $request->ulasan,
            'email_pasien' => $request->email_pasien,
            'nama_pasien' => $request->nama_pasien,
            'tanggal_penilaian' => now(),
            'is_approved' => false, // Default pending approval
            'is_featured' => false
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Review berhasil disimpan dan menunggu persetujuan',
            'data' => $review
        ], 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(DoctorReview $doctorReview)
    {
        return response()->json([
            'success' => true,
            'data' => $doctorReview
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(DoctorReview $doctorReview)
    {
        return Inertia::render('Admin/DoctorReviews/Edit', [
            'review' => $doctorReview
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, DoctorReview $doctorReview)
    {
        $validator = Validator::make($request->all(), [
            'nama_dokter' => 'sometimes|required|string|max:255',
            'rating' => 'sometimes|required|integer|min:1|max:5',
            'ulasan' => 'nullable|string|max:1000',
            'email_pasien' => 'nullable|email|max:255',
            'nama_pasien' => 'nullable|string|max:255',
            'is_approved' => 'sometimes|boolean',
            'is_featured' => 'sometimes|boolean'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 422);
        }

        $doctorReview->update($request->only([
            'nama_dokter', 'rating', 'ulasan', 'email_pasien', 
            'nama_pasien', 'is_approved', 'is_featured'
        ]));

        return response()->json([
            'success' => true,
            'message' => 'Review berhasil diupdate',
            'data' => $doctorReview->fresh()
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(DoctorReview $doctorReview)
    {
        $doctorReview->delete();

        return response()->json([
            'success' => true,
            'message' => 'Review berhasil dihapus'
        ]);
    }

    /**
     * Approve a review.
     */
    public function approve(DoctorReview $doctorReview)
    {
        $doctorReview->update(['is_approved' => true]);

        return response()->json([
            'success' => true,
            'message' => 'Review berhasil disetujui'
        ]);
    }

    /**
     * Feature a review for landing page.
     */
    public function feature(DoctorReview $doctorReview)
    {
        $doctorReview->update(['is_featured' => !$doctorReview->is_featured]);

        $message = $doctorReview->is_featured 
            ? 'Review berhasil ditampilkan di landing page'
            : 'Review dihapus dari landing page';

        return response()->json([
            'success' => true,
            'message' => $message
        ]);
    }

    /**
     * Get reviews for landing page (public API).
     */
    public function getFeaturedReviews()
    {
        $reviews = DoctorReview::getFeaturedReviews(6);

        return response()->json([
            'success' => true,
            'data' => $reviews
        ]);
    }

    /**
     * Get reviews by doctor (public API).
     */
    public function getReviewsByDoctor(Request $request)
    {
        $doctorName = $request->get('doctor');
        
        if (!$doctorName) {
            return response()->json([
                'success' => false,
                'message' => 'Nama dokter harus disediakan'
            ], 400);
        }

        $reviews = DoctorReview::approved()
            ->byDoctor($doctorName)
            ->orderBy('tanggal_penilaian', 'desc')
            ->paginate(10);

        $averageRating = DoctorReview::getAverageRatingByDoctor($doctorName);
        $totalReviews = DoctorReview::getTotalReviewsByDoctor($doctorName);

        return response()->json([
            'success' => true,
            'data' => [
                'reviews' => $reviews,
                'average_rating' => round($averageRating, 1),
                'total_reviews' => $totalReviews
            ]
        ]);
    }

    /**
     * Get high rated reviews for public display.
     */
    public function getHighRatedReviews()
    {
        $reviews = DoctorReview::getHighRatedReviews(4, 10);

        return response()->json([
            'success' => true,
            'data' => $reviews
        ]);
    }
}
