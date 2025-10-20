<template>
  <div class="max-w-2xl mx-auto p-6 bg-white rounded-2xl shadow-xl border border-gray-100">
    <!-- Header -->
    <div class="text-center mb-8">
      <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-blue-500 to-purple-600 rounded-full mb-4">
        <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path>
        </svg>
      </div>
      <h2 class="text-3xl font-bold text-gray-900 mb-2">Berikan Penilaian Dokter</h2>
      <p class="text-gray-600">Bagikan pengalaman Anda untuk membantu pasien lain</p>
    </div>

    <!-- Form -->
    <form @submit.prevent="submitReview" class="space-y-6">
      <!-- Patient Information -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div>
          <label for="nama_pasien" class="block text-sm font-semibold text-gray-700 mb-2">
            Nama Pasien
          </label>
          <input
            id="nama_pasien"
            v-model="form.nama_pasien"
            type="text"
            class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            placeholder="Masukkan nama Anda"
            required
          />
          <p v-if="errors.nama_pasien" class="mt-1 text-sm text-red-600">{{ errors.nama_pasien[0] }}</p>
        </div>

        <div>
          <label for="email_pasien" class="block text-sm font-semibold text-gray-700 mb-2">
            Email
          </label>
          <input
            id="email_pasien"
            v-model="form.email_pasien"
            type="email"
            class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
            placeholder="email@example.com"
          />
          <p v-if="errors.email_pasien" class="mt-1 text-sm text-red-600">{{ errors.email_pasien[0] }}</p>
        </div>
      </div>

      <!-- Patient ID -->
      <div>
        <label for="id_pasien" class="block text-sm font-semibold text-gray-700 mb-2">
          ID Pasien / No. RM
        </label>
        <input
          id="id_pasien"
          v-model="form.id_pasien"
          type="text"
          class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          placeholder="Masukkan ID Pasien atau No. Rekam Medis"
          required
        />
        <p v-if="errors.id_pasien" class="mt-1 text-sm text-red-600">{{ errors.id_pasien[0] }}</p>
      </div>

      <!-- Doctor Name -->
      <div>
        <label for="nama_dokter" class="block text-sm font-semibold text-gray-700 mb-2">
          Nama Dokter
        </label>
        <input
          id="nama_dokter"
          v-model="form.nama_dokter"
          type="text"
          class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200"
          placeholder="Masukkan nama dokter yang menangani"
          required
        />
        <p v-if="errors.nama_dokter" class="mt-1 text-sm text-red-600">{{ errors.nama_dokter[0] }}</p>
      </div>

      <!-- Rating -->
      <div>
        <label class="block text-sm font-semibold text-gray-700 mb-3">
          Rating Kepuasan (1-5)
        </label>
        <div class="flex items-center space-x-2">
          <button
            v-for="star in 5"
            :key="star"
            type="button"
            @click="setRating(star)"
            class="focus:outline-none transition-all duration-200 transform hover:scale-110"
          >
            <svg
              class="w-10 h-10 transition-colors duration-200"
              :class="star <= form.rating ? 'text-yellow-400' : 'text-gray-300'"
              fill="currentColor"
              viewBox="0 0 20 20"
            >
              <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
            </svg>
          </button>
          <span class="ml-4 text-lg font-semibold text-gray-700">
            {{ ratingText }}
          </span>
        </div>
        <p v-if="errors.rating" class="mt-1 text-sm text-red-600">{{ errors.rating[0] }}</p>
      </div>

      <!-- Review Text -->
      <div>
        <label for="ulasan" class="block text-sm font-semibold text-gray-700 mb-2">
          Ulasan / Komentar
        </label>
        <textarea
          id="ulasan"
          v-model="form.ulasan"
          rows="4"
          class="w-full px-4 py-3 border border-gray-300 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 resize-none"
          placeholder="Ceritakan pengalaman Anda dengan dokter ini..."
        ></textarea>
        <div class="flex justify-between items-center mt-2">
          <p v-if="errors.ulasan" class="text-sm text-red-600">{{ errors.ulasan[0] }}</p>
          <p class="text-sm text-gray-500">{{ form.ulasan?.length || 0 }}/1000 karakter</p>
        </div>
      </div>

      <!-- Submit Button -->
      <div class="pt-4">
        <button
          type="submit"
          :disabled="isSubmitting || !isFormValid"
          class="w-full bg-gradient-to-r from-blue-500 to-purple-600 hover:from-blue-600 hover:to-purple-700 disabled:from-gray-400 disabled:to-gray-500 text-white font-semibold py-4 px-6 rounded-xl transition-all duration-300 transform hover:scale-[1.02] disabled:scale-100 disabled:cursor-not-allowed shadow-lg hover:shadow-xl"
        >
          <span v-if="isSubmitting" class="flex items-center justify-center">
            <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            Mengirim Penilaian...
          </span>
          <span v-else>Kirim Penilaian</span>
        </button>
      </div>
    </form>

    <!-- Success Message -->
    <div
      v-if="showSuccess"
      class="mt-6 p-4 bg-green-50 border border-green-200 rounded-xl"
    >
      <div class="flex items-center">
        <svg class="w-6 h-6 text-green-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
        </svg>
        <div>
          <h3 class="text-sm font-semibold text-green-800">Penilaian Berhasil Dikirim!</h3>
          <p class="text-sm text-green-700 mt-1">Terima kasih atas penilaian Anda. Review akan ditampilkan setelah disetujui oleh admin.</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import axios from 'axios'

