<?php

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\AdminController;
use App\Http\Controllers\LandingPageController;

Route::get('/', function () {
    return redirect('/klinik');
})->name('home');

Route::get('/klinik', [LandingPageController::class, 'index'])->name('klinik.landing');

Route::get('/booking', function () {
    return Inertia::render('Booking');
})->name('booking');

Route::get('/booking/confirm/{token}', function ($token) {
    return view('booking.confirm', ['token' => $token]);
})->name('booking.confirm');

Route::get('/review', function () {
    return Inertia::render('ReviewPage');
})->name('review');

Route::middleware(['auth'])->prefix('admin')->group(function () {
    Route::get('/dashboard', [AdminController::class, 'dashboard'])->name('admin.dashboard');
    Route::get('/bookings', [AdminController::class, 'bookings'])->name('admin.bookings');
    Route::get('/content', [AdminController::class, 'content'])->name('admin.content');
    Route::post('/content', [AdminController::class, 'updateContent'])->name('admin.content.update');
    Route::get('/users', [AdminController::class, 'users'])->name('admin.users');
    Route::get('/doctor-reviews', [AdminController::class, 'doctorReviews'])->name('admin.doctor-reviews');
    Route::post('/users', [AdminController::class, 'storeUser'])->name('admin.users.store');
    Route::put('/users/{user}', [AdminController::class, 'updateUser'])->name('admin.users.update');
    Route::delete('/users/{user}', [AdminController::class, 'deleteUser'])->name('admin.users.delete');
    Route::patch('/users/{user}/toggle-status', [AdminController::class, 'toggleUserStatus'])->name('admin.users.toggle-status');
    Route::get('/reg-periksa', [AdminController::class, 'regPeriksa'])->name('admin.reg-periksa');
    Route::get('/reg-periksa/{noRawat}', [AdminController::class, 'showRegPeriksa'])->name('admin.reg-periksa.show');
});

require __DIR__.'/settings.php';
require __DIR__.'/auth.php';
