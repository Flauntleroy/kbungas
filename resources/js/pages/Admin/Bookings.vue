<template>
  <AdminLayout>
    <!-- Header with actions -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-6">
      <div>
        <h1 class="text-2xl font-bold text-gray-900">Manajemen Booking</h1>
        <p class="text-gray-600 mt-1">Kelola semua booking dan janji konsultasi pasien</p>
      </div>
      <div class="mt-4 sm:mt-0 flex space-x-3">
        <button 
          @click="showFilters = !showFilters"
          class="bg-white border border-rose-200 text-rose-600 px-4 py-2 rounded-xl hover:bg-rose-50 transition-colors flex items-center"
        >
          <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/>
          </svg>
          Filter
        </button>
        <button 
          @click="openCreateModal"
          class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-2 rounded-xl hover:from-rose-600 hover:to-pink-600 transition-all shadow-lg flex items-center"
        >
          <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
          </svg>
          Tambah Booking
        </button>
      </div>
    </div>

    <!-- Filters -->
    <div v-if="showFilters" class="bg-white rounded-2xl p-6 shadow-sm border border-rose-100 mb-6">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
          <select v-model="filters.status" class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            <option value="">Semua Status</option>
            <option value="pending">Menunggu</option>
            <option value="confirmed">Dikonfirmasi</option>
            <option value="completed">Selesai</option>
            <option value="cancelled">Dibatalkan</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Tanggal Mulai</label>
          <input v-model="filters.startDate" type="date" class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Tanggal Akhir</label>
          <input v-model="filters.endDate" type="date" class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Dokter</label>
          <select v-model="filters.doctor" class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            <option value="">Semua Dokter</option>
            <option value="dr-bunga-sari">dr. Bunga Sari, Sp.KK</option>
          </select>
        </div>
      </div>
      <div class="flex justify-end mt-4 space-x-3">
        <button @click="resetFilters" class="px-4 py-2 text-gray-600 hover:text-gray-800">Reset</button>
        <button @click="applyFilters" class="bg-rose-500 text-white px-6 py-2 rounded-xl hover:bg-rose-600 transition-colors">Terapkan Filter</button>
      </div>
    </div>

    <!-- Bookings Table -->
    <div class="bg-white rounded-2xl shadow-sm border border-rose-100 overflow-hidden">
      <div class="px-6 py-4 border-b border-rose-100">
        <div class="flex items-center justify-between">
          <h3 class="text-lg font-semibold text-gray-900">Daftar Booking</h3>
          <div class="flex items-center space-x-4">
            <div class="relative">
              <input 
                v-model="searchQuery"
                type="text" 
                placeholder="Cari nama pasien..."
                class="pl-10 pr-4 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900 placeholder-gray-500"
              >
              <svg class="w-4 h-4 text-gray-400 absolute left-3 top-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
              </svg>
            </div>
          </div>
        </div>
      </div>

      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Pasien</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tanggal & Waktu</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Dokter</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Kontak</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Aksi</th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="booking in filteredBookings" :key="booking.id" class="hover:bg-gray-50">
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center">
                  <div class="w-10 h-10 bg-gradient-to-r from-rose-500 to-pink-500 rounded-full flex items-center justify-center">
                    <span class="text-white text-sm font-semibold">{{ booking.patient_name.charAt(0) }}</span>
                  </div>
                  <div class="ml-4">
                    <div class="text-sm font-medium text-gray-900">{{ booking.patient_name }}</div>
                    <div class="text-sm text-gray-500">{{ booking.patient_phone }}</div>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">{{ formatDate(booking.appointment_date) }}</div>
                <div class="text-sm text-gray-500">{{ booking.appointment_time }}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">{{ booking.doctor }}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span :class="[
                  'inline-flex px-2 py-1 text-xs font-semibold rounded-full',
                  booking.status === 'confirmed' ? 'bg-green-100 text-green-800' :
                  booking.status === 'pending' ? 'bg-yellow-100 text-yellow-800' :
                  booking.status === 'completed' ? 'bg-blue-100 text-blue-800' :
                  'bg-red-100 text-red-800'
                ]">
                  {{ getStatusText(booking.status) }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                <div class="flex space-x-2">
                  <a :href="`tel:${booking.patient_phone}`" class="text-rose-600 hover:text-rose-800">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                    </svg>
                  </a>
                  <a :href="`https://wa.me/${booking.patient_phone.replace(/[^0-9]/g, '')}`" class="text-green-600 hover:text-green-800">
                    <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 24 24">
                      <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.109"/>
                    </svg>
                  </a>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <div class="flex space-x-2">
                  <button @click="editBooking(booking)" class="text-rose-600 hover:text-rose-800">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                    </svg>
                  </button>
                  <button @click="deleteBooking(booking)" class="text-red-600 hover:text-red-800">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                    </svg>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="px-6 py-4 border-t border-rose-100">
        <div class="flex items-center justify-between">
          <div class="text-sm text-gray-500">
            Menampilkan {{ (currentPage - 1) * itemsPerPage + 1 }} - {{ Math.min(currentPage * itemsPerPage, totalItems) }} dari {{ totalItems }} booking
          </div>
          <div class="flex space-x-2">
            <button 
              @click="previousPage" 
              :disabled="currentPage === 1"
              class="px-3 py-1 border border-rose-200 rounded-lg text-sm text-gray-600 hover:bg-rose-50 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Sebelumnya
            </button>
            <button 
              v-for="page in visiblePages" 
              :key="page"
              @click="goToPage(page)"
              :class="[
                'px-3 py-1 border rounded-lg text-sm',
                page === currentPage 
                  ? 'bg-rose-500 text-white border-rose-500' 
                  : 'border-rose-200 text-gray-600 hover:bg-rose-50'
              ]"
            >
              {{ page }}
            </button>
            <button 
              @click="nextPage" 
              :disabled="currentPage === totalPages"
              class="px-3 py-1 border border-rose-200 rounded-lg text-sm text-gray-600 hover:bg-rose-50 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Selanjutnya
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Create/Edit Modal -->
    <div v-if="showModal" class="fixed inset-0 z-50 overflow-y-auto">
      <div class="flex items-center justify-center min-h-screen px-4">
        <div class="fixed inset-0 bg-gray-600 bg-opacity-75" @click="closeModal"></div>
        <div class="bg-white rounded-2xl p-6 w-full max-w-md relative">
          <h3 class="text-lg font-semibold text-gray-900 mb-4">
            {{ editingBooking ? 'Edit Booking' : 'Tambah Booking Baru' }}
          </h3>
          
          <form @submit.prevent="saveBooking" class="space-y-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Nama Pasien</label>
              <input v-model="bookingForm.patient_name" type="text" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Nomor Telepon</label>
              <input v-model="bookingForm.patient_phone" type="tel" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Tanggal Janji</label>
              <input v-model="bookingForm.appointment_date" type="date" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Waktu</label>
              <input v-model="bookingForm.appointment_time" type="time" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Dokter</label>
              <select v-model="bookingForm.doctor" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
                <option value="">Pilih Dokter</option>
                <option value="dr. Bunga Sari, Sp.KK">dr. Bunga Sari, Sp.KK</option>
              </select>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
              <select v-model="bookingForm.status" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
                <option value="pending">Menunggu</option>
                <option value="confirmed">Dikonfirmasi</option>
                <option value="completed">Selesai</option>
                <option value="cancelled">Dibatalkan</option>
              </select>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Catatan</label>
              <textarea v-model="bookingForm.notes" rows="3" class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"></textarea>
            </div>
            
            <div class="flex justify-end space-x-3 pt-4">
              <button type="button" @click="closeModal" class="px-4 py-2 text-gray-600 hover:text-gray-800">
                Batal
              </button>
              <button type="submit" class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-2 rounded-xl hover:from-rose-600 hover:to-pink-600 transition-all">
                {{ editingBooking ? 'Update' : 'Simpan' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'

// State
const showFilters = ref(false)
const showModal = ref(false)
const editingBooking = ref(null)
const searchQuery = ref('')
const currentPage = ref(1)
const itemsPerPage = ref(10)

// Filters
const filters = ref({
  status: '',
  startDate: '',
  endDate: '',
  doctor: ''
})

// Form
const bookingForm = ref({
  patient_name: '',
  patient_phone: '',
  appointment_date: '',
  appointment_time: '',
  doctor: '',
  status: 'pending',
  notes: ''
})

// Mock data
const bookings = ref([
  {
    id: 1,
    patient_name: 'Sari Dewi',
    patient_phone: '081234567890',
    appointment_date: '2024-01-15',
    appointment_time: '10:00',
    doctor: 'dr. Bunga Sari, Sp.KK',
    status: 'confirmed',
    notes: 'Konsultasi rutin'
  },
  {
    id: 2,
    patient_name: 'Budi Santoso',
    patient_phone: '081234567891',
    appointment_date: '2024-01-15',
    appointment_time: '11:30',
    doctor: 'dr. Bunga Sari, Sp.KK',
    status: 'pending',
    notes: 'Keluhan gatal-gatal'
  },
  {
    id: 3,
    patient_name: 'Maya Putri',
    patient_phone: '081234567892',
    appointment_date: '2024-01-16',
    appointment_time: '14:00',
    doctor: 'dr. Bunga Sari, Sp.KK',
    status: 'completed',
    notes: 'Follow up treatment'
  }
])

// Computed
const filteredBookings = computed(() => {
  let filtered = bookings.value

  if (searchQuery.value) {
    filtered = filtered.filter(booking => 
      booking.patient_name.toLowerCase().includes(searchQuery.value.toLowerCase())
    )
  }

  if (filters.value.status) {
    filtered = filtered.filter(booking => booking.status === filters.value.status)
  }

  return filtered
})

const totalItems = computed(() => filteredBookings.value.length)
const totalPages = computed(() => Math.ceil(totalItems.value / itemsPerPage.value))

const visiblePages = computed(() => {
  const pages = []
  const start = Math.max(1, currentPage.value - 2)
  const end = Math.min(totalPages.value, currentPage.value + 2)
  
  for (let i = start; i <= end; i++) {
    pages.push(i)
  }
  
  return pages
})

// Methods
const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('id-ID', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

const getStatusText = (status: string) => {
  const statusMap = {
    pending: 'Menunggu',
    confirmed: 'Dikonfirmasi',
    completed: 'Selesai',
    cancelled: 'Dibatalkan'
  }
  return statusMap[status] || status
}

const openCreateModal = () => {
  editingBooking.value = null
  bookingForm.value = {
    patient_name: '',
    patient_phone: '',
    appointment_date: '',
    appointment_time: '',
    doctor: '',
    status: 'pending',
    notes: ''
  }
  showModal.value = true
}

const editBooking = (booking) => {
  editingBooking.value = booking
  bookingForm.value = { ...booking }
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
  editingBooking.value = null
}

const saveBooking = () => {
  if (editingBooking.value) {
    // Update existing booking
    const index = bookings.value.findIndex(b => b.id === editingBooking.value.id)
    if (index !== -1) {
      bookings.value[index] = { ...bookingForm.value }
    }
  } else {
    // Create new booking
    const newBooking = {
      ...bookingForm.value,
      id: Date.now()
    }
    bookings.value.unshift(newBooking)
  }
  
  closeModal()
}

const deleteBooking = (booking) => {
  if (confirm('Apakah Anda yakin ingin menghapus booking ini?')) {
    const index = bookings.value.findIndex(b => b.id === booking.id)
    if (index !== -1) {
      bookings.value.splice(index, 1)
    }
  }
}

const resetFilters = () => {
  filters.value = {
    status: '',
    startDate: '',
    endDate: '',
    doctor: ''
  }
}

const applyFilters = () => {
  // Filters are applied automatically via computed property
  showFilters.value = false
}

const previousPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
  }
}

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
  }
}

const goToPage = (page: number) => {
  currentPage.value = page
}
</script>