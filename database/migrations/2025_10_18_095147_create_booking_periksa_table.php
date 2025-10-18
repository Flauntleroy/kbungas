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
        Schema::create('booking_periksa', function (Blueprint $table) {
            $table->string('no_booking', 100)->primary();
            $table->string('nik', 400)->nullable();
            $table->string('nomor_kartu', 255)->nullable();
            $table->string('nama', 40)->nullable();
            $table->date('tanggal')->nullable();
            $table->string('alamat', 200)->nullable();
            $table->string('no_telp', 40)->nullable();
            $table->string('email', 50)->nullable();
            $table->string('kd_poli', 55)->nullable();
            $table->string('kd_dokter', 55)->nullable();
            $table->string('kd_pj', 10)->nullable();
            $table->enum('status', ['Diterima', 'Ditolak', 'Belum Dibalas', 'Check In', 'CheckIn'])->default('Belum Dibalas');
            $table->string('catatan', 255)->nullable();
            $table->datetime('tanggal_booking');
            
            // Indexes
            $table->index('kd_poli');
            $table->index('nik');
            $table->index('tanggal');
            $table->index('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('booking_periksa');
    }
};
