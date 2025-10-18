<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

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