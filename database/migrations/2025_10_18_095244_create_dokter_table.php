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
        Schema::create('dokter', function (Blueprint $table) {
            $table->string('kd_dokter', 20)->primary();
            $table->string('nm_dokter', 50)->nullable();
            $table->enum('jk', ['L', 'P'])->nullable();
            $table->string('tmp_lahir', 20)->nullable();
            $table->date('tgl_lahir')->nullable();
            $table->enum('gol_drh', ['A', 'B', 'O', 'AB', '-'])->nullable();
            $table->string('agama', 12)->nullable();
            $table->string('almt_tgl', 60)->nullable();
            $table->string('no_telp', 13)->nullable();
            $table->enum('stts_nikah', ['BELUM MENIKAH', 'MENIKAH', 'JANDA', 'DUDHA', 'JOMBLO'])->nullable();
            $table->char('kd_sps', 5)->nullable();
            $table->string('alumni', 60)->nullable();
            $table->string('no_ijn_praktek', 120)->nullable();
            $table->enum('status', ['0', '1'])->default('1');
            
            // Indexes
            $table->index('kd_sps');
            $table->index('nm_dokter');
            $table->index('jk');
            $table->index('tmp_lahir');
            $table->index('tgl_lahir');
            $table->index('gol_drh');
            $table->index('agama');
            $table->index('almt_tgl');
            $table->index('no_telp');
            $table->index('stts_nikah');
            $table->index('alumni');
            $table->index('no_ijn_praktek');
            $table->index('status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('dokter');
    }
};
