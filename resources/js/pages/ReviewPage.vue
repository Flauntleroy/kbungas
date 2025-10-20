<template>
  <div class="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-white relative overflow-hidden">
    <Head title="Berikan Review Dokter - Klinik Bungas" />
    
    <!-- Background Decorative Elements -->
    <div class="absolute inset-0 overflow-hidden pointer-events-none">
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
      <div class="absolute -top-40 -right-40 w-80 h-80 bg-gradient-to-br from-rose-200/20 to-pink-200/20 rounded-full blur-3xl"></div>
      <div class="absolute -bottom-40 -left-40 w-80 h-80 bg-gradient-to-tr from-rose-200/20 to-pink-200/20 rounded-full blur-3xl"></div>
      <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-gradient-to-r from-rose-100/10 to-pink-100/10 rounded-full blur-3xl"></div>
    </div>

    <!-- Navigation Header -->
    <nav class="relative z-10 bg-white/80 backdrop-blur-md border-b border-rose-100/50 sticky top-0">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center py-4">
          <div class="flex items-center space-x-3">
            <div class="w-16 h-16 flex items-center justify-center">
              <img src="/images/RBungas.png" alt="Klinik Bungas Logo" class="w-full h-full object-contain" />
            </div>
            <div>
              <h1 class="text-2xl font-bold text-gray-900">Klinik Bungas</h1>
              <p class="text-sm text-gray-600">Pelayanan Kesehatan Terpercaya</p>
            </div>
          </div>
          
          <!-- Navigation Links -->
          <div class="hidden md:flex items-center space-x-8">
            <a href="/" class="text-gray-700 hover:text-rose-600 font-medium transition-colors duration-200">
              Beranda
            </a>
            <a href="/#layanan" class="text-gray-700 hover:text-rose-600 font-medium transition-colors duration-200">
              Layanan
            </a>
            <a href="/#dokter" class="text-gray-700 hover:text-rose-600 font-medium transition-colors duration-200">
              Dokter
            </a>
            <a href="/#kontak" class="text-gray-700 hover:text-rose-600 font-medium transition-colors duration-200">
              Kontak
            </a>
          </div>

          <!-- Mobile Menu Button -->
          <div class="md:hidden">
            <button @click="mobileMenuOpen = !mobileMenuOpen" class="text-gray-700 hover:text-rose-600">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
              </svg>
            </button>
          </div>
        </div>

        <!-- Mobile Menu -->
        <div v-if="mobileMenuOpen" class="md:hidden py-4 border-t border-rose-100">
          <div class="flex flex-col space-y-4">
            <a href="/" class="text-gray-700 hover:text-rose-600 font-medium transition-colors duration-200">
              Beranda
            </a>
            <a href="/#layanan" class="text-gray-700 hover:text-rose-600 font-medium transition-colors duration-200">
              Layanan
            </a>
            <a href="/#dokter" class="text-gray-700 hover:text-rose-600 font-medium transition-colors duration-200">
              Dokter
            </a>
            <a href="/#kontak" class="text-gray-700 hover:text-rose-600 font-medium transition-colors duration-200">
              Kontak
            </a>
          </div>
        </div>
      </div>
    </nav>

    <!-- Main Content -->
    <main class="relative z-10 py-16">
      <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        <!-- Page Header -->
        <div class="text-center mb-12">
          <div class="inline-flex items-center bg-rose-100 text-rose-700 px-4 py-2 rounded-full text-sm font-medium mb-6">
            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"/>
            </svg>
            Review Dokter
          </div>
          <h1 class="text-4xl md:text-5xl font-bold text-gray-900 mb-4">
            Bagikan Pengalaman <span class="text-transparent bg-clip-text bg-gradient-to-r from-rose-500 to-pink-500">Anda</span>
          </h1>
          <p class="text-xl text-gray-600 max-w-3xl mx-auto">
            Penilaian Anda sangat berharga untuk membantu pasien lain dan meningkatkan kualitas pelayanan kami
          </p>
        </div>

        <!-- Review Form -->
        <div class="relative">
          <DoctorReviewForm 
            :patient-id="patientId"
            :doctor-name="doctorName"
            :patient-name="patientName"
            :patient-email="patientEmail"
          />
        </div>

        <!-- Additional Information -->
        <div class="mt-16 grid md:grid-cols-2 gap-8">
          <div class="bg-white/60 backdrop-blur-sm rounded-2xl p-8 border border-rose-100">
            <div class="flex items-center mb-4">
              <div class="w-12 h-12 bg-gradient-to-br from-rose-100 to-pink-100 rounded-xl flex items-center justify-center mr-4">
                <svg class="w-6 h-6 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                </svg>
              </div>
              <h3 class="text-xl font-bold text-gray-900">Privasi Terjamin</h3>
            </div>
            <p class="text-gray-600">
              Semua informasi yang Anda berikan akan dijaga kerahasiaannya dan hanya digunakan untuk meningkatkan kualitas pelayanan.
            </p>
          </div>

          <div class="bg-white/60 backdrop-blur-sm rounded-2xl p-8 border border-rose-100">
            <div class="flex items-center mb-4">
              <div class="w-12 h-12 bg-gradient-to-br from-rose-100 to-pink-100 rounded-xl flex items-center justify-center mr-4">
                <svg class="w-6 h-6 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
              </div>
              <h3 class="text-xl font-bold text-gray-900">Review Dimoderasi</h3>
            </div>
            <p class="text-gray-600">
              Review Anda akan ditinjau terlebih dahulu oleh tim kami sebelum ditampilkan untuk memastikan kualitas dan kesesuaian.
            </p>
          </div>
        </div>

        <!-- Back to Home -->
        <div class="mt-12 text-center">
          <a 
            href="/" 
            class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-rose-500 to-pink-500 hover:from-rose-600 hover:to-pink-600 text-white font-semibold rounded-xl transition-all duration-300 transform hover:scale-105"
          >
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
            </svg>
            Kembali ke Beranda
          </a>
        </div>
      </div>
    </main>

    <!-- Footer -->
    <footer class="relative z-10 bg-white/80 backdrop-blur-md border-t border-rose-100 mt-16">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="text-center">
          <div class="flex items-center justify-center space-x-3 mb-4">
            <div class="w-12 h-12 flex items-center justify-center">
              <img src="/images/RBungas.png" alt="Klinik Bungas Logo" class="w-full h-full object-contain" />
            </div>
            <div>
              <h3 class="text-lg font-bold text-gray-900">Klinik Bungas</h3>
            </div>
          </div>
          <p class="text-gray-600 mb-4">Pelayanan Kesehatan Terpercaya untuk Keluarga Anda</p>
          <p class="text-sm text-gray-500">© 2024 Klinik Bungas. Semua hak dilindungi.</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { Head } from '@inertiajs/vue3';
import { ref } from 'vue';
import DoctorReviewForm from '@/components/DoctorReviewForm.vue';

// Mobile menu state
const mobileMenuOpen = ref(false);

// Props for pre-filling form (optional, can be passed from URL params or other sources)
const props = defineProps({
  patientId: {
    type: String,
    default: ''
  },
  doctorName: {
    type: String,
    default: ''
  },
  patientName: {
    type: String,
    default: ''
  },
  patientEmail: {
    type: String,
    default: ''
  }
});
</script>

<style scoped>
/* Additional custom styles if needed */
</style>