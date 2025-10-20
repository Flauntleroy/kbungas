<?php

namespace App\Http\Controllers;

use App\Models\ClinicSetting;
use App\Models\Service;
use App\Models\ClinicDoctor;
use Illuminate\Http\Request;
use Inertia\Inertia;

class LandingPageController extends Controller
{
    /**
     * Display the landing page with dynamic content from clinic_settings
     */
    public function index()
    {
        // Get all clinic settings for the landing page
        $clinicSettings = $this->getClinicSettings();
        
        return Inertia::render('LandingPage', [
            'clinicSettings' => $clinicSettings
        ]);
    }

    /**
     * Get clinic settings data for landing page
     */
    private function getClinicSettings()
    {
        // Get all settings and organize them by category
        $allSettings = ClinicSetting::getAll();
        
        // Get services from dedicated table
        $servicesFromDb = Service::active()->ordered()->get();
        $servicesItems = [];
        
        if ($servicesFromDb->isNotEmpty()) {
            $servicesItems = $servicesFromDb->map(function ($service) {
                return [
                    'name' => $service->name,
                    'description' => $service->description,
                    'icon' => $service->icon ?: 'medical',
                    'status' => 'available'
                ];
            })->toArray();
        } else {
            // Fallback to default services if no services in dedicated table
            $servicesItems = [
                [
                    'name' => 'Apotek',
                    'description' => 'Menyediakan obat-obatan berkualitas dengan resep dokter dan obat bebas untuk kebutuhan kesehatan Anda.',
                    'icon' => 'pharmacy',
                    'status' => 'available'
                ],
                [
                    'name' => 'Praktek Dokter Umum Estetik',
                    'description' => 'Konsultasi dan perawatan kesehatan umum serta perawatan estetik untuk kecantikan kulit Anda.',
                    'icon' => 'doctor',
                    'status' => 'available'
                ],
                [
                    'name' => 'Praktek Bidan Persalinan 24 Jam',
                    'description' => 'Layanan bidan profesional 24 jam untuk kehamilan, persalinan, dan perawatan ibu dan bayi.',
                    'icon' => 'midwife',
                    'status' => 'available'
                ],
                [
                    'name' => 'Sunat/Khitan Modern',
                    'description' => 'Layanan sunat modern dengan teknologi terkini, aman, dan nyaman untuk anak-anak dan dewasa.',
                    'icon' => 'medical',
                    'status' => 'available'
                ]
            ];
        }
        
        // Get doctors from dedicated table
        $doctorsFromDb = ClinicDoctor::active()->ordered()->get();
        $doctorsData = [];
        
        if ($doctorsFromDb->isNotEmpty()) {
            $doctorsData = $doctorsFromDb->map(function ($doctor) {
                return [
                    'name' => $doctor->name,
                    'specialization' => $doctor->specialization,
                    'description' => $doctor->description,
                    'photo' => $doctor->photo,
                    'whatsapp' => $doctor->whatsapp,
                    'available' => $doctor->available
                ];
            })->toArray();
        } else {
            // Fallback to settings data if no doctors in dedicated table
            $doctorsData = [[
                'name' => $allSettings['doctors.primary.name'] ?? 'dr. Bunga Sari, Sp.KK',
                'specialization' => $allSettings['doctors.primary.specialization'] ?? 'Spesialis Kulit & Kelamin',
                'description' => $allSettings['doctors.primary.description'] ?? 'Dokter berpengalaman lebih dari 10 tahun dengan fokus pada dermatologi klinis, perawatan kulit estetika, dan penanganan penyakit kelamin dengan pendekatan humanis.',
                'photo' => $allSettings['doctors.primary.photo'] ?? '/images/doctors/dr-bungas.svg',
                'whatsapp' => $allSettings['doctors.primary.whatsapp'] ?? '',
                'available' => ($allSettings['doctors.primary.available'] ?? '1') === '1'
            ]];
        }
        
        return [
            // Hero Section
            'hero' => [
                'title' => $allSettings['hero.title'] ?? 'Kesehatan & Kecantikan Terpercaya',
                'subtitle' => $allSettings['hero.subtitle'] ?? 'Dapatkan perawatan kesehatan dan kecantikan terbaik dengan dokter berpengalaman dan fasilitas modern di Klinik Bungas.',
                'cta_text' => $allSettings['hero.cta_text'] ?? 'Booking Sekarang',
                'cta_link' => $allSettings['hero.cta_link'] ?? '/booking'
            ],
            
            // Services Section
            'services' => [
                'title' => $allSettings['services.title'] ?? 'Layanan Kami',
                'subtitle' => $allSettings['services.subtitle'] ?? 'Kami menyediakan berbagai layanan kesehatan dan kecantikan dengan standar pelayanan terbaik',
                'items' => $servicesItems
            ],
            
            // Doctor Section - Updated to use array format instead of primary key
            'doctors' => $doctorsData,
            
            // Contact Section
            'contact' => [
                'address' => $allSettings['contact.address'] ?? 'Jl. Raya Bungas No. 123, Kecamatan Bungas, Kabupaten Bungas, Provinsi Bungas 12345',
                'phone' => $allSettings['contact.phone'] ?? '+62 812-3456-7890',
                'whatsapp' => [
                    'number' => $allSettings['contact.whatsapp'] ?? '6281234567890',
                    'text' => $allSettings['contact.whatsapp.text'] ?? 'Halo Klinik Bungas, saya ingin booking janji temu'
                ],
                'maps_link' => $allSettings['contact.maps_link'] ?? 'https://maps.google.com/?q=Klinik+Bungas',
                'maps_embed' => $allSettings['contact.maps_embed'] ?? 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3966.521260322283!2d106.8195613!3d-6.2087634!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69f5390917b759%3A0x6b45e67356080477!2sKlinik%20Bungas!5e0!3m2!1sen!2sid!4v1635724000000!5m2!1sen!2sid'
            ],
            
            // General Settings
            'general' => [
                'clinic_name' => $allSettings['general.clinic_name'] ?? 'Klinik Bungas',
                'tagline' => $allSettings['general.tagline'] ?? 'Kesehatan & Kecantikan Terpercaya',
                'description' => $allSettings['general.description'] ?? 'Klinik Bungas adalah klinik kesehatan dan kecantikan terpercaya yang memberikan pelayanan terbaik dengan dokter berpengalaman dan fasilitas modern.'
            ]
        ];
    }

    /**
     * API endpoint to get clinic settings (for AJAX requests)
     */
    public function getSettings(Request $request)
    {
        $category = $request->get('category');
        
        if ($category) {
            $settings = ClinicSetting::getByPrefix($category);
        } else {
            $settings = $this->getClinicSettings();
        }
        
        return response()->json([
            'success' => true,
            'data' => $settings
        ]);
    }
}