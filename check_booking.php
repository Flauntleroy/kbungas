<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Foundation\Application;
use App\Models\BookingPeriksa;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

// Check booking data
$booking = BookingPeriksa::where('no_booking', 'TEST-20251018160630')->first();

if ($booking) {
    echo "Booking found:\n";
    echo "No Booking: " . $booking->no_booking . "\n";
    echo "Nama: " . $booking->nama . "\n";
    echo "No Telp: " . $booking->no_telp . "\n";
    echo "Tanggal: " . $booking->tanggal . "\n";
    echo "Status: " . $booking->status . "\n";
    echo "Kode Dokter: " . $booking->kd_dokter . "\n";
    echo "Kode Poli: " . $booking->kd_poli . "\n";
} else {
    echo "Booking not found!\n";
}