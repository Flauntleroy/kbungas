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
        Schema::create('poliklinik', function (Blueprint $table) {
            $table->char('kd_poli', 5)->primary();
            $table->string('nm_poli', 50)->nullable();
            $table->double('registrasi');
            $table->double('registrasilama');
            $table->enum('status', ['0', '1'])->default('1');
            
            // Indexes
            $table->index('nm_poli');
            $table->index('registrasi');
            $table->index('registrasilama');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('poliklinik');
    }
};
