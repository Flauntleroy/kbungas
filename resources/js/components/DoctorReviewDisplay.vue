<template>
  <div class="bg-gradient-to-br from-blue-50 to-indigo-100 py-20">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header Section -->
      <div class="text-center mb-16">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-blue-600 to-indigo-700 rounded-full mb-8 shadow-lg">
          <svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"></path>
          </svg>
        </div>
        <h2 class="text-5xl font-bold text-gray-900 mb-6">Review Dokter</h2>
        <p class="text-xl text-gray-600 max-w-3xl mx-auto leading-relaxed">
          Kepuasan pasien adalah prioritas utama kami. Lihat pengalaman nyata dari pasien yang telah dilayani oleh dokter-dokter terbaik kami.
        </p>
      </div>

      <!-- Statistics Section -->
      <div class="grid grid-cols-1 md:grid-cols-4 gap-8 mb-16">
        <div class="bg-white rounded-3xl p-8 shadow-xl border border-gray-100 text-center transform hover:scale-105 transition-all duration-300">
          <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5.291A7.962 7.962 0 0120 12a8 8 0 11-16 0 8 8 0 016 7.291z"></path>
            </svg>
          </div>
          <div class="text-4xl font-bold text-blue-600 mb-2">{{ stats.totalReviews }}</div>
          <div class="text-gray-600 font-medium">Total Review</div>
        </div>
        
        <div class="bg-white rounded-3xl p-8 shadow-xl border border-gray-100 text-center transform hover:scale-105 transition-all duration-300">
          <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg class="w-8 h-8 text-yellow-600" fill="currentColor" viewBox="0 0 20 20">
              <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
            </svg>
          </div>
          <div class="flex items-center justify-center mb-2">
            <span class="text-4xl font-bold text-yellow-600">{{ stats.averageRating }}</span>
            <span class="text-lg text-gray-500 ml-1">/5</span>
          </div>
          <div class="text-gray-600 font-medium">Rating Rata-rata</div>
        </div>
        
        <div class="bg-white rounded-3xl p-8 shadow-xl border border-gray-100 text-center transform hover:scale-105 transition-all duration-300">
          <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
          </div>
          <div class="text-4xl font-bold text-green-600 mb-2">{{ stats.highRatedCount }}</div>
          <div class="text-gray-600 font-medium">Review 5 Bintang</div>
        </div>
        
        <div class="bg-white rounded-3xl p-8 shadow-xl border border-gray-100 text-center transform hover:scale-105 transition-all duration-300">
          <div class="w-16 h-16 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
            </svg>
          </div>
          <div class="text-4xl font-bold text-purple-600 mb-2">{{ stats.doctorCount }}</div>
          <div class="text-gray-600 font-medium">Dokter Direview</div>
        </div>
      </div>

      <!-- Filter Section -->
      <div class="bg-white rounded-3xl p-8 shadow-xl border border-gray-100 mb-12">
        <div class="flex flex-wrap items-center gap-6">
          <div class="flex-1 min-w-80">
            <div class="relative">
              <svg class="absolute left-4 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
              </svg>
              <input
                v-model="searchDoctor"
                type="text"
                placeholder="Cari nama dokter..."
                class="w-full pl-12 pr-4 py-4 border border-gray-300 rounded-2xl focus:ring-2 focus:ring-blue-500 focus:border-transparent text-lg"
              />
            </div>
          </div>
          <div class="flex items-center space-x-3">
            <label class="text-lg font-medium text-gray-700">Rating:</label>
            <select
              v-model="filterRating"
              class="px-6 py-4 border border-gray-300 rounded-2xl focus:ring-2 focus:ring-blue-500 focus:border-transparent text-lg"
            >
              <option value="">Semua Rating</option>
              <option value="5">5 Bintang</option>
              <option value="4">4+ Bintang</option>
              <option value="3">3+ Bintang</option>
            </select>
          </div>
          <button
            @click="toggleFeaturedOnly"
            :class="[
              'px-8 py-4 rounded-2xl font-semibold text-lg transition-all duration-300 transform hover:scale-105',
              showFeaturedOnly 
                ? 'bg-gradient-to-r from-blue-600 to-indigo-700 text-white shadow-lg' 
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
            ]"
          >
            <svg class="w-5 h-5 inline mr-2" fill="currentColor" viewBox="0 0 20 20">
              <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
            </svg>
            Review Unggulan
          </button>
        </div>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="text-center py-20">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-blue-100 rounded-full mb-6">
          <svg class="animate-spin w-10 h-10 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
          </svg>
        </div>
        <p class="text-xl text-gray-600">Memuat review...</p>
      </div>

      <!-- Reviews Grid -->
      <div v-else-if="filteredReviews.length > 0" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div
          v-for="review in paginatedReviews"
          :key="review.id"
          class="group bg-white rounded-3xl p-8 shadow-xl border border-gray-100 hover:shadow-2xl transition-all duration-500 transform hover:-translate-y-2 relative overflow-hidden"
        >
          <!-- Background Pattern -->
          <div class="absolute top-0 right-0 w-32 h-32 bg-gradient-to-br from-blue-50 to-indigo-100 rounded-full -translate-y-16 translate-x-16 opacity-50 group-hover:opacity-70 transition-opacity duration-300"></div>
          
          <!-- Featured Badge -->
          <div v-if="review.is_featured" class="absolute top-6 right-6 z-10">
            <div class="inline-flex items-center px-4 py-2 rounded-full text-sm font-bold bg-gradient-to-r from-yellow-400 to-orange-500 text-white shadow-lg">
              <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
              </svg>
              Unggulan
            </div>
          </div>

          <!-- Doctor Info -->
          <div class="relative z-10 mb-6">
            <div class="flex items-center mb-4">
              <div class="w-16 h-16 bg-gradient-to-br from-blue-500 to-indigo-600 rounded-full flex items-center justify-center mr-4 shadow-lg">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                </svg>
              </div>
              <div>
                <h3 class="text-xl font-bold text-gray-900 mb-1">{{ review.nama_dokter }}</h3>
                <p class="text-gray-600 font-medium">{{ review.spesialis || 'Dokter Umum' }}</p>
              </div>
            </div>
          </div>

          <!-- Rating -->
          <div class="relative z-10 mb-6">
            <div class="flex items-center mb-3">
              <div class="flex items-center mr-3">
                <svg
                  v-for="i in 5"
                  :key="i"
                  :class="[
                    'w-6 h-6',
                    i <= review.rating ? 'text-yellow-400' : 'text-gray-300'
                  ]"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                </svg>
              </div>
              <span class="text-lg font-bold text-gray-900">{{ review.rating }}/5</span>
            </div>
          </div>

          <!-- Review Content -->
          <div class="relative z-10 mb-6">
            <blockquote class="text-gray-700 text-lg leading-relaxed italic">
              "{{ review.komentar }}"
            </blockquote>
          </div>

          <!-- Patient Info & Date -->
          <div class="relative z-10 flex items-center justify-between pt-6 border-t border-gray-100">
            <div class="flex items-center">
              <div class="w-10 h-10 bg-gray-100 rounded-full flex items-center justify-center mr-3">
                <svg class="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                </svg>
              </div>
              <div>
                <p class="font-semibold text-gray-900">{{ review.nama_pasien || 'Pasien' }}</p>
                <p class="text-sm text-gray-500">{{ formatDate(review.created_at) }}</p>
              </div>
            </div>
            
            <!-- Verified Badge -->
            <div class="flex items-center text-green-600">
              <svg class="w-5 h-5 mr-1" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
              </svg>
              <span class="text-sm font-medium">Terverifikasi</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Empty State -->
      <div v-else class="text-center py-20">
        <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
          <svg class="w-12 h-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5.291A7.962 7.962 0 0120 12a8 8 0 11-16 0 8 8 0 016 7.291z"></path>
          </svg>
        </div>
        <h3 class="text-2xl font-bold text-gray-900 mb-4">Belum Ada Review</h3>
        <p class="text-xl text-gray-600 max-w-md mx-auto">
          Jadilah yang pertama memberikan review untuk dokter kami!
        </p>
      </div>

      <!-- Pagination -->
      <div v-if="totalPages > 1" class="flex justify-center mt-16">
        <nav class="flex items-center space-x-2">
          <button
            @click="currentPage = Math.max(1, currentPage - 1)"
            :disabled="currentPage === 1"
            :class="[
              'px-4 py-3 rounded-xl font-medium transition-all duration-200',
              currentPage === 1
                ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
                : 'bg-white text-gray-700 hover:bg-blue-50 hover:text-blue-600 shadow-md'
            ]"
          >
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
          </button>

          <button
            v-for="page in visiblePages"
            :key="page"
            @click="currentPage = page"
            :class="[
              'px-4 py-3 rounded-xl font-medium transition-all duration-200',
              page === currentPage
                ? 'bg-gradient-to-r from-blue-600 to-indigo-700 text-white shadow-lg'
                : 'bg-white text-gray-700 hover:bg-blue-50 hover:text-blue-600 shadow-md'
            ]"
          >
            {{ page }}
          </button>

          <button
            @click="currentPage = Math.min(totalPages, currentPage + 1)"
            :disabled="currentPage === totalPages"
            :class="[
              'px-4 py-3 rounded-xl font-medium transition-all duration-200',
              currentPage === totalPages
                ? 'bg-gray-100 text-gray-400 cursor-not-allowed'
                : 'bg-white text-gray-700 hover:bg-blue-50 hover:text-blue-600 shadow-md'
            ]"
          >
            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
            </svg>
          </button>
        </nav>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'

