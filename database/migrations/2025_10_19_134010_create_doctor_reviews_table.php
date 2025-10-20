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
        Schema::create('doctor_reviews', function (Blueprint $table) {
            $table->id();
            $table->string('id_pasien')->index(); // ID pasien dari sistem
            $table->string('nama_dokter'); // Nama dokter yang direview
            $table->unsignedTinyInteger('rating')->comment('Rating 1-5'); // Rating kepuasan 1-5
            $table->text('ulasan')->nullable(); // Ulasan/komentar pasien
            $table->timestamp('tanggal_penilaian')->useCurrent(); // Tanggal penilaian
            $table->string('email_pasien')->nullable(); // Email pasien untuk follow-up
            $table->string('nama_pasien')->nullable(); // Nama pasien untuk display
            $table->boolean('is_approved')->default(false); // Moderasi review
            $table->boolean('is_featured')->default(false); // Review unggulan untuk landing page
            $table->timestamps();
            
            // Indexes untuk performa
            $table->index(['nama_dokter', 'is_approved']);
            $table->index(['rating', 'is_approved']);
            $table->index(['tanggal_penilaian', 'is_approved']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('doctor_reviews');
    }
};
