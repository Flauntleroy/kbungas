<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\BookingPeriksa;
use App\Services\BookingToRegPeriksa;
use Illuminate\Support\Facades\DB;

class TransferBookingToRegPeriksa extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'booking:transfer-to-reg-periksa 
                            {--booking-id= : Specific booking ID to transfer}
                            {--status= : Transfer bookings with specific status (default: confirmed)}
                            {--date= : Transfer bookings for specific date (Y-m-d format)}
                            {--all : Transfer all confirmed bookings}
                            {--dry-run : Show what would be transferred without actually doing it}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Transfer booking data to reg_periksa table for SIMRS processing';

    protected $transferService;

    public function __construct(BookingToRegPeriksa $transferService)
    {
        parent::__construct();
        $this->transferService = $transferService;
    }

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('Starting booking to reg_periksa transfer process...');

        try {
            DB::beginTransaction();

            $bookings = $this->getBookingsToTransfer();
            
            if ($bookings->isEmpty()) {
                $this->warn('No bookings found matching the criteria.');
                return 0;
            }

            $this->info("Found {$bookings->count()} booking(s) to transfer.");

            if ($this->option('dry-run')) {
                $this->showDryRunResults($bookings);
                return 0;
            }

            $successCount = 0;
            $errorCount = 0;
            $errors = [];

            foreach ($bookings as $booking) {
                try {
                    $this->line("Processing booking: {$booking->no_booking}");
                    
                    $result = $this->transferService->transferBookingToRegPeriksa($booking->no_booking);
                    
                    if ($result['success']) {
                        $successCount++;
                        $noRawat = $result['data']['no_rawat'] ?? 'N/A';
                        $this->info("✓ Successfully transferred booking {$booking->no_booking} -> {$noRawat}");
                    } else {
                        $errorCount++;
                        $errors[] = "Booking {$booking->no_booking}: {$result['message']}";
                        $this->error("✗ Failed to transfer booking {$booking->no_booking}: {$result['message']}");
                    }
                } catch (\Exception $e) {
                    $errorCount++;
                    $errors[] = "Booking {$booking->no_booking}: {$e->getMessage()}";
                    $this->error("✗ Error transferring booking {$booking->no_booking}: {$e->getMessage()}");
                }
            }

            DB::commit();

            // Summary
            $this->newLine();
            $this->info("Transfer completed!");
            $this->table(
                ['Status', 'Count'],
                [
                    ['Successful', $successCount],
                    ['Failed', $errorCount],
                    ['Total', $bookings->count()]
                ]
            );

            if (!empty($errors)) {
                $this->newLine();
                $this->error('Errors encountered:');
                foreach ($errors as $error) {
                    $this->line("  - {$error}");
                }
            }

            return $errorCount > 0 ? 1 : 0;

        } catch (\Exception $e) {
            DB::rollBack();
            $this->error("Fatal error: {$e->getMessage()}");
            return 1;
        }
    }

    private function getBookingsToTransfer()
    {
        $query = BookingPeriksa::query();

        if ($bookingId = $this->option('booking-id')) {
            return $query->where('no_booking', $bookingId)->get();
        }

        if ($this->option('all')) {
            return $query->where('status', 'confirmed')->get();
        }

        $status = $this->option('status') ?? 'confirmed';
        $query->where('status', $status);

        if ($date = $this->option('date')) {
            $query->whereDate('tanggal', $date);
        }

        return $query->get();
    }

    private function showDryRunResults($bookings)
    {
        $this->info('DRY RUN - No actual transfers will be performed');
        $this->newLine();

        $tableData = [];
        foreach ($bookings as $booking) {
            $validation = $this->transferService->validateBookingForTransfer($booking->no_booking);
            
            $tableData[] = [
                $booking->no_booking,
                $booking->nama,
                $booking->tanggal,
                $booking->kd_poli,
                $booking->status,
                $validation['valid'] ? '✓ Valid' : '✗ ' . $validation['message']
            ];
        }

        $this->table(
            ['Booking ID', 'Patient Name', 'Date', 'Poli', 'Status', 'Validation'],
            $tableData
        );
    }
}