// Reactive data
const reviews = ref([])
const loading = ref(true)
const searchDoctor = ref('')
const filterRating = ref('')
const showFeaturedOnly = ref(false)
const currentPage = ref(1)
const itemsPerPage = 6

// Statistics
const stats = ref({
  totalReviews: 0,
  averageRating: 0,
  highRatedCount: 0,
  doctorCount: 0
})

// Computed properties
const filteredReviews = computed(() => {
  let filtered = reviews.value.filter(review => review.is_approved)

  if (searchDoctor.value) {
    const search = searchDoctor.value.toLowerCase()
    filtered = filtered.filter(review =>
      review.nama_dokter.toLowerCase().includes(search)
    )
  }

  if (filterRating.value) {
    const rating = parseInt(filterRating.value)
    filtered = filtered.filter(review => review.rating >= rating)
  }

  if (showFeaturedOnly.value) {
    filtered = filtered.filter(review => review.is_featured)
  }

  return filtered
})

const totalPages = computed(() => {
  return Math.ceil(filteredReviews.value.length / itemsPerPage)
})

const paginatedReviews = computed(() => {
  const start = (currentPage.value - 1) * itemsPerPage
  const end = start + itemsPerPage
  return filteredReviews.value.slice(start, end)
})

const visiblePages = computed(() => {
  const pages = []
  const total = totalPages.value
  const current = currentPage.value
  
  if (total <= 7) {
    for (let i = 1; i <= total; i++) {
      pages.push(i)
    }
  } else {
    if (current <= 4) {
      for (let i = 1; i <= 5; i++) pages.push(i)
      pages.push('...')
      pages.push(total)
    } else if (current >= total - 3) {
      pages.push(1)
      pages.push('...')
      for (let i = total - 4; i <= total; i++) pages.push(i)
    } else {
      pages.push(1)
      pages.push('...')
      for (let i = current - 1; i <= current + 1; i++) pages.push(i)
      pages.push('...')
      pages.push(total)
    }
  }
  
  return pages.filter(page => page !== '...' || pages.indexOf(page) === pages.lastIndexOf(page))
})

