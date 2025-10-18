<template>
  <div class="min-h-screen bg-gradient-to-br from-blue-50 to-green-50 flex items-center justify-center p-4">
    <div class="max-w-md w-full">
      <!-- Loading State -->
      <div v-if="loading" class="bg-white rounded-2xl shadow-xl p-8 text-center">
        <div class="animate-spin rounded-full h-16 w-16 border-b-2 border-blue-600 mx-auto mb-4"></div>
        <h2 class="text-xl font-semibold text-gray-800 mb-2">Memproses Konfirmasi</h2>
        <p class="text-gray-600">Mohon tunggu sebentar...</p>
      </div>

      <!-- Success State -->
      <div v-else-if="status === 'success'" class="bg-white rounded-2xl shadow-xl p-8 text-center">
        <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
          </svg>
        </div>
        <h1 class="text-2xl font-bold text-green-600 mb-2">✅ Booking Dikonfirmasi!</h1>
        <p class="text-gray-600 mb-6">Booking berhasil dikonfirmasi. Pasien akan mendapat notifikasi otomatis.</p>
        
        <div class="bg-gray-50 rounded-lg p-4 mb-6 text-left">
          <h3 class="font-semibold text-gray-800 mb-2">Detail Booking:</h3>
          <div class="space-y-1 text-sm text-gray-600">
            <p><span class="font-medium">No. Booking:</span> {{ bookingData?.no_booking }}</p>
            <p><span class="font-medium">Nama Pasien:</span> {{ bookingData?.patient_name }}</p>
            <p><span class="font-medium">Tanggal:</span> {{ bookingData?.appointment_date }}</p>
            <p><span class="font-medium">Dikonfirmasi:</span> {{ bookingData?.confirmed_at }}</p>
          </div>
        </div>

        <div class="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
          <p class="text-blue-800 text-sm">
            <strong>📱 Notifikasi Terkirim:</strong> Pasien telah menerima notifikasi konfirmasi melalui WhatsApp.
          </p>
        </div>

        <button 
          @click="closeWindow" 
          class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-4 rounded-lg transition-colors"
        >
          Tutup Halaman
        </button>
      </div>

      <!-- Error State -->
      <div v-else-if="status === 'error'" class="bg-white rounded-2xl shadow-xl p-8 text-center">
        <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <svg class="w-8 h-8 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
          </svg>
        </div>
        <h1 class="text-2xl font-bold text-red-600 mb-2">❌ Konfirmasi Gagal</h1>
        <p class="text-gray-600 mb-4">{{ errorMessage }}</p>
        
        <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-6 text-left">
          <h3 class="font-semibold text-yellow-800 mb-2">Kemungkinan Penyebab:</h3>
          <ul class="text-sm text-yellow-700 space-y-1">
            <li>• Link konfirmasi sudah kedaluwarsa (lebih dari 24 jam)</li>
            <li>• Booking sudah dikonfirmasi sebelumnya</li>
            <li>• Token konfirmasi tidak valid</li>
            <li>• Anda tidak memiliki akses untuk booking ini</li>
          </ul>
        </div>

        <button 
          @click="closeWindow" 
          class="w-full bg-gray-600 hover:bg-gray-700 text-white font-medium py-3 px-4 rounded-lg transition-colors"
        >
          Tutup Halaman
        </button>
      </div>

      <!-- Already Confirmed State -->
      <div v-else-if="status === 'already_confirmed'" class="bg-white rounded-2xl shadow-xl p-8 text-center">
        <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <svg class="w-8 h-8 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
          </svg>
        </div>
        <h1 class="text-2xl font-bold text-yellow-600 mb-2">⚠️ Sudah Dikonfirmasi</h1>
        <p class="text-gray-600 mb-4">Booking ini sudah dikonfirmasi sebelumnya.</p>
        
        <div class="bg-gray-50 rounded-lg p-4 mb-6 text-left">
          <h3 class="font-semibold text-gray-800 mb-2">Status Saat Ini:</h3>
          <p class="text-sm text-gray-600">
            <span class="font-medium">Status:</span> {{ bookingData?.current_status || 'Sudah Dikonfirmasi' }}
          </p>
        </div>

        <button 
          @click="closeWindow" 
          class="w-full bg-gray-600 hover:bg-gray-700 text-white font-medium py-3 px-4 rounded-lg transition-colors"
        >
          Tutup Halaman
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import axios from 'axios'

interface Props {
  token: string
}

const props = defineProps<Props>()

const loading = ref(true)
const status = ref<'loading' | 'success' | 'error' | 'already_confirmed'>('loading')
const errorMessage = ref('')
const bookingData = ref<any>(null)

const confirmBooking = async () => {
  try {
    loading.value = true
    
    const response = await axios.post(`/api/booking/confirm/${props.token}`)
    
    if (response.data.success) {
      status.value = 'success'
      bookingData.value = response.data.data
    } else {
      status.value = 'error'
      errorMessage.value = response.data.message || 'Terjadi kesalahan saat mengonfirmasi booking'
    }
  } catch (error: any) {
    if (error.response?.status === 422 && error.response?.data?.message?.includes('sudah dikonfirmasi')) {
      status.value = 'already_confirmed'
      bookingData.value = error.response.data
    } else {
      status.value = 'error'
      errorMessage.value = error.response?.data?.message || 'Terjadi kesalahan saat mengonfirmasi booking'
    }
  } finally {
    loading.value = false
  }
}

const closeWindow = () => {
  // Coba tutup tab/window, jika tidak bisa redirect ke halaman utama
  if (window.history.length > 1) {
    window.history.back()
  } else {
    window.location.href = '/'
  }
}

onMounted(() => {
  confirmBooking()
})
</script>