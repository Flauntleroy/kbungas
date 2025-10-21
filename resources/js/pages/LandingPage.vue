<script setup lang="ts">
import { Head } from '@inertiajs/vue3';
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';


interface ClinicSettings {
    hero: {
        title: string;
        subtitle: string;
        cta_text: string;
        cta_link: string;
    };
    services: Array<{
        title: string;
        description: string;
        status: string;
        icon: string;
    }>;
    doctors: Array<{
        name: string;
        specialization: string;
        experience: string;
        image: string;
        rating: number;
        total_reviews: number;
        whatsapp: string;
    }>;
    contact: {
        phone: {
            primary: string;
            secondary: string;
        };
        whatsapp: {
            number: string;
            text: string;
        };
        email: {
            address: string;
            hours: string;
        };
        address: {
            full: string;
            maps_link: string;
        };
        hours: {
            weekdays: {
                senin_jumat: string;
                sabtu: string;
                minggu: string;
            };
            emergency: string;
        };
    };
    general: {
        clinic_name: string;
        tagline: string;
        copyright: string;
        emergency_number: string;
    };
}

interface Props {
    clinicSettings: ClinicSettings;
}

const props = defineProps<Props>();


const doctorReviews = ref([]);
const doctorStats = ref({
    averageRating: 0,
    totalReviews: 0
});
const loading = ref(true);


const hero = computed(() => props.clinicSettings.hero);
const services = computed(() => props.clinicSettings.services);
const doctors = computed(() => props.clinicSettings.doctors);
const contact = computed(() => props.clinicSettings.contact);
const general = computed(() => props.clinicSettings.general);


const primaryDoctor = computed(() => doctors.value[0] || null);


const fetchDoctorReviews = async () => {
    if (!primaryDoctor.value) {
        loading.value = false;
        return;
    }

    try {
        const response = await axios.get('/api/doctor-reviews/by-doctor', {
            params: { doctor: primaryDoctor.value.name }
        });
        
        if (response.data.success) {
            doctorReviews.value = response.data.data.reviews.data.slice(0, 3); 
            doctorStats.value = {
                averageRating: response.data.data.average_rating,
                totalReviews: response.data.data.total_reviews
            };
        }
    } catch (error) {
        console.error('Error fetching doctor reviews:', error);
        
        doctorStats.value = {
            averageRating: primaryDoctor.value.rating || 0,
            totalReviews: primaryDoctor.value.total_reviews || 0
        };
    } finally {
        loading.value = false;
    }
};


const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('id-ID', { 
        year: 'numeric', 
        month: 'long', 
        day: 'numeric' 
    });
};


const dynamicGridClasses = computed(() => {
    const count = doctors.value.length;
    
    if (count === 1) {
        return 'flex justify-center';
    } else if (count === 2) {
        return 'grid grid-cols-1 md:grid-cols-2 gap-6 max-w-4xl mx-auto';
    } else if (count === 3) {
        return 'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6';
    } else if (count === 4) {
        return 'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6';
    } else {
        
        return 'grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6';
    }
});


const cardClasses = computed(() => {
    const count = doctors.value.length;
    
    if (count === 1) {
        return 'bg-gradient-to-br from-rose-50 to-pink-50 rounded-3xl p-8 border border-rose-100 shadow-lg max-w-md w-full';
    } else {
        return 'bg-gradient-to-br from-rose-50 to-pink-50 rounded-3xl p-6 border border-rose-100 shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1';
    }
});


const getServiceIcon = (iconType: string) => {
    const icons = {
        pharmacy: `M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 7.586V5L8 4z`,
        doctor: `M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z`,
        specialist: `M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z`,
        midwife: `M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z`,
        surgery: `M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z`
    };
    return icons[iconType] || icons.doctor;
};

onMounted(() => {
    fetchDoctorReviews();
});
</script>

