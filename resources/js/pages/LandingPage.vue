<script setup lang="ts">
import { Head } from '@inertiajs/vue3';
</script>

<template>
    <Head title="Klinik Bungas - Layanan Kesehatan Terpercaya" />
    
    <div class="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-white">
        <!-- Header -->
        <header class="bg-white/95 backdrop-blur-sm shadow-sm sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center py-4">
                    <div class="flex items-center space-x-3">
                        <!-- Medical Logo SVG -->
                        <div class="flex-shrink-0">
                            <svg class="w-10 h-10 text-rose-500" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.94-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z"/>
                            </svg>
                        </div>
                        <div>
                            <h1 class="text-2xl font-bold text-rose-600">Klinik Bungas</h1>
                            <p class="text-xs text-rose-400 font-medium">Kesehatan Terpercaya</p>
                        </div>
                    </div>
                    <nav class="hidden md:flex space-x-8">
                        <a href="#layanan" class="text-gray-700 hover:text-rose-600 transition-colors font-medium">Layanan</a>
                        <a href="#dokter" class="text-gray-700 hover:text-rose-600 transition-colors font-medium">Dokter</a>
                        <a href="#tentang" class="text-gray-700 hover:text-rose-600 transition-colors font-medium">Tentang</a>
                        <a href="#kontak" class="text-gray-700 hover:text-rose-600 transition-colors font-medium">Kontak</a>
                    </nav>
                    <div class="flex items-center space-x-4">
                        <button class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-2.5 rounded-full hover:from-rose-600 hover:to-pink-600 transition-all duration-300 font-semibold shadow-lg hover:shadow-xl">
                            Buat Janji
                        </button>
                    </div>
                </div>
            </div>
        </header>

        <!-- Hero Section -->
        <section class="py-20 relative overflow-hidden">
            <!-- Background Pattern -->
            <div class="absolute inset-0 opacity-5">
                <svg class="w-full h-full" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                    <defs>
                        <pattern id="medical-pattern" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse">
                            <circle cx="10" cy="10" r="1" fill="currentColor" class="text-rose-400"/>
                            <path d="M10 6v8M6 10h8" stroke="currentColor" stroke-width="0.5" class="text-rose-300"/>
                        </pattern>
                    </defs>
                    <rect width="100%" height="100%" fill="url(#medical-pattern)"/>
                </svg>
            </div>
            
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative">
                <div class="grid lg:grid-cols-2 gap-12 items-center">
                    <div class="text-center lg:text-left">
                        <div class="inline-flex items-center bg-rose-100 text-rose-700 px-4 py-2 rounded-full text-sm font-medium mb-6">
                            <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                            </svg>
                            Terpercaya sejak 2010
                        </div>
                        <h2 class="text-4xl md:text-6xl font-bold text-gray-900 mb-6 leading-tight">
                            Layanan Kesehatan
                            <span class="text-transparent bg-clip-text bg-gradient-to-r from-rose-500 to-pink-500">Terpercaya</span>
                        </h2>
                        <p class="text-xl text-gray-600 mb-8 max-w-2xl">
                            Klinik Bungas menyediakan layanan kesehatan berkualitas tinggi dengan dokter berpengalaman 
                            dan fasilitas modern untuk kesehatan keluarga Anda.
                        </p>
                        <div class="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start">
                            <button class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-8 py-4 rounded-full text-lg font-semibold hover:from-rose-600 hover:to-pink-600 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                                <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                </svg>
                                Buat Janji Sekarang
                            </button>
                            <button class="border-2 border-rose-300 text-rose-600 px-8 py-4 rounded-full text-lg font-semibold hover:bg-rose-50 transition-all duration-300">
                                <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                Pelajari Lebih Lanjut
                            </button>
                        </div>
                    </div>
                    
                    <!-- Hero Illustration -->
                    <div class="relative">
                        <div class="relative bg-gradient-to-br from-rose-100 to-pink-100 rounded-3xl p-8 shadow-2xl">
                            <!-- Doctor Illustration SVG -->
                            <svg class="w-full h-96" viewBox="0 0 400 400" xmlns="http://www.w3.org/2000/svg">
                                <!-- Background -->
                                <rect width="400" height="400" fill="url(#doctorGradient)" rx="20"/>
                                <defs>
                                    <linearGradient id="doctorGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                                        <stop offset="0%" style="stop-color:#fdf2f8"/>
                                        <stop offset="100%" style="stop-color:#fce7f3"/>
                                    </linearGradient>
                                </defs>
                                
                                <!-- Doctor Figure -->
                                <g transform="translate(100, 50)">
                                    <!-- Head -->
                                    <circle cx="100" cy="80" r="40" fill="#f3e8ff" stroke="#e879f9" stroke-width="2"/>
                                    <!-- Hair -->
                                    <path d="M70 60 Q100 40 130 60 Q130 50 100 45 Q70 50 70 60" fill="#6b7280"/>
                                    <!-- Face -->
                                    <circle cx="90" cy="75" r="2" fill="#374151"/>
                                    <circle cx="110" cy="75" r="2" fill="#374151"/>
                                    <path d="M95 85 Q100 90 105 85" stroke="#374151" stroke-width="1.5" fill="none"/>
                                    
                                    <!-- Body -->
                                    <rect x="75" y="120" width="50" height="80" rx="10" fill="white" stroke="#e879f9" stroke-width="2"/>
                                    <!-- Stethoscope -->
                                    <path d="M85 130 Q100 140 115 130" stroke="#e879f9" stroke-width="3" fill="none"/>
                                    <circle cx="85" cy="130" r="4" fill="#e879f9"/>
                                    <circle cx="115" cy="130" r="4" fill="#e879f9"/>
                                    
                                    <!-- Arms -->
                                    <rect x="55" y="130" width="15" height="40" rx="7" fill="#f3e8ff"/>
                                    <rect x="130" y="130" width="15" height="40" rx="7" fill="#f3e8ff"/>
                                    
                                    <!-- Medical Cross -->
                                    <g transform="translate(90, 150)">
                                        <rect x="8" y="5" width="4" height="15" fill="#e879f9"/>
                                        <rect x="3" y="10" width="14" height="4" fill="#e879f9"/>
                                    </g>
                                </g>
                                
                                <!-- Medical Icons -->
                                <g opacity="0.3">
                                    <circle cx="50" cy="100" r="15" fill="#fce7f3"/>
                                    <path d="M45 100h10M50 95v10" stroke="#e879f9" stroke-width="2"/>
                                    
                                    <circle cx="350" cy="150" r="12" fill="#fce7f3"/>
                                    <path d="M346 150h8M350 146v8" stroke="#e879f9" stroke-width="1.5"/>
                                    
                                    <circle cx="80" cy="300" r="10" fill="#fce7f3"/>
                                    <path d="M76 300h8M80 296v8" stroke="#e879f9" stroke-width="1.5"/>
                                </g>
                            </svg>
                        </div>
                        
                        <!-- Floating Elements -->
                        <div class="absolute -top-4 -right-4 bg-white rounded-full p-3 shadow-lg animate-bounce">
                            <svg class="w-6 h-6 text-rose-500" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd"/>
                            </svg>
                        </div>
                        <div class="absolute -bottom-4 -left-4 bg-white rounded-full p-3 shadow-lg animate-pulse">
                            <svg class="w-6 h-6 text-pink-500" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Services Section -->
        <section id="layanan" class="py-20 bg-gradient-to-br from-rose-50 to-pink-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <div class="inline-flex items-center bg-rose-100 text-rose-700 px-4 py-2 rounded-full text-sm font-medium mb-4">
                        <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Layanan Unggulan
                    </div>
                    <h3 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">
                        Layanan Kesehatan <span class="text-transparent bg-clip-text bg-gradient-to-r from-rose-500 to-pink-500">Komprehensif</span>
                    </h3>
                    <p class="text-lg text-gray-600 max-w-3xl mx-auto">
                        Kami menyediakan berbagai layanan kesehatan dengan standar internasional untuk memenuhi kebutuhan medis Anda dan keluarga.
                    </p>
                </div>
                
                <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <!-- Konsultasi Dokter -->
                    <div class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border border-rose-100">
                        <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                            <svg class="w-8 h-8 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                            </svg>
                        </div>
                        <h4 class="text-xl font-bold text-gray-900 mb-3">Konsultasi Dokter Umum</h4>
                        <p class="text-gray-600 mb-4">Pemeriksaan kesehatan rutin dan konsultasi dengan dokter umum berpengalaman untuk menjaga kesehatan Anda.</p>
                        <div class="flex items-center text-rose-600 font-semibold">
                            <span>Mulai dari Rp 150.000</span>
                            <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
                        </div>
                    </div>

                    <!-- Pemeriksaan Lab -->
                    <div class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border border-rose-100">
                        <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                            <svg class="w-8 h-8 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
                            </svg>
                        </div>
                        <h4 class="text-xl font-bold text-gray-900 mb-3">Pemeriksaan Laboratorium</h4>
                        <p class="text-gray-600 mb-4">Tes darah lengkap, urine, dan berbagai pemeriksaan lab dengan teknologi modern dan hasil akurat.</p>
                        <div class="flex items-center text-rose-600 font-semibold">
                            <span>Mulai dari Rp 75.000</span>
                            <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
                        </div>
                    </div>

                    <!-- Gawat Darurat -->
                    <div class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border border-rose-100">
                        <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-16 h-16 rounded-2xl flex items-center justify-center mb-6">
                            <svg class="w-8 h-8 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                            </svg>
                        </div>
                        <h4 class="text-xl font-bold text-gray-900 mb-3">Gawat Darurat 24/7</h4>
                        <p class="text-gray-600 mb-4">Layanan gawat darurat 24 jam dengan tim medis yang siap siaga untuk menangani kondisi darurat.</p>
                        <div class="flex items-center text-rose-600 font-semibold">
                            <span>Tersedia 24/7</span>
                            <svg class="w-4 h-4 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                            </svg>
                        </div>
                    </div>
                </div>
                
                <!-- Call to Action -->
                <div class="text-center mt-12">
                    <button class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-8 py-4 rounded-full text-lg font-semibold hover:from-rose-600 hover:to-pink-600 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                        <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                        </svg>
                        Konsultasi Gratis Sekarang
                    </button>
                </div>
            </div>
        </section>

        <!-- Doctors Section -->
        <section id="dokter" class="py-20 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <div class="inline-flex items-center bg-rose-100 text-rose-700 px-4 py-2 rounded-full text-sm font-medium mb-4">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 8a6 6 0 1112 0v2a2 2 0 002 2h1a2 2 0 012 2v3a2 2 0 01-2 2h-1a2 2 0 00-2 2v1a2 2 0 01-2 2H8a2 2 0 01-2-2v-1a2 2 0 00-2-2H3a2 2 0 01-2-2v-3a2 2 0 012-2h1a2 2 0 002-2V8z"/>
                        </svg>
                        Dokter Kami
                    </div>
                    <h3 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">Profil Dokter</h3>
                    <p class="text-gray-600 max-w-2xl mx-auto">Kami menghadirkan dokter profesional dengan pendekatan ramah dan berorientasi pada pasien.</p>
                </div>
                
                <div class="max-w-3xl mx-auto">
                    <div class="bg-gradient-to-br from-rose-50 to-pink-50 rounded-3xl p-8 border border-rose-100 shadow-lg flex flex-col md:flex-row items-center gap-8">
                        <div class="relative">
                            <div class="absolute -top-3 -right-3 bg-white rounded-full p-2 shadow-md">
                                <svg class="w-4 h-4 text-rose-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v8m-4-4h8"/>
                                </svg>
                            </div>
                            <img src="/images/doctors/dr-bungas.svg" alt="Foto dr. Bunga Sari, Sp.KK" class="w-32 h-32 rounded-2xl bg-white p-2 border border-rose-200 shadow-md">
                        </div>
                        <div class="flex-1">
                            <h4 class="text-2xl font-bold text-gray-900 mb-1">dr. Bunga Sari, Sp.KK</h4>
                            <p class="text-rose-600 font-medium mb-4">Spesialis Kulit & Kelamin</p>
                            <p class="text-gray-600 mb-6">Dokter berpengalaman lebih dari 10 tahun dengan fokus pada dermatologi klinis, perawatan kulit estetika, dan penanganan penyakit kelamin dengan pendekatan humanis.</p>
                            <div class="flex flex-wrap gap-3">
                                <a href="/booking" class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-3 rounded-xl font-semibold hover:from-rose-600 hover:to-pink-600 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                                    Booking
                                </a>
                                <a href="https://wa.me/6281234567890?text=Halo%20Klinik%20Bungas,%20saya%20ingin%20booking%20janji%20dengan%20dr.%20Bunga%20Sari" class="bg-white border border-rose-200 text-rose-600 px-6 py-3 rounded-xl font-semibold hover:bg-rose-50 transition-colors shadow-sm flex items-center">
                                    <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 24 24">
                                        <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.109"/>
                                    </svg>
                                    WhatsApp
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact Section -->
        <section id="kontak" class="py-20 bg-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="grid lg:grid-cols-2 gap-16 items-center">
                    <!-- Contact Info -->
                    <div>
                        <div class="inline-flex items-center bg-rose-100 text-rose-700 px-4 py-2 rounded-full text-sm font-medium mb-6">
                            <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/>
                            </svg>
                            Hubungi Kami
                        </div>
                        <h3 class="text-3xl md:text-4xl font-bold text-gray-900 mb-6">
                            Siap Melayani <span class="text-transparent bg-clip-text bg-gradient-to-r from-rose-500 to-pink-500">Kesehatan Anda</span>
                        </h3>
                        <p class="text-lg text-gray-600 mb-8">
                            Tim medis kami siap memberikan pelayanan terbaik untuk kesehatan Anda dan keluarga. Hubungi kami untuk konsultasi atau membuat janji.
                        </p>
                        
                        <div class="space-y-6">
                            <!-- Phone -->
                            <div class="flex items-start">
                                <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-12 h-12 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                    <svg class="w-6 h-6 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                                    </svg>
                                </div>
                                <div>
                                    <h4 class="text-lg font-semibold text-gray-900 mb-1">Telepon</h4>
                                    <p class="text-gray-600">+62 21 1234 5678</p>
                                    <p class="text-sm text-rose-600 font-medium">24/7 untuk Gawat Darurat</p>
                                </div>
                            </div>
                            
                            <!-- WhatsApp -->
                            <div class="flex items-start">
                                <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-12 h-12 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                    <svg class="w-6 h-6 text-rose-600" fill="currentColor" viewBox="0 0 24 24">
                                        <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.109"/>
                                    </svg>
                                </div>
                                <div>
                                    <h4 class="text-lg font-semibold text-gray-900 mb-1">WhatsApp</h4>
                                    <p class="text-gray-600">+62 812 3456 7890</p>
                                    <p class="text-sm text-rose-600 font-medium">Chat langsung dengan tim medis</p>
                                </div>
                            </div>
                            
                            <!-- Email -->
                            <div class="flex items-start">
                                <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-12 h-12 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                    <svg class="w-6 h-6 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                                    </svg>
                                </div>
                                <div>
                                    <h4 class="text-lg font-semibold text-gray-900 mb-1">Email</h4>
                                    <p class="text-gray-600">info@klinikbungas.com</p>
                                    <p class="text-sm text-rose-600 font-medium">Respon dalam 24 jam</p>
                                </div>
                            </div>
                            
                            <!-- Address -->
                            <div class="flex items-start">
                                <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-12 h-12 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                                    <svg class="w-6 h-6 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                                    </svg>
                                </div>
                                <div>
                                    <h4 class="text-lg font-semibold text-gray-900 mb-1">Alamat</h4>
                                    <p class="text-gray-600">Jl. Kesehatan No. 123<br>Jakarta Selatan 12345</p>
                                    <p class="text-sm text-rose-600 font-medium">Parkir luas tersedia</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Operating Hours -->
                        <div class="mt-8 p-6 bg-gradient-to-br from-rose-50 to-pink-50 rounded-2xl border border-rose-100">
                            <h4 class="text-lg font-semibold text-gray-900 mb-4 flex items-center">
                                <svg class="w-5 h-5 text-rose-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                Jam Operasional
                            </h4>
                            <div class="space-y-2 text-sm">
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Senin - Jumat</span>
                                    <span class="font-medium text-gray-900">08:00 - 20:00</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Sabtu</span>
                                    <span class="font-medium text-gray-900">08:00 - 16:00</span>
                                </div>
                                <div class="flex justify-between">
                                    <span class="text-gray-600">Minggu</span>
                                    <span class="font-medium text-gray-900">10:00 - 14:00</span>
                                </div>
                                <div class="flex justify-between border-t border-rose-200 pt-2 mt-3">
                                    <span class="text-rose-600 font-medium">Gawat Darurat</span>
                                    <span class="font-bold text-rose-600">24/7</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Contact Form & Map -->
                    <div>
                        <!-- Quick Contact Form -->
                        <div class="bg-gradient-to-br from-rose-50 to-pink-50 rounded-3xl p-8 border border-rose-100 mb-8">
                            <h4 class="text-2xl font-bold text-gray-900 mb-6">Buat Janji Konsultasi</h4>
                            <form class="space-y-4">
                                <div class="grid md:grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-2">Nama Lengkap</label>
                                        <input type="text" class="w-full px-4 py-3 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-200" placeholder="Masukkan nama lengkap">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-2">Nomor Telepon</label>
                                        <input type="tel" class="w-full px-4 py-3 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-200" placeholder="08xx xxxx xxxx">
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Jenis Layanan</label>
                                    <select class="w-full px-4 py-3 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-200">
                                        <option>Pilih jenis layanan</option>
                                        <option>Konsultasi Dokter Umum</option>
                                        <option>Pemeriksaan Laboratorium</option>
                                        <option>Vaksinasi</option>
                                        <option>Medical Check-up</option>
                                        <option>Konsultasi Spesialis</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Tanggal Preferensi</label>
                                    <input type="date" class="w-full px-4 py-3 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-200">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Catatan Tambahan</label>
                                    <textarea rows="3" class="w-full px-4 py-3 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-200" placeholder="Jelaskan keluhan atau kebutuhan khusus..."></textarea>
                                </div>
                                <button type="submit" class="w-full bg-gradient-to-r from-rose-500 to-pink-500 text-white py-4 rounded-xl text-lg font-semibold hover:from-rose-600 hover:to-pink-600 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                                    <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                    </svg>
                                    Kirim Permintaan Janji
                                </button>
                            </form>
                        </div>
                        
                        <!-- Map Placeholder -->
                        <div class="bg-gradient-to-br from-rose-100 to-pink-100 rounded-2xl p-8 text-center border border-rose-200">
                            <svg class="w-16 h-16 text-rose-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                            </svg>
                            <h4 class="text-lg font-semibold text-gray-900 mb-2">Lokasi Klinik</h4>
                            <p class="text-gray-600 mb-4">Jl. Kesehatan No. 123, Jakarta Selatan</p>
                            <button class="bg-white text-rose-600 px-6 py-3 rounded-xl font-semibold hover:bg-rose-50 transition-colors border border-rose-200">
                                <svg class="w-4 h-4 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
                                </svg>
                                Buka di Google Maps
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-gradient-to-br from-rose-50 to-pink-50 text-gray-800">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
                <div class="grid md:grid-cols-4 gap-8">
                    <!-- Logo & Description -->
                    <div class="md:col-span-2">
                        <div class="flex items-center mb-6">
                            <!-- Medical Logo SVG -->
                            <div class="bg-gradient-to-br from-rose-500 to-pink-500 w-12 h-12 rounded-xl flex items-center justify-center mr-4">
                                <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2.5" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                                </svg>
                            </div>
                            <div>
                                <h3 class="text-2xl font-bold text-gray-800">Klinik Bungas</h3>
                                <p class="text-rose-600 text-sm font-medium">Kesehatan Terpercaya</p>
                            </div>
                        </div>
                        <p class="text-gray-600 mb-6 max-w-md leading-relaxed">
                            Klinik Bungas berkomitmen memberikan pelayanan kesehatan terbaik dengan fasilitas modern dan tim medis berpengalaman untuk kesehatan keluarga Indonesia.
                        </p>
                        
                        <!-- Social Media -->
                        <div class="flex space-x-4">
                            <a href="#" class="bg-white border border-rose-200 hover:bg-rose-500 hover:border-rose-500 text-rose-500 hover:text-white w-10 h-10 rounded-lg flex items-center justify-center transition-all duration-300 shadow-sm">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"/>
                                </svg>
                            </a>
                            <a href="#" class="bg-white border border-rose-200 hover:bg-rose-500 hover:border-rose-500 text-rose-500 hover:text-white w-10 h-10 rounded-lg flex items-center justify-center transition-all duration-300 shadow-sm">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M22.46 6c-.77.35-1.6.58-2.46.69.88-.53 1.56-1.37 1.88-2.38-.83.5-1.75.85-2.72 1.05C18.37 4.5 17.26 4 16 4c-2.35 0-4.27 1.92-4.27 4.29 0 .34.04.67.11.98C8.28 9.09 5.11 7.38 3 4.79c-.37.63-.58 1.37-.58 2.15 0 1.49.75 2.81 1.91 3.56-.71 0-1.37-.2-1.95-.5v.03c0 2.08 1.48 3.82 3.44 4.21a4.22 4.22 0 0 1-1.93.07 4.28 4.28 0 0 0 4 2.98 8.521 8.521 0 0 1-5.33 1.84c-.34 0-.68-.02-1.02-.06C3.44 20.29 5.7 21 8.12 21 16 21 20.33 14.46 20.33 8.79c0-.19 0-.37-.01-.56.84-.6 1.56-1.36 2.14-2.23z"/>
                                </svg>
                            </a>
                            <a href="#" class="bg-white border border-rose-200 hover:bg-rose-500 hover:border-rose-500 text-rose-500 hover:text-white w-10 h-10 rounded-lg flex items-center justify-center transition-all duration-300 shadow-sm">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M12.017 0C5.396 0 .029 5.367.029 11.987c0 5.079 3.158 9.417 7.618 11.174-.105-.949-.199-2.403.041-3.439.219-.937 1.406-5.957 1.406-5.957s-.359-.72-.359-1.781c0-1.663.967-2.911 2.168-2.911 1.024 0 1.518.769 1.518 1.688 0 1.029-.653 2.567-.992 3.992-.285 1.193.6 2.165 1.775 2.165 2.128 0 3.768-2.245 3.768-5.487 0-2.861-2.063-4.869-5.008-4.869-3.41 0-5.409 2.562-5.409 5.199 0 1.033.394 2.143.889 2.741.099.12.112.225.085.345-.09.375-.293 1.199-.334 1.363-.053.225-.172.271-.402.165-1.495-.69-2.433-2.878-2.433-4.646 0-3.776 2.748-7.252 7.92-7.252 4.158 0 7.392 2.967 7.392 6.923 0 4.135-2.607 7.462-6.233 7.462-1.214 0-2.357-.629-2.75-1.378l-.748 2.853c-.271 1.043-1.002 2.35-1.492 3.146C9.57 23.812 10.763 24.009 12.017 24.009c6.624 0 11.99-5.367 11.99-11.988C24.007 5.367 18.641.001.012.001z"/>
                                </svg>
                            </a>
                            <a href="#" class="bg-white border border-rose-200 hover:bg-rose-500 hover:border-rose-500 text-rose-500 hover:text-white w-10 h-10 rounded-lg flex items-center justify-center transition-all duration-300 shadow-sm">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M12.007 0C5.373 0 0 5.373 0 12.007s5.373 12.007 12.007 12.007 12.007-5.373 12.007-12.007S18.641.001 12.007.001zM8.672 18.976H5.895V8.651h2.777v10.325zM7.283 7.418c-.89 0-1.61-.721-1.61-1.611s.72-1.611 1.61-1.611 1.61.721 1.61 1.611-.72 1.611-1.61 1.611zM19.955 18.976h-2.777v-5.025c0-1.037-.019-2.369-1.442-2.369-1.442 0-1.663 1.126-1.663 2.292v5.102H11.296V8.651h2.665v1.409h.037c.371-.703 1.278-1.442 2.632-1.442 2.814 0 3.334 1.852 3.334 4.26v6.098z"/>
                                </svg>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Quick Links -->
                    <div>
                        <h4 class="text-lg font-semibold mb-6 text-gray-800">Navigasi Cepat</h4>
                        <ul class="space-y-3">
                            <li><a href="#beranda" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                                Beranda
                            </a></li>
                            <li><a href="#layanan" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                                Layanan
                            </a></li>
                            <li><a href="#kontak" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                                Kontak
                            </a></li>
                            <li><a href="#" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                                Tentang Kami
                            </a></li>
                            <li><a href="#" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                                Karir
                            </a></li>
                        </ul>
                    </div>
                    
                    <!-- Services -->
                    <div>
                        <h4 class="text-lg font-semibold mb-6 text-gray-800">Layanan Utama</h4>
                        <ul class="space-y-3">
                            <li><a href="#" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                                Konsultasi Dokter
                            </a></li>
                            <li><a href="#" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                                Pemeriksaan Lab
                            </a></li>
                            <li><a href="#" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                                Vaksinasi
                            </a></li>
                            <li><a href="#" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                                Gawat Darurat
                            </a></li>
                            <li><a href="#" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                </svg>
                                Medical Check-up
                            </a></li>
                        </ul>
                    </div>
                </div>
                
                <!-- Emergency Contact Banner -->
                <div class="mt-12 p-6 bg-gradient-to-r from-rose-500 to-pink-500 rounded-2xl shadow-lg">
                    <div class="flex flex-col md:flex-row items-center justify-between">
                        <div class="flex items-center mb-4 md:mb-0">
                            <div class="bg-white bg-opacity-20 w-12 h-12 rounded-xl flex items-center justify-center mr-4">
                                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                                </svg>
                            </div>
                            <div>
                                <h4 class="text-xl font-bold text-white">Gawat Darurat 24/7</h4>
                                <p class="text-rose-100">Hubungi kami kapan saja untuk keadaan darurat</p>
                            </div>
                        </div>
                        <div class="flex flex-col sm:flex-row gap-3">
                            <a href="tel:+622112345678" class="bg-white text-rose-600 px-6 py-3 rounded-xl font-semibold hover:bg-rose-50 transition-colors flex items-center shadow-sm">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                                </svg>
                                (021) 123-4567
                            </a>
                            <a href="https://wa.me/6281234567890" class="bg-white bg-opacity-20 text-white px-6 py-3 rounded-xl font-semibold hover:bg-opacity-30 transition-all flex items-center">
                                <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 24 24">
                                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.109"/>
                                </svg>
                                WhatsApp
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Copyright -->
            <div class="border-t border-rose-200">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
                    <div class="flex flex-col md:flex-row justify-between items-center">
                        <p class="text-gray-500 text-sm mb-4 md:mb-0">
                            © 2024 Klinik Bungas. Semua hak cipta dilindungi undang-undang.
                        </p>
                        <div class="flex space-x-6 text-sm">
                            <a href="#" class="text-gray-500 hover:text-rose-600 transition-colors">Kebijakan Privasi</a>
                            <a href="#" class="text-gray-500 hover:text-rose-600 transition-colors">Syarat & Ketentuan</a>
                            <a href="#" class="text-gray-500 hover:text-rose-600 transition-colors">Sitemap</a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>
</template>