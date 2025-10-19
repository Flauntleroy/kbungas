<template>
  <div v-if="isVisible" class="fixed inset-0 z-50 overflow-y-auto">
    <div class="flex items-center justify-center min-h-screen px-4">
      <!-- Backdrop -->
      <div class="fixed inset-0 bg-black bg-opacity-50 backdrop-blur-sm transition-opacity"></div>
      
      <!-- Modal -->
      <div class="relative bg-white rounded-3xl shadow-2xl max-w-md w-full mx-auto transform transition-all animate-bounce-in">
        <!-- Decorative Header -->
        <div class="relative bg-gradient-to-br from-pink-50 via-rose-50 to-pink-100 rounded-t-3xl p-6 text-center">
          <!-- Decorative Elements -->
          <div class="absolute top-0 left-0 w-full h-full overflow-hidden rounded-t-3xl">
            <div class="absolute -top-4 -left-4 w-16 h-16 bg-pink-200 rounded-full opacity-30"></div>
            <div class="absolute -top-2 -right-6 w-12 h-12 bg-rose-200 rounded-full opacity-40"></div>
            <div class="absolute top-8 right-4 w-8 h-8 bg-pink-300 rounded-full opacity-20"></div>
          </div>
          
          <!-- Success Icon -->
          <div class="relative z-10 mb-4">
            <div class="mx-auto w-20 h-20 bg-gradient-to-br from-pink-400 to-rose-500 rounded-full flex items-center justify-center shadow-lg">
              <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="3" d="M5 13l4 4L19 7"></path>
              </svg>
            </div>
          </div>
          
          <!-- Title -->
          <h2 class="text-2xl font-bold text-gray-800 mb-2">Registrasi Berhasil!</h2>
          <div class="w-16 h-1 bg-gradient-to-r from-pink-400 to-rose-500 rounded-full mx-auto"></div>
        </div>
        
        <!-- Content -->
        <div class="p-6 space-y-4">
          <!-- Patient Details -->
          <div class="space-y-3">
            <!-- No. RM -->
            <div class="flex items-center p-3 bg-pink-50 rounded-xl border border-pink-100">
              <div class="flex-shrink-0 w-10 h-10 bg-gradient-to-br from-pink-400 to-rose-500 rounded-lg flex items-center justify-center">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                </svg>
              </div>
              <div class="ml-3 flex-1">
                <p class="text-sm font-medium text-gray-600">No. Rekam Medis</p>
                <p class="text-lg font-bold text-gray-800">{{ patientData?.no_rkm_medis || 'N/A' }}</p>
              </div>
            </div>
            
            <!-- Nama Lengkap -->
            <div class="flex items-center p-3 bg-rose-50 rounded-xl border border-rose-100">
              <div class="flex-shrink-0 w-10 h-10 bg-gradient-to-br from-rose-400 to-pink-500 rounded-lg flex items-center justify-center">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                </svg>
              </div>
              <div class="ml-3 flex-1">
                <p class="text-sm font-medium text-gray-600">Nama Lengkap</p>
                <p class="text-lg font-bold text-gray-800">{{ patientData?.nama || 'N/A' }}</p>
              </div>
            </div>
            
            <!-- Nomor Telepon -->
            <div class="flex items-center p-3 bg-pink-50 rounded-xl border border-pink-100">
              <div class="flex-shrink-0 w-10 h-10 bg-gradient-to-br from-pink-400 to-rose-500 rounded-lg flex items-center justify-center">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"></path>
                </svg>
              </div>
              <div class="ml-3 flex-1">
                <p class="text-sm font-medium text-gray-600">Nomor Telepon</p>
                <p class="text-lg font-bold text-gray-800">{{ patientData?.no_telp || 'N/A' }}</p>
              </div>
            </div>
            
            <!-- Alamat -->
            <div class="flex items-start p-3 bg-rose-50 rounded-xl border border-rose-100">
              <div class="flex-shrink-0 w-10 h-10 bg-gradient-to-br from-rose-400 to-pink-500 rounded-lg flex items-center justify-center mt-1">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"></path>
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"></path>
                </svg>
              </div>
              <div class="ml-3 flex-1">
                <p class="text-sm font-medium text-gray-600">Alamat</p>
                <p class="text-base font-semibold text-gray-800 leading-relaxed">{{ patientData?.alamat || 'N/A' }}</p>
              </div>
            </div>
          </div>
          
          <!-- Success Message -->
          <div class="text-center py-4">
            <p class="text-gray-600 text-sm leading-relaxed">
              Pasien telah berhasil didaftarkan ke sistem SIMRS. 
              <br>Data dapat digunakan untuk keperluan medis selanjutnya.
            </p>
          </div>
        </div>
        
        <!-- Footer -->
        <div class="p-6 pt-0">
          <button 
            @click="handleOkClick"
            class="w-full bg-gradient-to-r from-pink-500 to-rose-500 hover:from-pink-600 hover:to-rose-600 text-white font-semibold py-4 px-6 rounded-2xl transition-all duration-300 transform hover:scale-105 hover:shadow-lg focus:outline-none focus:ring-4 focus:ring-pink-300 focus:ring-opacity-50"
          >
            <span class="flex items-center justify-center">
              <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
              </svg>
              OK
            </span>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

interface PatientData {
  no_rkm_medis: string
  nama: string
  no_telp: string
  alamat: string
}

interface Props {
  isVisible: boolean
  patientData: PatientData
}

const props = defineProps<Props>()

const emit = defineEmits<{
  close: []
  ok: []
}>()

const handleOkClick = () => {
  emit('ok')
  emit('close')
}
</script>

<style scoped>
@keyframes bounce-in {
  0% {
    transform: scale(0.3) translateY(-50px);
    opacity: 0;
  }
  50% {
    transform: scale(1.05) translateY(0);
    opacity: 0.8;
  }
  70% {
    transform: scale(0.95);
    opacity: 0.9;
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

.animate-bounce-in {
  animation: bounce-in 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}

/* Custom scrollbar for long addresses */
.overflow-y-auto::-webkit-scrollbar {
  width: 4px;
}

.overflow-y-auto::-webkit-scrollbar-track {
  background: #f1f5f9;
  border-radius: 2px;
}

.overflow-y-auto::-webkit-scrollbar-thumb {
  background: #ec4899;
  border-radius: 2px;
}

.overflow-y-auto::-webkit-scrollbar-thumb:hover {
  background: #be185d;
}
</style>