<template>
    <Head :title="`${general.clinic_name} - ${general.tagline}`" />
    
    <div class="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-white">
        <!-- Header -->
        <header class="bg-white/95 backdrop-blur-sm shadow-sm sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center py-4">
                    <div class="flex items-center space-x-3">
                        <!-- RBungas Logo -->
                        <div class="flex-shrink-0">
                            <img 
                                src="/images/RBungas.png" 
                                alt="Klinik Bungas Logo" 
                                class="h-15 w-15 object-contain"
                            />
                        </div>
                        <div>
                            <h2 class="text-lg font-bold text-rose-800">R'Bungas</h2>
                            <p class="text-xs text-rose-600">Layanan Kesehatan Terpercaya</p>
                        </div>
                    </div>
                    <nav class="hidden md:flex space-x-8">
                        <a href="#layanan" class="text-gray-700 hover:text-rose-600 transition-colors font-medium">Layanan</a>
                        <a href="#dokter" class="text-gray-700 hover:text-rose-600 transition-colors font-medium">Dokter</a>
                        <a href="#tentang" class="text-gray-700 hover:text-rose-600 transition-colors font-medium">Tentang</a>
                        <a href="#kontak" class="text-gray-700 hover:text-rose-600 transition-colors font-medium">Kontak</a>
                    </nav>
                    <div class="flex items-center space-x-4">
                        <a :href="hero.cta_link" class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-2.5 rounded-full hover:from-rose-600 hover:to-pink-600 transition-all duration-300 font-semibold shadow-lg hover:shadow-xl">
                            {{ hero.cta_text }}
                        </a>
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
                            Pilihan Utama Keluarga
                        </div>
                        <h2 class="text-4xl md:text-6xl font-bold text-gray-900 mb-6 leading-tight">
                            {{ hero.title }}
                        </h2>
                        <p class="text-xl text-gray-600 mb-8 max-w-2xl">
                            {{ hero.subtitle }}
                        </p>
                        <div class="flex flex-col sm:flex-row gap-4 justify-center lg:justify-start">
                            <a :href="hero.cta_link" class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-8 py-4 rounded-full text-lg font-semibold hover:from-rose-600 hover:to-pink-600 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                                <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                </svg>
                                {{ hero.cta_text }}
                            </a>
                            <a :href="`https://wa.me/${contact.whatsapp.number}?text=${encodeURIComponent(contact.whatsapp.text)}`" class="border-2 border-rose-300 text-rose-600 px-8 py-4 rounded-full text-lg font-semibold hover:bg-rose-50 transition-all duration-300">
                                <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                Pelajari Lebih Lanjut
                            </a>
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
                        Kami menyediakan berbagai layanan kesehatan untuk memenuhi kebutuhan medis Anda dan keluarga.
                    </p>
                </div>
                
                <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
                    <!-- Dynamic Services -->
                    <div v-for="service in services.items" :key="service.name" class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border border-rose-100 text-center">
                        <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-16 h-16 rounded-2xl flex items-center justify-center mb-6 mx-auto">
                            <svg class="w-8 h-8 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path :d="getServiceIcon(service.icon)" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/>
                            </svg>
                        </div>
                        <h4 class="text-xl font-bold text-gray-900 mb-3">{{ service.name }}</h4>
                        <p class="text-gray-600 mb-4">{{ service.description }}</p>
                    </div>
                </div>
                
                <!-- Call to Action -->
                <!-- <div class="text-center mt-12">
                    <button class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-8 py-4 rounded-full text-lg font-semibold hover:from-rose-600 hover:to-pink-600 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                        <svg class="w-5 h-5 inline mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                        </svg>
                        Konsultasi Gratis Sekarang
                    </button>
                </div> -->
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
                    <h3 class="text-3xl md:text-4xl font-bold text-gray-900 mb-4">Dokter</h3>
                    <p class="text-gray-600 max-w-2xl mx-auto">Kami menghadirkan dokter dan tenaga kesehatan profesional dengan pendekatan ramah dan berorientasi pada pasien.</p>
                </div>
                
                <div class="max-w-6xl mx-auto">
                    <!-- Multiple Doctors Grid -->
                    <div :class="dynamicGridClasses" v-if="doctors.length > 1">
                        <div v-for="doctor in doctors" :key="doctor.name" 
                             :class="cardClasses">
                            <!-- Doctor Profile -->
                            <div class="text-center mb-6">
                                <div class="relative inline-block mb-4">
                                    <div class="absolute -top-2 -right-2 bg-white rounded-full p-1.5 shadow-md">
                                        <svg class="w-3 h-3 text-rose-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v8m-4-4h8"/>
                                        </svg>
                                    </div>
                                    <img :src="doctor.photo || '/images/doctors/default-doctor.svg'" :alt="`Foto ${doctor.name}`" class="w-24 h-24 rounded-2xl bg-white p-2 border border-rose-200 shadow-md mx-auto">
                                </div>
                                <h4 class="text-xl font-bold text-gray-900 mb-1">{{ doctor.name }}</h4>
                                <p class="text-rose-600 font-medium mb-3">{{ doctor.specialization }}</p>
                                <p class="text-gray-600 text-sm mb-4 line-clamp-3">{{ doctor.description }}</p>
                                
                                <div class="flex flex-col gap-2">
                                    <a :href="hero.cta_link" class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-4 py-2 rounded-xl font-semibold hover:from-rose-600 hover:to-pink-600 transition-all duration-300 shadow-lg hover:shadow-xl text-sm">
                                        {{ hero.cta_text }}
                                    </a>
                                    <a v-if="doctor.whatsapp" :href="`https://wa.me/${doctor.whatsapp}?text=${encodeURIComponent('Halo ' + doctor.name + ', saya ingin konsultasi')}`" class="bg-white border border-rose-200 text-rose-600 px-4 py-2 rounded-xl font-semibold hover:bg-rose-50 transition-colors shadow-sm flex items-center justify-center text-sm">
                                        <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 24 24">
                                            <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.109"/>
                                        </svg>
                                        WhatsApp
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Single Doctor Layout (fallback for single doctor) -->
                    <div v-else class="bg-gradient-to-br from-rose-50 to-pink-50 rounded-3xl p-8 border border-rose-100 shadow-lg">
                        <!-- Doctor Profile -->
                        <div class="flex flex-col md:flex-row items-center gap-8 mb-8">
                            <div class="relative">
                                <div class="absolute -top-3 -right-3 bg-white rounded-full p-2 shadow-md">
                                    <svg class="w-4 h-4 text-rose-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v8m-4-4h8"/>
                                    </svg>
                                </div>
                                <img :src="primaryDoctor?.photo || '/images/doctors/default-doctor.svg'" :alt="`Foto ${primaryDoctor?.name}`" class="w-32 h-32 rounded-2xl bg-white p-2 border border-rose-200 shadow-md">
                            </div>
                            <div class="flex-1">
                                <h4 class="text-2xl font-bold text-gray-900 mb-1">{{ primaryDoctor?.name }}</h4>
                                <p class="text-rose-600 font-medium mb-2">{{ primaryDoctor?.specialization }}</p>
                                
                                <!-- Rating Section -->
                                <div v-if="!loading && doctorStats.totalReviews > 0" class="flex items-center gap-4 mb-4">
                                    <div class="flex items-center">
                                        <div class="flex items-center mr-2">
                                            <svg v-for="star in 5" :key="star" 
                                                 :class="star <= Math.round(doctorStats.averageRating) ? 'text-yellow-400' : 'text-gray-300'"
                                                 class="w-5 h-5 fill-current" viewBox="0 0 20 20">
                                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                                            </svg>
                                        </div>
                                        <span class="text-lg font-semibold text-gray-900">{{ doctorStats.averageRating.toFixed(1) }}</span>
                                    </div>
                                    <span class="text-gray-600">({{ doctorStats.totalReviews }} review{{ doctorStats.totalReviews > 1 ? 's' : '' }})</span>
                                </div>
                                
                                <p class="text-gray-600 mb-6">{{ primaryDoctor?.description }}</p>
                                <div class="flex flex-wrap gap-3">
                                    <a :href="hero.cta_link" class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-3 rounded-xl font-semibold hover:from-rose-600 hover:to-pink-600 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                                        {{ hero.cta_text }}
                                    </a>
                                    <a :href="`https://wa.me/${contact.whatsapp.number}?text=${encodeURIComponent(contact.whatsapp.text)}`" class="bg-white border border-rose-200 text-rose-600 px-6 py-3 rounded-xl font-semibold hover:bg-rose-50 transition-colors shadow-sm flex items-center">
                                        <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 24 24">
                                            <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.109"/>
                                        </svg>
                                        WhatsApp
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Recent Reviews Section -->
                        <div v-if="!loading && doctorReviews.length > 0" class="border-t border-rose-200 pt-6">
                            <h5 class="text-lg font-semibold text-gray-900 mb-4 flex items-center">
                                <svg class="w-5 h-5 text-rose-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"/>
                                </svg>
                                Review Terbaru
                            </h5>
                            <div class="grid gap-4">
                                <div v-for="review in doctorReviews" :key="review.id" 
                                     class="bg-white rounded-xl p-4 border border-rose-100 shadow-sm">
                                    <div class="flex items-start justify-between mb-2">
                                        <div class="flex items-center">
                                            <div class="flex items-center mr-3">
                                                <svg v-for="star in 5" :key="star" 
                                                     :class="star <= review.rating ? 'text-yellow-400' : 'text-gray-300'"
                                                     class="w-4 h-4 fill-current" viewBox="0 0 20 20">
                                                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                                                </svg>
                                            </div>
                                            <span class="font-medium text-gray-900">{{ review.patient_name }}</span>
                                        </div>
                                        <span class="text-sm text-gray-500">{{ formatDate(review.created_at) }}</span>
                                    </div>
                                    <p class="text-gray-700 text-sm leading-relaxed">{{ review.comment }}</p>
                                </div>
                            </div>
                            <div class="text-center mt-4">
                                <a href="#review-dokter" class="text-rose-600 hover:text-rose-700 font-medium text-sm inline-flex items-center">
                                    Lihat semua review
                                    <svg class="w-4 h-4 ml-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                                    </svg>
                                </a>
                            </div>
                        </div>

                        <!-- Loading State -->
                        <div v-if="loading" class="border-t border-rose-200 pt-6">
                            <div class="animate-pulse">
                                <div class="h-4 bg-rose-200 rounded w-1/4 mb-4"></div>
                                <div class="space-y-3">
                                    <div class="h-16 bg-rose-100 rounded-xl"></div>
                                    <div class="h-16 bg-rose-100 rounded-xl"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>



        <!-- Contact Section -->
        <section id="kontak" class="py-20 bg-white">
            <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
                <div class="inline-flex items-center bg-rose-100 text-rose-700 px-4 py-2 rounded-full text-sm font-medium mb-6">
                    <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"/>
                    </svg>
                    Hubungi Kami
                </div>
                <h3 class="text-3xl md:text-4xl font-bold text-gray-900 mb-6">
                    Siap Melayani <span class="text-transparent bg-clip-text bg-gradient-to-r from-rose-500 to-pink-500">Kesehatan Anda</span>
                </h3>
                <p class="text-lg text-gray-600 mb-12 max-w-2xl mx-auto">
                    Tim medis kami siap memberikan pelayanan terbaik untuk kesehatan Anda dan keluarga. Hubungi kami untuk konsultasi atau informasi lebih lanjut.
                </p>
                
                <div class="grid md:grid-cols-3 gap-8 mb-12">
                    <!-- Phone -->
                    <div class="bg-gradient-to-br from-rose-50 to-pink-50 rounded-2xl p-8 border border-rose-100">
                        <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-16 h-16 rounded-xl flex items-center justify-center mx-auto mb-4">
                            <svg class="w-8 h-8 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                            </svg>
                        </div>
                        <h4 class="text-xl font-semibold text-gray-900 mb-2">Telepon</h4>
                        <p class="text-gray-600 text-lg font-medium mb-2">0821-4943-9909</p>
                        <p class="text-sm text-rose-600 font-medium">24/7 untuk Gawat Darurat</p>
                    </div>
                    
                    <!-- WhatsApp -->
                    <div class="bg-gradient-to-br from-rose-50 to-pink-50 rounded-2xl p-8 border border-rose-100">
                        <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-16 h-16 rounded-xl flex items-center justify-center mx-auto mb-4">
                            <svg class="w-8 h-8 text-rose-600" fill="currentColor" viewBox="0 0 24 24">
                                <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.109"/>
                            </svg>
                        </div>
                        <h4 class="text-xl font-semibold text-gray-900 mb-2">Admin Reservasi</h4>
                        <p class="text-gray-600 text-lg font-medium mb-2">085973073770</p>
                        <p class="text-sm text-rose-600 font-medium">Chat untuk reservasi dan informasi</p>
                    </div>
                    
                    <!-- Email -->
                    <div class="bg-gradient-to-br from-rose-50 to-pink-50 rounded-2xl p-8 border border-rose-100">
                        <div class="bg-gradient-to-br from-rose-100 to-pink-100 w-16 h-16 rounded-xl flex items-center justify-center mx-auto mb-4">
                            <svg class="w-8 h-8 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                            </svg>
                        </div>
                        <h4 class="text-xl font-semibold text-gray-900 mb-2">Email</h4>
                        <p class="text-gray-600 text-lg font-medium mb-2">info@klinikbungas.com</p>
                        <p class="text-sm text-rose-600 font-medium">Respon dalam 24 jam</p>
                    </div>
                </div>
                
                <!-- Operating Hours -->
                <div class="max-w-2xl mx-auto p-8 bg-gradient-to-br from-rose-50 to-pink-50 rounded-2xl border border-rose-100">
                    <h4 class="text-2xl font-semibold text-gray-900 mb-6 flex items-center justify-center">
                        <svg class="w-6 h-6 text-rose-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                        </svg>
                        Jam Operasional
                    </h4>
                    <div class="grid md:grid-cols-2 gap-6">
                        <div class="space-y-3">
                            <div class="flex justify-between items-center">
                                <span class="text-gray-600 font-medium">Senin - Jumat</span>
                                <span class="font-semibold text-gray-900">08:00 - 21:00</span>
                            </div>
                            <div class="flex justify-between items-center">
                                <span class="text-gray-600 font-medium">Sabtu</span>
                                <span class="font-semibold text-gray-900">08:00 - 21:00</span>
                            </div>
                            <div class="flex justify-between items-center">
                                <span class="text-gray-600 font-medium">Minggu</span>
                                <span class="font-semibold text-gray-900">08:00 - 21:00</span>
                            </div>
                        </div>
                        <div class="bg-white rounded-xl p-4 border border-rose-200">
                            <div class="flex justify-between items-center">
                                <span class="text-rose-600 font-semibold">Gawat Darurat</span>
                                <span class="font-bold text-rose-600 text-lg">24/7</span>
                            </div>
                            <p class="text-sm text-gray-600 mt-2">Layanan darurat tersedia sepanjang waktu</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="bg-gradient-to-br from-rose-50 to-pink-50 text-gray-800">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
                <div class="grid lg:grid-cols-5 md:grid-cols-3 gap-8">
                    <!-- Logo & Description -->
                    <div class="lg:col-span-3 md:col-span-3">
                        <div class="flex items-center mb-6">
                            <!-- RBungas Logo -->
                            <div class="flex items-center justify-center mr-4 p-1">
                                <img 
                                    src="/images/RBungas.png" 
                                    class="w-15 h-15 object-contain"
                                />
                            </div>
                            <div>
                                <h3 class="text-2xl font-bold text-gray-800">R'Bungas</h3>
                                <!-- <p class="text-rose-600 text-sm font-medium">{{ general.tagline }}</p> -->
                            </div>
                        </div>
                        <p class="text-gray-600 mb-6 max-w-md leading-relaxed">
                            {{ general.description }}
                        </p>
                        
                        <!-- Contact Info -->
                        <div class="space-y-3 mb-6">
                            <div class="flex items-center text-gray-600">
                                <svg class="w-5 h-5 mr-3 text-rose-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                                </svg>
                                <span class="text-sm">{{ contact.address }}</span>
                            </div>
                            <div class="flex items-center text-gray-600">
                                <svg class="w-5 h-5 mr-3 text-rose-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                                </svg>
                                <span class="text-sm">{{ contact.phone }}</span>
                            </div>
                        </div>
                        
                        <!-- Social Media -->
                        <div class="flex space-x-4">
                            <a href="https://www.instagram.com/apotek.rbungas.farma/" class="bg-white border border-rose-200 hover:bg-rose-500 hover:border-rose-500 text-rose-500 hover:text-white w-10 h-10 rounded-lg flex items-center justify-center transition-all duration-300 shadow-sm">
                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
                                        <path d="M7.75 2h8.5A5.75 5.75 0 0 1 22 7.75v8.5A5.75 5.75 0 0 1 16.25 22h-8.5A5.75 5.75 0 0 1 2 16.25v-8.5A5.75 5.75 0 0 1 7.75 2zm0 1.5A4.25 4.25 0 0 0 3.5 7.75v8.5A4.25 4.25 0 0 0 7.75 20.5h8.5a4.25 4.25 0 0 0 4.25-4.25v-8.5A4.25 4.25 0 0 0 16.25 3.5h-8.5zM12 7a5 5 0 1 1 0 10 5 5 0 0 1 0-10zm0 1.5a3.5 3.5 0 1 0 0 7 3.5 3.5 0 0 0 0-7zm5.25-.75a.75.75 0 1 1 0 1.5.75.75 0 0 1 0-1.5z"/>
                                </svg>
                            </a>
                            <!-- <a href="#" class="bg-white border border-rose-200 hover:bg-rose-500 hover:border-rose-500 text-rose-500 hover:text-white w-10 h-10 rounded-lg flex items-center justify-center transition-all duration-300 shadow-sm">
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
                            </a> -->
                        </div>
                    </div>
                    
                    <!-- Quick Links -->
                    <!-- <div>
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
                    </div> -->
                    
                    <!-- Services -->   
                    <div>
                        <h4 class="text-lg font-semibold mb-6 text-gray-800">Layanan Utama</h4>
                        <ul class="space-y-3">
                            <li v-for="service in services.items.slice(0, 4)" :key="service.name">
                                <a href="#" class="text-gray-600 hover:text-rose-600 transition-colors duration-300 flex items-center group">
                                    <svg class="w-4 h-4 mr-2 text-rose-400 group-hover:text-rose-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
                                    </svg>
                                    {{ service.name }}
                                </a>
                            </li>
                        </ul>
                    </div>
                    
                    <!-- Location & Maps -->
                    <div>
                        <h4 class="text-lg font-semibold mb-6 text-gray-800">Lokasi Kami</h4>
                        <div class="space-y-4">
                            <p class="text-gray-600 text-sm leading-relaxed">
                                {{ general.clinic_name }}<br>
                                {{ contact.address }}
                            </p>
                            
                            <!-- Google Maps Link -->
                            <a :href="contact.maps_link" 
                               target="_blank" 
                               class="inline-flex items-center bg-rose-500 hover:bg-rose-600 text-white px-4 py-2 rounded-lg text-sm font-medium transition-colors duration-300 shadow-sm">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                                </svg>
                                Lihat di Google Maps
                            </a>
                            
                            <!-- Embedded Map -->
                            <!-- <div class="mt-4 rounded-lg overflow-hidden shadow-sm border border-rose-200">
                                <iframe 
                                    :src="contact.maps_embed"
                                    width="100%" 
                                    height="200" 
                                    style="border:0;" 
                                    allowfullscreen="" 
                                    loading="lazy" 
                                    referrerpolicy="no-referrer-when-downgrade"
                                    class="w-full">
                                </iframe>
                            </div> -->
                        </div>
                    </div>
                </div>
                
                <!-- Emergency Contact Banner -->
                <div class="mt-12 p-6 bg-gradient-to-r from-rose-500 to-pink-500 rounded-2xl shadow-lg">
                    <div class="flex flex-col md:flex-row items-center justify-between">
                        <div class="flex items-center mb-4 md:mb-0">
                           <div class="bg-white bg-opacity-20 w-12 h-12 rounded-xl flex items-center justify-center mr-4">
                                <svg class="w-6 h-6 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <circle cx="12" cy="12" r="9" stroke-width="2" />
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v8m-4-4h8" />
                                </svg>
                            </div>

                            <div>
                                <h4 class="text-xl font-bold text-white">Persalinan 24/7</h4>
                                <p class="text-rose-100">Hubungi kami kapan saja untuk keadaan darurat</p>
                            </div>
                        </div>
                        <div class="flex flex-col sm:flex-row gap-3">
                            <a :href="`tel:${contact.phone}`" class="bg-white text-rose-600 px-6 py-3 rounded-xl font-semibold hover:bg-rose-50 transition-colors flex items-center shadow-sm">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                                </svg>
                                {{ contact.phone }}
                            </a>
                            <a :href="`https://wa.me/${contact.whatsapp.number}`" class="bg-white bg-opacity-20 text-black px-6 py-3 rounded-xl font-semibold hover:bg-opacity-30 transition-all flex items-center">
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
                            © 2024 {{ general.clinic_name }}. Semua hak cipta dilindungi undang-undang.
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