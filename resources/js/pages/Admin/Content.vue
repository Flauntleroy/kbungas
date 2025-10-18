<template>
  <AdminLayout>
    <!-- Header -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-6">
      <div>
        <h1 class="text-2xl font-bold text-gray-900">Manajemen Konten</h1>
        <p class="text-gray-600 mt-1">Kelola konten landing page klinik</p>
      </div>
      <div class="mt-4 sm:mt-0">
        <button 
          @click="saveAllChanges"
          class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-2 rounded-xl hover:from-rose-600 hover:to-pink-600 transition-all shadow-lg flex items-center"
        >
          <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-3m-1 4l-3-3m0 0l-3 3m3-3v12"/>
          </svg>
          Simpan Semua Perubahan
        </button>
      </div>
    </div>

    <!-- Content Tabs -->
    <div class="bg-white rounded-2xl shadow-sm border border-rose-100 overflow-hidden">
      <div class="border-b border-rose-100">
        <nav class="flex space-x-8 px-6">
          <button 
            v-for="tab in tabs" 
            :key="tab.id"
            @click="activeTab = tab.id"
            :class="[
              'py-4 px-1 border-b-2 font-medium text-sm transition-colors',
              activeTab === tab.id 
                ? 'border-rose-500 text-rose-600' 
                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
            ]"
          >
            {{ tab.name }}
          </button>
        </nav>
      </div>

      <div class="p-6">
        <!-- Hero Section Tab -->
        <div v-if="activeTab === 'hero'" class="space-y-6">
          <h3 class="text-lg font-semibold text-gray-900">Hero Section</h3>
          
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div class="space-y-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Judul Utama</label>
                <input 
                  v-model="heroContent.title" 
                  type="text" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Subjudul</label>
                <textarea 
                  v-model="heroContent.subtitle" 
                  rows="3"
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                ></textarea>
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Teks Tombol CTA</label>
                <input 
                  v-model="heroContent.ctaText" 
                  type="text" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Link Tombol CTA</label>
                <input 
                  v-model="heroContent.ctaLink" 
                  type="url" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
            </div>
            
            <div class="bg-gray-50 rounded-xl p-4">
              <h4 class="font-medium text-gray-900 mb-3">Preview</h4>
              <div class="bg-gradient-to-r from-rose-500 to-pink-500 text-white p-6 rounded-xl">
                <h1 class="text-2xl font-bold mb-2">{{ heroContent.title }}</h1>
                <p class="mb-4 opacity-90">{{ heroContent.subtitle }}</p>
                <button class="bg-white text-rose-600 px-4 py-2 rounded-lg font-semibold">
                  {{ heroContent.ctaText }}
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Services Tab -->
        <div v-if="activeTab === 'services'" class="space-y-6">
          <div class="flex items-center justify-between">
            <h3 class="text-lg font-semibold text-gray-900">Layanan Klinik</h3>
            <button 
              @click="addService"
              class="bg-rose-500 text-white px-4 py-2 rounded-xl hover:bg-rose-600 transition-colors flex items-center"
            >
              <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
              </svg>
              Tambah Layanan
            </button>
          </div>
          
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <div 
              v-for="(service, index) in servicesContent" 
              :key="index"
              class="bg-gray-50 rounded-xl p-4 relative"
            >
              <button 
                @click="removeService(index)"
                class="absolute top-2 right-2 text-red-500 hover:text-red-700"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
              </button>
              
              <div class="space-y-3">
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1">Nama Layanan</label>
                  <input 
                    v-model="service.name" 
                    type="text" 
                    class="w-full px-3 py-2 border border-rose-200 rounded-lg focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                  >
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1">Deskripsi</label>
                  <textarea 
                    v-model="service.description" 
                    rows="3"
                    class="w-full px-3 py-2 border border-rose-200 rounded-lg focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                  ></textarea>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-1">Ikon (SVG)</label>
                  <textarea 
                    v-model="service.icon" 
                    rows="2"
                    placeholder="<svg>...</svg>"
                    class="w-full px-3 py-2 border border-rose-200 rounded-lg focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900 text-xs"
                  ></textarea>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Doctors Tab -->
        <div v-if="activeTab === 'doctors'" class="space-y-6">
          <div class="flex items-center justify-between">
            <h3 class="text-lg font-semibold text-gray-900">Tim Dokter</h3>
            <button 
              @click="addDoctor"
              class="bg-rose-500 text-white px-4 py-2 rounded-xl hover:bg-rose-600 transition-colors flex items-center"
            >
              <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
              </svg>
              Tambah Dokter
            </button>
          </div>
          
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div 
              v-for="(doctor, index) in doctorsContent" 
              :key="index"
              class="bg-gray-50 rounded-xl p-6 relative"
            >
              <button 
                @click="removeDoctor(index)"
                class="absolute top-4 right-4 text-red-500 hover:text-red-700"
              >
                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                </svg>
              </button>
              
              <div class="space-y-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-2">Nama Dokter</label>
                  <input 
                    v-model="doctor.name" 
                    type="text" 
                    class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                  >
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-2">Spesialisasi</label>
                  <input 
                    v-model="doctor.specialization" 
                    type="text" 
                    class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                  >
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-2">Deskripsi</label>
                  <textarea 
                    v-model="doctor.description" 
                    rows="3"
                    class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                  ></textarea>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-2">Path Foto</label>
                  <input 
                    v-model="doctor.photo" 
                    type="text" 
                    placeholder="/images/doctors/doctor-name.svg"
                    class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                  >
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-2">Nomor WhatsApp</label>
                  <input 
                    v-model="doctor.whatsapp" 
                    type="tel" 
                    placeholder="628123456789"
                    class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                  >
                </div>
                
                <div class="flex items-center">
                  <input 
                    v-model="doctor.available" 
                    type="checkbox" 
                    class="h-4 w-4 text-rose-600 focus:ring-rose-500 border-gray-300 rounded"
                  >
                  <label class="ml-2 block text-sm text-gray-900">Tersedia untuk booking</label>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Contact Info Tab -->
        <div v-if="activeTab === 'contact'" class="space-y-6">
          <h3 class="text-lg font-semibold text-gray-900">Informasi Kontak</h3>
          
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div class="space-y-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Alamat Klinik</label>
                <textarea 
                  v-model="contactContent.address" 
                  rows="3"
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                ></textarea>
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Nomor Telepon</label>
                <input 
                  v-model="contactContent.phone" 
                  type="tel" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">WhatsApp</label>
                <input 
                  v-model="contactContent.whatsapp" 
                  type="tel" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
                <input 
                  v-model="contactContent.email" 
                  type="email" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
            </div>
            
            <div class="space-y-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Jam Operasional</label>
                <div class="space-y-2">
                  <div v-for="(schedule, day) in contactContent.schedule" :key="day" class="flex items-center space-x-3">
                    <span class="w-20 text-sm text-gray-600 capitalize">{{ day }}</span>
                    <input 
                      v-model="schedule.open" 
                      type="time" 
                      class="px-2 py-1 border border-rose-200 rounded-lg focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                    >
                    <span class="text-gray-500">-</span>
                    <input 
                      v-model="schedule.close" 
                      type="time" 
                      class="px-2 py-1 border border-rose-200 rounded-lg focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                    >
                    <label class="flex items-center">
                      <input 
                        v-model="schedule.closed" 
                        type="checkbox" 
                        class="h-4 w-4 text-rose-600 focus:ring-rose-500 border-gray-300 rounded"
                      >
                      <span class="ml-1 text-sm text-gray-600">Tutup</span>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'

