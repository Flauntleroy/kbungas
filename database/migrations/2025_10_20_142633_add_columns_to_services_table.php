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
        Schema::table('services', function (Blueprint $table) {
            $table->string('name')->after('id');
            $table->text('description')->after('name');
            $table->string('icon')->nullable()->after('description');
            $table->integer('order')->default(0)->after('icon');
            $table->boolean('is_active')->default(true)->after('order');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('services', function (Blueprint $table) {
            $table->dropColumn(['name', 'description', 'icon', 'order', 'is_active']);
        });
    }
};
