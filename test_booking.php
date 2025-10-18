<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Foundation\Application;
use App\Models\BookingPeriksa;
use Carbon\Carbon;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

// Generate unique booking number
$bookingNumber = 'TEST-' . date('YmdHis') . rand(10, 99);

// Create new booking
$booking = BookingPeriksa::create([
    'no_booking' => $bookingNumber,
    'tanggal_booking' => now(),
    'nama' => 'Test Patient 3',
    'no_telp' => '6281234567891',
    'tanggal' => Carbon::tomorrow()->format('Y-m-d H:i:s'),
    'kd_dokter' => 'DR001',
    'kd_poli' => 'UMUM',
    'status' => 'Belum Dibalas'
]);

echo "Booking created successfully!\n";
echo "Booking Number: " . $booking->no_booking . "\n";
echo "Patient Name: " . $booking->nama . "\n";
echo "Phone: " . $booking->no_telp . "\n";
echo "Date: " . $booking->tanggal . "\n";
echo "Doctor: " . $booking->kd_dokter . "\n";
echo "Status: " . $booking->status . "\n";