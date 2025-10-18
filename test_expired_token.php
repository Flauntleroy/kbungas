<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Foundation\Application;
use Carbon\Carbon;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

// Create expired token manually
$bookingId = 'TEST-2025101816154771';
$doctorId = 'DR001';

// Create token data with expired timestamp (24 hours ago)
$tokenData = [
    'booking_id' => $bookingId,
    'doctor_id' => $doctorId,
    'expires_at' => Carbon::now()->subHours(25)->toISOString(), // Expired 25 hours ago
    'created_at' => Carbon::now()->subHours(26)->toISOString(),
    'hash' => hash('sha256', $bookingId . $doctorId . config('app.key') . date('Y-m-d', strtotime('-1 day')))
];

// Encode token
$expiredToken = base64_encode(json_encode($tokenData));

echo "Expired Token Test\n";
echo "Booking ID: $bookingId\n";
echo "Doctor ID: $doctorId\n";
echo "Expired Token: $expiredToken\n";
echo "Expired URL: " . url("/booking/confirm/{$expiredToken}") . "\n";
echo "Token expires at: " . $tokenData['expires_at'] . "\n";
echo "Current time: " . Carbon::now()->toISOString() . "\n";