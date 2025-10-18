<?php

namespace Database\Seeders;

use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // User::factory(10)->create();

        // Create Test User
        User::factory()->create([
            'name' => 'Test User',
            'email' => 'test@example.com',
        ]);

        // Create Admin Users from SQL seed data
        User::factory()->create([
            'name' => 'Super Admin',
            'email' => 'admin@klinikbungas.com',
            'password' => 'password', // Will be hashed by factory
        ]);

        User::factory()->create([
            'name' => 'Dr. Admin',
            'email' => 'doctor.admin@klinikbungas.com',
            'password' => 'password', // Will be hashed by factory
        ]);

        User::factory()->create([
            'name' => 'Staff Resepsionis',
            'email' => 'staff@klinikbungas.com',
            'password' => 'password', // Will be hashed by factory
        ]);
    }
}
