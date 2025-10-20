<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\ClinicSetting;

class ClinicSettingsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $settings = [
            // General Settings
            [
                'key' => 'general.clinic_name',
                'value' => 'Klinik Bungas',
                'type' => 'string',
                'description' => 'Nama klinik'
            ],
            [
                'key' => 'general.tagline',
                'value' => 'Klinik Kulit & Kecantikan Terpercaya',
                'type' => 'string',
                'description' => 'Tagline klinik'
            ],
            [
                'key' => 'general.description',
                'value' => 'Dapatkan perawatan kulit terbaik dengan teknologi modern dan dokter berpengalaman. Konsultasi gratis untuk semua pasien baru.',
                'type' => 'string',
                'description' => 'Deskripsi klinik'
            ],

            // Hero Section
            [
                'key' => 'hero.title',
                'value' => 'Klinik Kulit & Kecantikan Terpercaya',
                'type' => 'string',
                'description' => 'Judul utama hero section'
            ],
            [
                'key' => 'hero.subtitle',
                'value' => 'Dapatkan perawatan kulit terbaik dengan teknologi modern dan dokter berpengalaman. Konsultasi gratis untuk semua pasien baru.',
                'type' => 'string',
                'description' => 'Subjudul hero section'
            ],
            [
                'key' => 'hero.cta_text',
                'value' => 'Booking Konsultasi',
                'type' => 'string',
                'description' => 'Teks tombol CTA'
            ],
            [
                'key' => 'hero.cta_link',
                'value' => '/booking',
                'type' => 'string',
                'description' => 'Link tombol CTA'
            ],

            // Services Section
            [
                'key' => 'services.title',
                'value' => 'Layanan Kami',
                'type' => 'string',
                'description' => 'Judul section layanan'
            ],
            [
                'key' => 'services.subtitle',
                'value' => 'Kami menyediakan berbagai layanan kesehatan dan kecantikan dengan standar pelayanan terbaik',
                'type' => 'string',
                'description' => 'Subjudul section layanan'
            ],
            [
                'key' => 'services.items',
                'value' => json_encode([
                    [
                        'name' => 'Konsultasi Kulit',
                        'description' => 'Konsultasi menyeluruh untuk berbagai masalah kulit dengan dokter spesialis',
                        'icon' => '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>',
                        'status' => 'available'
                    ],
                    [
                        'name' => 'Perawatan Jerawat',
                        'description' => 'Treatment khusus untuk mengatasi jerawat dan bekasnya',
                        'icon' => '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/></svg>',
                        'status' => 'available'
                    ]
                ]),
                'type' => 'string',
                'description' => 'Daftar layanan dalam format JSON'
            ],

            // Doctor Section
            [
                'key' => 'doctors.primary.name',
                'value' => 'dr. Aan Widhi Anningrum',
                'type' => 'string',
                'description' => 'Nama dokter utama'
            ],
            [
                'key' => 'doctors.primary.specialization',
                'value' => 'Dokter Umum',
                'type' => 'string',
                'description' => 'Spesialisasi dokter utama'
            ],
            [
                'key' => 'doctors.primary.description',
                'value' => 'Berpengalaman lebih dari 10 tahun dalam menangani berbagai masalah kulit',
                'type' => 'string',
                'description' => 'Deskripsi dokter utama'
            ],
            [
                'key' => 'doctors.primary.photo',
                'value' => '/images/doctors/dr-sarah.jpg',
                'type' => 'string',
                'description' => 'Foto dokter utama'
            ],

            // Contact Section
            [
                'key' => 'contact.address',
                'value' => 'Jl. Kesehatan No. 123, Jakarta Selatan',
                'type' => 'string',
                'description' => 'Alamat klinik'
            ],
            [
                'key' => 'contact.phone',
                'value' => '021-12345678',
                'type' => 'string',
                'description' => 'Nomor telepon klinik'
            ],
            [
                'key' => 'contact.whatsapp.number',
                'value' => '6281234567890',
                'type' => 'string',
                'description' => 'Nomor WhatsApp'
            ],
            [
                'key' => 'contact.whatsapp.text',
                'value' => 'Halo Klinik Bungas, saya ingin booking janji temu',
                'type' => 'string',
                'description' => 'Teks default WhatsApp'
            ],
            [
                'key' => 'contact.maps_link',
                'value' => 'https://maps.google.com/?q=Klinik+Bungas',
                'type' => 'string',
                'description' => 'Link Google Maps'
            ],
            [
                'key' => 'contact.maps_embed',
                'value' => 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3966.521260322283!2d106.8195613!3d-6.2087634!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69f5390917b759%3A0x6b45e67356080477!2sKlinik%20Bungas!5e0!3m2!1sen!2sid!4v1635724000000!5m2!1sen!2sid',
                'type' => 'string',
                'description' => 'Embed Google Maps'
            ]
        ];

        foreach ($settings as $setting) {
            ClinicSetting::updateOrCreate(
                ['key' => $setting['key']],
                $setting
            );
        }
    }
}
