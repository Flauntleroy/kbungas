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
});