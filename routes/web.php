<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return redirect('/klinik');
})->name('home');

Route::get('/klinik', function () {
    return Inertia::render('LandingPage');
})->name('klinik.landing');

Route::get('dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::get('/booking', function () {
    return Inertia::render('Booking');
})->name('booking');

// BPJS API Routes
Route::prefix('api/bpjs')->name('api.bpjs.')->group(function () {
    Route::post('/check-nik', [App\Http\Controllers\BpjsController::class, 'checkNik'])->name('check.nik');
    Route::post('/check-kartu', [App\Http\Controllers\BpjsController::class, 'checkKartu'])->name('check.kartu');
    Route::post('/validate-nik', [App\Http\Controllers\BpjsController::class, 'validateNik'])->name('validate.nik');
    Route::get('/status', [App\Http\Controllers\BpjsController::class, 'getApiStatus'])->name('status');
});

// Booking API Routes
Route::prefix('api/booking')->name('api.booking.')->group(function () {
    Route::get('/form-data', [App\Http\Controllers\BookingController::class, 'getFormData'])->name('form.data');
    Route::post('/store', [App\Http\Controllers\BookingController::class, 'store'])->name('store');
    Route::get('/by-nik', [App\Http\Controllers\BookingController::class, 'getByNik'])->name('by.nik');
    Route::get('/by-number', [App\Http\Controllers\BookingController::class, 'getByBookingNumber'])->name('by.number');
    Route::put('/status/{noBooking}', [App\Http\Controllers\BookingController::class, 'updateStatus'])->name('update.status');
    Route::get('/available-slots', [App\Http\Controllers\BookingController::class, 'getAvailableSlots'])->name('available.slots');
    Route::get('/statistics', [App\Http\Controllers\BookingController::class, 'getStatistics'])->name('statistics');
});

// Admin Routes - Protected by auth middleware
Route::middleware(['auth', 'verified'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Admin/Dashboard');
    })->name('dashboard');
    
    Route::get('/bookings', function () {
        return Inertia::render('Admin/Bookings');
    })->name('bookings');
    
    Route::get('/content', function () {
        return Inertia::render('Admin/Content');
    })->name('content');
    
    Route::get('/users', function () {
        return Inertia::render('Admin/Users');
    })->name('users');
});

require __DIR__.'/settings.php';
require __DIR__.'/auth.php';
