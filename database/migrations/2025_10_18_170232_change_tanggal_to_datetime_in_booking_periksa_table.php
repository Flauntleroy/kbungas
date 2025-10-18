<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('booking_periksa', function (Blueprint $table) {
            // Ubah field tanggal dari date ke datetime
            $table->datetime('tanggal')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('booking_periksa', function (Blueprint $table) {
            // Kembalikan field tanggal ke tipe date
            $table->date('tanggal')->nullable()->change();
        });
    }
};