// Methods
const fetchReviews = async () => {
  try {
    loading.value = true
    const response = await axios.get('/api/doctor-reviews')
    
    if (response.data.success) {
      reviews.value = response.data.data
      calculateStats()
    }
  } catch (error) {
    console.error('Error fetching reviews:', error)
  } finally {
    loading.value = false
  }
}

const calculateStats = () => {
  const approvedReviews = reviews.value.filter(review => review.is_approved)
  const totalReviews = approvedReviews.length
  const totalRating = approvedReviews.reduce((sum, review) => sum + review.rating, 0)
  const averageRating = totalReviews > 0 ? (totalRating / totalReviews).toFixed(1) : 0
  const highRatedCount = approvedReviews.filter(review => review.rating === 5).length
  const doctorCount = new Set(approvedReviews.map(review => review.nama_dokter)).size

  stats.value = {
    totalReviews,
    averageRating,
    highRatedCount,
    doctorCount
  }
}

const toggleFeaturedOnly = () => {
  showFeaturedOnly.value = !showFeaturedOnly.value
  currentPage.value = 1
}

const formatDate = (dateString) => {
  const options = { 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric'
  }
  return new Date(dateString).toLocaleDateString('id-ID', options)
}

// Lifecycle
onMounted(() => {
  fetchReviews()
})
</script>