// Form data
const form = ref({
  id_pasien: '',
  nama_dokter: '',
  rating: 0,
  ulasan: '',
  email_pasien: '',
  nama_pasien: ''
})

// Form state
const isSubmitting = ref(false)
const showSuccess = ref(false)
const errors = ref({})

// Computed properties
const ratingText = computed(() => {
  const texts = {
    0: 'Pilih rating',
    1: 'Sangat Tidak Puas',
    2: 'Tidak Puas',
    3: 'Cukup',
    4: 'Puas',
    5: 'Sangat Puas'
  }
  return texts[form.value.rating] || 'Pilih rating'
})

const isFormValid = computed(() => {
  return form.value.id_pasien && 
         form.value.nama_dokter && 
         form.value.rating > 0 &&
         form.value.nama_pasien
})

// Methods
const setRating = (rating) => {
  form.value.rating = rating
}

const submitReview = async () => {
  if (!isFormValid.value) return

  isSubmitting.value = true
  errors.value = {}

  try {
    const response = await axios.post('/api/doctor-reviews', form.value)
    
    if (response.data.success) {
      showSuccess.value = true
      // Reset form
      form.value = {
        id_pasien: '',
        nama_dokter: '',
        rating: 0,
        ulasan: '',
        email_pasien: '',
        nama_pasien: ''
      }
      
      // Hide success message after 5 seconds
      setTimeout(() => {
        showSuccess.value = false
      }, 5000)
    }
  } catch (error) {
    if (error.response?.status === 422) {
      errors.value = error.response.data.errors
    } else {
      console.error('Error submitting review:', error)
      // You could show a general error message here
    }
  } finally {
    isSubmitting.value = false
  }
}

// Props for pre-filling form (optional)
const props = defineProps({
  patientId: String,
  doctorName: String,
  patientName: String,
  patientEmail: String
})

// Pre-fill form if props are provided
if (props.patientId) form.value.id_pasien = props.patientId
if (props.doctorName) form.value.nama_dokter = props.doctorName
if (props.patientName) form.value.nama_pasien = props.patientName
if (props.patientEmail) form.value.email_pasien = props.patientEmail
</script>

<style scoped>
/* Additional custom styles if needed */
.star-rating {
  transition: all 0.2s ease-in-out;
}
</style>