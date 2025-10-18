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

Route::get('/booking/confirm/{token}', function ($token) {
    return Inertia::render('BookingConfirmation', ['token' => $token]);
})->name('booking.confirm');

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
