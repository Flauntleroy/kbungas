<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DoctorReviewController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// BPJS API Routes
Route::prefix('bpjs')->name('api.bpjs.')->group(function () {
    Route::post('/check-nik', [App\Http\Controllers\BpjsController::class, 'checkNik'])->name('check.nik');
    Route::post('/check-kartu', [App\Http\Controllers\BpjsController::class, 'checkKartu'])->name('check.kartu');
    Route::post('/validate-nik', [App\Http\Controllers\BpjsController::class, 'validateNik'])->name('validate.nik');
    Route::get('/status', [App\Http\Controllers\BpjsController::class, 'getApiStatus'])->name('status');
});

// Pasien API Routes
Route::prefix('pasien')->name('api.pasien.')->group(function () {
    Route::post('/validate-nik', [App\Http\Controllers\PasienController::class, 'validateNik'])->name('validate.nik');
    Route::post('/register', [App\Http\Controllers\PasienController::class, 'register'])->name('register');
    Route::get('/get-by-nik', [App\Http\Controllers\PasienController::class, 'getByNik'])->name('get.by.nik');
    Route::put('/{noRkmMedis}', [App\Http\Controllers\PasienController::class, 'update'])->name('update');
});

// Booking API Routes
Route::prefix('booking')->name('api.booking.')->group(function () {
    Route::get('/form-data', [App\Http\Controllers\BookingController::class, 'getFormData'])->name('form.data');
    Route::post('/store', [App\Http\Controllers\BookingController::class, 'store'])->name('store');
    Route::get('/by-nik', [App\Http\Controllers\BookingController::class, 'getByNik'])->name('by.nik');
    Route::get('/by-number', [App\Http\Controllers\BookingController::class, 'getByBookingNumber'])->name('by.number');
    Route::put('/status/{noBooking}', [App\Http\Controllers\BookingController::class, 'updateStatus'])->name('update.status');
    Route::get('/available-slots', [App\Http\Controllers\BookingController::class, 'getAvailableSlots'])->name('available.slots');
    Route::get('/statistics', [App\Http\Controllers\BookingController::class, 'getStatistics'])->name('statistics');
    Route::post('/confirm/{token}', [App\Http\Controllers\BookingController::class, 'confirmBooking'])->name('confirm');
    Route::post('/register-patient/{noBooking}', [App\Http\Controllers\BookingController::class, 'registerPatientFromBooking'])->name('register.patient');
});

// Bookings API Routes (alternative path)
Route::prefix('bookings')->name('api.bookings.')->group(function () {
    Route::post('/{noBooking}/accept', [App\Http\Controllers\BookingController::class, 'acceptBooking'])->name('accept');
});

// Registrasi Periksa API Routes
Route::prefix('reg-periksa')->name('api.reg.periksa.')->group(function () {
    Route::get('/', [App\Http\Controllers\RegPeriksaController::class, 'index'])->name('index');
    Route::post('/', [App\Http\Controllers\RegPeriksaController::class, 'store'])->name('store');
    Route::get('/{noRawat}', [App\Http\Controllers\RegPeriksaController::class, 'show'])->name('show');
    Route::put('/{noRawat}', [App\Http\Controllers\RegPeriksaController::class, 'update'])->name('update');
    Route::delete('/{noRawat}', [App\Http\Controllers\RegPeriksaController::class, 'destroy'])->name('destroy');
    
    // Transfer booking to reg_periksa
    Route::post('/transfer/{noBooking}', [App\Http\Controllers\RegPeriksaController::class, 'transferFromBooking'])->name('transfer.booking');
    Route::post('/transfer-multiple', [App\Http\Controllers\RegPeriksaController::class, 'transferMultipleBookings'])->name('transfer.multiple');
    Route::get('/validate-booking/{noBooking}', [App\Http\Controllers\RegPeriksaController::class, 'validateBookingForTransfer'])->name('validate.booking');
});

// Doctor Reviews Public API Routes
Route::prefix('doctor-reviews')->name('api.doctor.reviews.')->group(function () {
    Route::post('/', [DoctorReviewController::class, 'store'])->name('store');
    Route::get('/featured', [DoctorReviewController::class, 'getFeaturedReviews'])->name('featured');
    Route::get('/by-doctor', [DoctorReviewController::class, 'getReviewsByDoctor'])->name('by.doctor');
    Route::get('/high-rated', [DoctorReviewController::class, 'getHighRatedReviews'])->name('high.rated');
});