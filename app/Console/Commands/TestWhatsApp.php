<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Services\WhatsAppService;
use App\Models\BookingPeriksa;

class TestWhatsApp extends Command
{
    /**
     * The name and signature of the console command.
     */
    protected $signature = 'whatsapp:test {--check-connection} {--test-message=} {--booking-id=}';

    /**
     * The console command description.
     */
    protected $description = 'Test WhatsApp service functionality';

    protected $whatsAppService;

    public function __construct(WhatsAppService $whatsAppService)
    {
        parent::__construct();
        $this->whatsAppService = $whatsAppService;
    }

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('🚀 Testing WhatsApp Service...');
        $this->newLine();

        // Test koneksi ke Fonnte API
        if ($this->option('check-connection')) {
            $this->testConnection();
            return;
        }

        // Test pengiriman pesan manual
        if ($this->option('test-message')) {
            $phone = $this->ask('Masukkan nomor telepon tujuan (format: 08xxxxxxxxx)');
            if ($phone) {
                $this->testMessage($phone, $this->option('test-message'));
            }
            return;
        }

        // Test notifikasi booking
        if ($this->option('booking-id')) {
            $this->testBookingNotification($this->option('booking-id'));
            return;
        }

        // Menu interaktif
        $this->showMenu();
    }

    private function testConnection()
    {
        $this->info('🔍 Checking connection to Fonnte API...');
        
        $result = $this->whatsAppService->checkConnection();
        
        if ($result['success']) {
            $this->info('✅ Connection successful!');
            $this->line('Response: ' . json_encode($result['data'], JSON_PRETTY_PRINT));
        } else {
            $this->error('❌ Connection failed!');
            $this->line('Error: ' . $result['message']);
        }
    }

    private function testMessage($phone, $message)
    {
        $this->info("📱 Sending test message to: {$phone}");
        $this->line("Message: {$message}");
        
        $result = $this->whatsAppService->sendMessage($phone, $message);
        
        if ($result['success']) {
            $this->info('✅ Message sent successfully!');
            $this->line('Response: ' . json_encode($result['data'], JSON_PRETTY_PRINT));
        } else {
            $this->error('❌ Failed to send message!');
            $this->line('Error: ' . $result['message']);
        }
    }

    private function testBookingNotification($bookingId)
    {
        $this->info("🏥 Testing booking notification for ID: {$bookingId}");
        
        $booking = BookingPeriksa::where('no_booking', $bookingId)
            ->with(['poliklinik', 'dokter', 'penjab'])
            ->first();
        
        if (!$booking) {
            $this->error('❌ Booking not found!');
            return;
        }

        $this->info('📋 Booking details:');
        $this->table(
            ['Field', 'Value'],
            [
                ['No. Booking', $booking->no_booking],
                ['Patient', $booking->nama],
                ['Phone', $booking->no_telp],
                ['Doctor', $booking->dokter->nm_dokter],
                ['Doctor Phone', $booking->dokter->no_telp],
                ['Date', $booking->tanggal_formatted],
                ['Poliklinik', $booking->poliklinik->nm_poli],
            ]
        );

        if ($this->confirm('Send notification to patient?')) {
            $patientResult = $this->whatsAppService->sendBookingConfirmationToPatient($booking);
            
            if ($patientResult['success']) {
                $this->info('✅ Patient notification sent successfully!');
            } else {
                $this->error('❌ Failed to send patient notification: ' . $patientResult['message']);
            }
        }

        if ($this->confirm('Send notification to doctor?')) {
            $doctorResult = $this->whatsAppService->sendBookingNotificationToDoctor($booking);
            
            if ($doctorResult['success']) {
                $this->info('✅ Doctor notification sent successfully!');
            } else {
                $this->error('❌ Failed to send doctor notification: ' . $doctorResult['message']);
            }
        }
    }

    private function showMenu()
    {
        $choice = $this->choice(
            'What would you like to test?',
            [
                'connection' => 'Check API Connection',
                'message' => 'Send Test Message',
                'booking' => 'Test Booking Notification',
                'exit' => 'Exit'
            ],
            'connection'
        );

        switch ($choice) {
            case 'connection':
                $this->testConnection();
                break;
                
            case 'message':
                $phone = $this->ask('Enter phone number (format: 08xxxxxxxxx)');
                $message = $this->ask('Enter message');
                if ($phone && $message) {
                    $this->testMessage($phone, $message);
                }
                break;
                
            case 'booking':
                $bookingId = $this->ask('Enter booking ID');
                if ($bookingId) {
                    $this->testBookingNotification($bookingId);
                }
                break;
                
            case 'exit':
                $this->info('👋 Goodbye!');
                return;
        }

        $this->newLine();
        if ($this->confirm('Test something else?')) {
            $this->showMenu();
        }
    }
}