// State
const activeTab = ref('hero')

const tabs = [
  { id: 'hero', name: 'Hero Section' },
  { id: 'services', name: 'Layanan' },
  { id: 'doctors', name: 'Tim Dokter' },
  { id: 'contact', name: 'Kontak' }
]

// Content data
const heroContent = ref({
  title: 'Klinik Kulit & Kecantikan Terpercaya',
  subtitle: 'Dapatkan perawatan kulit terbaik dengan teknologi modern dan dokter berpengalaman. Konsultasi gratis untuk semua pasien baru.',
  ctaText: 'Booking Konsultasi',
  ctaLink: '/booking'
})

const servicesContent = ref([
  {
    name: 'Konsultasi Kulit',
    description: 'Konsultasi menyeluruh untuk berbagai masalah kulit dengan dokter spesialis',
    icon: '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>'
  },
  {
    name: 'Perawatan Jerawat',
    description: 'Treatment khusus untuk mengatasi jerawat dan bekasnya',
    icon: '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/></svg>'
  },
  {
    name: 'Perawatan Anti-Aging',
    description: 'Berbagai treatment untuk menjaga kecantikan dan kesehatan kulit',
    icon: '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z"/></svg>'
  }
])

const doctorsContent = ref([
  {
    name: 'dr. Bunga Sari, Sp.KK',
    specialization: 'Spesialis Kulit dan Kelamin',
    description: 'Dokter berpengalaman lebih dari 10 tahun dalam bidang dermatologi dan venereologi. Menangani berbagai kasus penyakit kulit dan kelamin dengan pendekatan yang komprehensif.',
    photo: '/images/doctors/dr-bungas.svg',
    whatsapp: '628123456789',
    available: true
  }
])

const contactContent = ref({
  address: 'Jl. Kesehatan No. 123, Jakarta Selatan 12345',
  phone: '021-12345678',
  whatsapp: '628123456789',
  email: 'info@klinikbungas.com',
  schedule: {
    senin: { open: '08:00', close: '17:00', closed: false },
    selasa: { open: '08:00', close: '17:00', closed: false },
    rabu: { open: '08:00', close: '17:00', closed: false },
    kamis: { open: '08:00', close: '17:00', closed: false },
    jumat: { open: '08:00', close: '17:00', closed: false },
    sabtu: { open: '08:00', close: '14:00', closed: false },
    minggu: { open: '', close: '', closed: true }
  }
})

// Methods
const addService = () => {
  servicesContent.value.push({
    name: '',
    description: '',
    icon: '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/></svg>'
  })
}

const removeService = (index: number) => {
  if (confirm('Apakah Anda yakin ingin menghapus layanan ini?')) {
    servicesContent.value.splice(index, 1)
  }
}

const addDoctor = () => {
  doctorsContent.value.push({
    name: '',
    specialization: '',
    description: '',
    photo: '',
    whatsapp: '',
    available: true
  })
}

const removeDoctor = (index: number) => {
  if (confirm('Apakah Anda yakin ingin menghapus dokter ini?')) {
    doctorsContent.value.splice(index, 1)
  }
}

const saveAllChanges = () => {
  // Here you would typically send the data to your backend
  alert('Semua perubahan telah disimpan!')
}
</script>