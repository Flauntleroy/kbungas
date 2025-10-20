<template>
  <AdminLayout>
    <div class="w-full">
      <!-- Header -->
      <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4">
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
      </div>

  </AdminLayout>

</template>

<script setup lang="ts">
import { ref } from 'vue'
import AdminLayout from '@/Layouts/AdminLayout.vue'
import { router } from '@inertiajs/vue3'

// Props
interface Props {
  heroContent: {
    title: string
    subtitle: string
    ctaText: string
    ctaLink: string
  }
  servicesContent: Array<{
    name: string
    description: string
    icon: string
  }>
  doctorsContent: Array<{
    name: string
    specialization: string
    description: string
    photo: string
    whatsapp: string
    available: boolean
  }>
  contactContent: {
    address: string
    phone: string
    whatsapp: string
    email: string
    hours: {
      [key: string]: {
        open: string
        close: string
        closed: boolean
      }
    }
  }
}

const props = defineProps<Props>()

// Reactive data
const activeTab = ref('hero')

const tabs = [
  { id: 'hero', name: 'Hero Section' },
  { id: 'services', name: 'Layanan' },
  { id: 'doctors', name: 'Tim Dokter' },
  { id: 'contact', name: 'Kontak' }
]

// Make content reactive for editing
const heroContent = ref({ ...props.heroContent })
const servicesContent = ref([...props.servicesContent])
const doctorsContent = ref([...props.doctorsContent])
const contactContent = ref({ 
  ...props.contactContent,
  schedule: props.contactContent.hours
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

const saveAllChanges = async () => {
  try {
    // Save hero content
    await router.post('/admin/content', {
      type: 'hero',
      content: heroContent.value
    }, {
      headers: {
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      }
    })

    // Save services content
    await router.post('/admin/content', {
      type: 'services',
      content: servicesContent.value
    }, {
      headers: {
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      }
    })

    // Save doctors content
    await router.post('/admin/content', {
      type: 'doctors',
      content: doctorsContent.value
    }, {
      headers: {
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      }
    })

    // Save contact content
    await router.post('/admin/content', {
      type: 'contact',
      content: {
        ...contactContent.value,
        hours: contactContent.value.schedule
      }
    }, {
      headers: {
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      }
    })

    alert('Semua perubahan telah disimpan!')
  } catch (error) {
    console.error('Error saving content:', error)
    alert('Terjadi kesalahan saat menyimpan perubahan')
  }
}
</script>
<style scoped>
/* Ensure full width by removing any inherited constraints */
:deep(.container),
:deep(.max-w-7xl),
:deep(.mx-auto) {
  max-width: 100% !important;
  padding-left: 0 !important;
  padding-right: 0 !important;
}
</style>