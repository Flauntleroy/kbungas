<?php

require_once __DIR__ . '/vendor/autoload.php';

use Illuminate\Foundation\Application;
use App\Services\WhatsAppService;
use ReflectionClass;

// Bootstrap Laravel
$app = require_once __DIR__ . '/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

// Create WhatsAppService instance
$whatsAppService = new WhatsAppService();

// Use reflection to access private method
$reflection = new ReflectionClass($whatsAppService);
$method = $reflection->getMethod('generateConfirmationToken');
$method->setAccessible(true);

// Generate token for the new booking
$bookingId = 'TEST-2025101816530248';
$doctorId = 'DR001';

try {
    $token = $method->invoke($whatsAppService, $bookingId, $doctorId);
    
    echo "Booking ID: $bookingId\n";
    echo "Doctor ID: $doctorId\n";
    echo "Confirmation Token: $token\n";
    echo "Confirmation URL: " . url("/booking/confirm/{$token}") . "\n";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}