<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return redirect('/klinik');
})->name('home');

Route::get('/klinik', function () {
    return Inertia::render('LandingPage');
})->name('klinik.landing');

Route::get('/booking', function () {
    return Inertia::render('Booking');
})->name('booking');

Route::get('/booking/confirm/{token}', function ($token) {
    return view('booking.confirm', ['token' => $token]);
})->name('booking.confirm');

// Admin Routes - Protected by auth middleware
Route::middleware(['auth', 'verified'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/dashboard', [App\Http\Controllers\AdminController::class, 'dashboard'])->name('dashboard');
    
    Route::get('/bookings', [App\Http\Controllers\AdminController::class, 'bookings'])->name('bookings');
    
    Route::get('/content', [App\Http\Controllers\AdminController::class, 'content'])->name('content');
    Route::post('/content', [App\Http\Controllers\AdminController::class, 'updateContent'])->name('content.update');
    
    Route::get('/users', [App\Http\Controllers\AdminController::class, 'users'])->name('users');
    Route::post('/users', [App\Http\Controllers\AdminController::class, 'storeUser'])->name('users.store');
    Route::put('/users/{user}', [App\Http\Controllers\AdminController::class, 'updateUser'])->name('users.update');
    Route::delete('/users/{user}', [App\Http\Controllers\AdminController::class, 'deleteUser'])->name('users.delete');
    Route::patch('/users/{user}/toggle-status', [App\Http\Controllers\AdminController::class, 'toggleUserStatus'])->name('users.toggle-status');
    
    // Registrasi Periksa Routes
    Route::get('/reg-periksa', [App\Http\Controllers\AdminController::class, 'regPeriksa'])->name('reg-periksa.index');
    Route::get('/reg-periksa/{noRawat}', [App\Http\Controllers\AdminController::class, 'showRegPeriksa'])->name('reg-periksa.show');
});

require __DIR__.'/settings.php';
require __DIR__.'/auth.php';
