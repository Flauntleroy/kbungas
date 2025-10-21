<template>
  <div class="min-h-screen bg-gray-50">
    <!-- Header -->
    <div class="bg-white shadow-sm border-b border-gray-200">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center py-6">
          <div>
            <h1 class="text-3xl font-bold text-gray-900">Kelola Review Dokter</h1>
            <p class="mt-1 text-sm text-gray-600">Kelola dan moderasi review dari pasien</p>
          </div>
          <div class="flex items-center space-x-4">
            <button
              @click="refreshData"
              class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-lg text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-blue-500"
            >
              <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
              </svg>
              Refresh
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Statistics Cards -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div class="flex items-center">
            <div class="flex-shrink-0">
              <div class="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
                <svg class="w-5 h-5 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5.291A7.962 7.962 0 0120 12a8 8 0 11-16 0 8 8 0 016 7.291z"></path>
                </svg>
              </div>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-600">Total Review</p>
              <p class="text-2xl font-semibold text-gray-900">{{ stats.total }}</p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div class="flex items-center">
            <div class="flex-shrink-0">
              <div class="w-8 h-8 bg-yellow-100 rounded-lg flex items-center justify-center">
                <svg class="w-5 h-5 text-yellow-600" fill="currentColor" viewBox="0 0 20 20">
                  <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                </svg>
              </div>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-600">Rating Rata-rata</p>
              <p class="text-2xl font-semibold text-gray-900">{{ stats.averageRating }}</p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div class="flex items-center">
            <div class="flex-shrink-0">
              <div class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center">
                <svg class="w-5 h-5 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
              </div>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-600">Disetujui</p>
              <p class="text-2xl font-semibold text-gray-900">{{ stats.approved }}</p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div class="flex items-center">
            <div class="flex-shrink-0">
              <div class="w-8 h-8 bg-orange-100 rounded-lg flex items-center justify-center">
                <svg class="w-5 h-5 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
              </div>
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-gray-600">Menunggu</p>
              <p class="text-2xl font-semibold text-gray-900">{{ stats.pending }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Filters and Search -->
      <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 mb-6">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Cari Review</label>
            <input
              v-model="filters.search"
              type="text"
              placeholder="Nama dokter atau pasien..."
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
            <select
              v-model="filters.status"
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            >
              <option value="">Semua Status</option>
              <option value="approved">Disetujui</option>
              <option value="pending">Menunggu</option>
            </select>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Rating</label>
            <select
              v-model="filters.rating"
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            >
              <option value="">Semua Rating</option>
              <option value="5">5 Bintang</option>
              <option value="4">4 Bintang</option>
              <option value="3">3 Bintang</option>
              <option value="2">2 Bintang</option>
              <option value="1">1 Bintang</option>
            </select>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Unggulan</label>
            <select
              v-model="filters.featured"
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
            >
              <option value="">Semua</option>
              <option value="1">Unggulan</option>
              <option value="0">Tidak Unggulan</option>
            </select>
          </div>
        </div>
      </div>

      <!-- Reviews Table -->
      <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-200">
          <h3 class="text-lg font-medium text-gray-900">Daftar Review</h3>
        </div>

        <!-- Loading State -->
        <div v-if="loading" class="p-8 text-center">
          <div class="inline-flex items-center justify-center w-16 h-16 bg-blue-100 rounded-full mb-4">
            <svg class="animate-spin w-8 h-8 text-blue-600" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
          </div>
          <p class="text-gray-600">Memuat data review...</p>
        </div>

        <!-- Table -->
        <div v-else-if="paginatedReviews.length > 0" class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
              <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Pasien & Dokter</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Rating</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Review</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tanggal</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Aksi</th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <tr v-for="review in paginatedReviews" :key="review.id" class="hover:bg-gray-50">
                <td class="px-6 py-4 whitespace-nowrap">
                  <div>
                    <div class="text-sm font-medium text-gray-900">{{ review.nama_pasien || 'Pasien' }}</div>
                    <div class="text-sm text-gray-500">ID: {{ review.id_pasien }}</div>
                    <div class="text-sm text-blue-600 font-medium">Dr. {{ review.nama_dokter }}</div>
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="flex items-center">
                    <div class="flex">
                      <svg
                        v-for="star in 5"
                        :key="star"
                        class="w-4 h-4"
                        :class="star <= review.rating ? 'text-yellow-400' : 'text-gray-300'"
                        fill="currentColor"
                        viewBox="0 0 20 20"
                      >
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                      </svg>
                    </div>
                    <span class="ml-2 text-sm text-gray-600">{{ review.rating }}/5</span>
                  </div>
                </td>
                <td class="px-6 py-4">
                  <div class="text-sm text-gray-900 max-w-xs truncate">
                    {{ review.ulasan || 'Tidak ada komentar' }}
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="flex flex-col space-y-1">
                    <span
                      :class="[
                        'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium',
                        review.is_approved 
                          ? 'bg-green-100 text-green-800' 
                          : 'bg-yellow-100 text-yellow-800'
                      ]"
                    >
                      {{ review.is_approved ? 'Disetujui' : 'Menunggu' }}
                    </span>
                    <span
                      v-if="review.is_featured"
                      class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-purple-100 text-purple-800"
                    >
                      Unggulan
                    </span>
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                  {{ formatDate(review.tanggal_penilaian) }}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                  <div class="flex items-center space-x-2">
                    <button
                      @click="viewReview(review)"
                      class="text-blue-600 hover:text-blue-900 p-1 rounded"
                      title="Lihat Detail"
                    >
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                      </svg>
                    </button>
                    <button
                      v-if="!review.is_approved"
                      @click="approveReview(review.id)"
                      class="text-green-600 hover:text-green-900 p-1 rounded"
                      title="Setujui"
                    >
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                      </svg>
                    </button>
                    <button
                      @click="toggleFeatured(review.id, !review.is_featured)"
                      :class="[
                        'p-1 rounded',
                        review.is_featured 
                          ? 'text-purple-600 hover:text-purple-900' 
                          : 'text-gray-400 hover:text-purple-600'
                      ]"
                      :title="review.is_featured ? 'Hapus dari Unggulan' : 'Jadikan Unggulan'"
                    >
                      <svg class="w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                      </svg>
                    </button>
                    <button
                      @click="deleteReview(review.id)"
                      class="text-red-600 hover:text-red-900 p-1 rounded"
                      title="Hapus"
                    >
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                      </svg>
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- Empty State -->
        <div v-else class="p-8 text-center">
          <div class="inline-flex items-center justify-center w-16 h-16 bg-gray-100 rounded-full mb-4">
            <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5.291A7.962 7.962 0 0120 12a8 8 0 11-16 0 8 8 0 016 7.291z"></path>
            </svg>
          </div>
          <h3 class="text-lg font-medium text-gray-900 mb-2">Tidak Ada Review</h3>
          <p class="text-gray-600">Belum ada review yang sesuai dengan filter yang dipilih.</p>
        </div>

        <!-- Pagination -->
        <div v-if="totalPages > 1" class="px-6 py-4 border-t border-gray-200">
          <div class="flex items-center justify-between">
            <div class="text-sm text-gray-700">
              Menampilkan {{ ((currentPage - 1) * itemsPerPage) + 1 }} sampai {{ Math.min(currentPage * itemsPerPage, filteredReviews.length) }} dari {{ filteredReviews.length }} review
            </div>
            <nav class="flex items-center space-x-2">
              <button
                @click="currentPage = Math.max(1, currentPage - 1)"
                :disabled="currentPage === 1"
                class="px-3 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Sebelumnya
              </button>
              
              <button
                v-for="page in visiblePages"
                :key="page"
                @click="currentPage = page"
                :class="[
                  'px-3 py-2 text-sm font-medium rounded-lg',
                  page === currentPage
                    ? 'text-white bg-blue-600 border border-blue-600'
                    : 'text-gray-700 bg-white border border-gray-300 hover:bg-gray-50'
                ]"
              >
                {{ page }}
              </button>
              
              <button
                @click="currentPage = Math.min(totalPages, currentPage + 1)"
                :disabled="currentPage === totalPages"
                class="px-3 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Selanjutnya
              </button>
            </nav>
          </div>
        </div>
      </div>
    </div>

    <!-- Review Detail Modal -->
    <div
      v-if="selectedReview"
      class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50"
      @click="closeModal"
    >
      <div class="relative top-20 mx-auto p-5 border w-11/12 md:w-3/4 lg:w-1/2 shadow-lg rounded-xl bg-white" @click.stop>
        <div class="flex items-center justify-between mb-6">
          <h3 class="text-xl font-bold text-gray-900">Detail Review</h3>
          <button
            @click="closeModal"
            class="text-gray-400 hover:text-gray-600"
          >
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
            </svg>
          </button>
        </div>

        <div class="space-y-4">
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700">Nama Pasien</label>
              <p class="mt-1 text-sm text-gray-900">{{ selectedReview.nama_pasien || 'Tidak tersedia' }}</p>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">ID Pasien</label>
              <p class="mt-1 text-sm text-gray-900">{{ selectedReview.id_pasien }}</p>
            </div>
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700">Email Pasien</label>
              <p class="mt-1 text-sm text-gray-900">{{ selectedReview.email_pasien || 'Tidak tersedia' }}</p>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">Nama Dokter</label>
              <p class="mt-1 text-sm text-gray-900">Dr. {{ selectedReview.nama_dokter }}</p>
            </div>
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700">Rating</label>
              <div class="mt-1 flex items-center">
                <div class="flex">
                  <svg
                    v-for="star in 5"
                    :key="star"
                    class="w-5 h-5"
                    :class="star <= selectedReview.rating ? 'text-yellow-400' : 'text-gray-300'"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                  </svg>
                </div>
                <span class="ml-2 text-sm text-gray-600">{{ selectedReview.rating }}/5</span>
              </div>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700">Tanggal Penilaian</label>
              <p class="mt-1 text-sm text-gray-900">{{ formatDate(selectedReview.tanggal_penilaian) }}</p>
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700">Ulasan/Komentar</label>
            <p class="mt-1 text-sm text-gray-900 bg-gray-50 p-3 rounded-lg">
              {{ selectedReview.ulasan || 'Tidak ada komentar.' }}
            </p>
          </div>

          <div class="flex items-center space-x-4 pt-4 border-t border-gray-200">
            <div class="flex items-center">
              <span class="text-sm font-medium text-gray-700 mr-2">Status:</span>
              <span
                :class="[
                  'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium',
                  selectedReview.is_approved 
                    ? 'bg-green-100 text-green-800' 
                    : 'bg-yellow-100 text-yellow-800'
                ]"
              >
                {{ selectedReview.is_approved ? 'Disetujui' : 'Menunggu Persetujuan' }}
              </span>
            </div>
            <div class="flex items-center">
              <span class="text-sm font-medium text-gray-700 mr-2">Unggulan:</span>
              <span
                :class="[
                  'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium',
                  selectedReview.is_featured 
                    ? 'bg-purple-100 text-purple-800' 
                    : 'bg-gray-100 text-gray-800'
                ]"
              >
                {{ selectedReview.is_featured ? 'Ya' : 'Tidak' }}
              </span>
            </div>
          </div>
        </div>

        <div class="flex justify-end space-x-3 mt-6 pt-4 border-t border-gray-200">
          <button
            @click="closeModal"
            class="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50"
          >
            Tutup
          </button>
          <button
            v-if="!selectedReview.is_approved"
            @click="approveReview(selectedReview.id)"
            class="px-4 py-2 text-sm font-medium text-white bg-green-600 border border-transparent rounded-lg hover:bg-green-700"
          >
            Setujui Review
          </button>
          <button
            @click="toggleFeatured(selectedReview.id, !selectedReview.is_featured)"
            :class="[
              'px-4 py-2 text-sm font-medium border border-transparent rounded-lg',
              selectedReview.is_featured
                ? 'text-white bg-gray-600 hover:bg-gray-700'
                : 'text-white bg-purple-600 hover:bg-purple-700'
            ]"
          >
            {{ selectedReview.is_featured ? 'Hapus dari Unggulan' : 'Jadikan Unggulan' }}
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted, watch } from 'vue'
import axios from 'axios'


const reviews = ref([])
const loading = ref(true)
const selectedReview = ref(null)
const currentPage = ref(1)
const itemsPerPage = 10


const filters = ref({
  search: '',
  status: '',
  rating: '',
  featured: ''
})


const stats = ref({
  total: 0,
  approved: 0,
  pending: 0,
  averageRating: 0
})


const filteredReviews = computed(() => {
  let filtered = reviews.value

  
  if (filters.value.search) {
    const search = filters.value.search.toLowerCase()
    filtered = filtered.filter(review =>
      review.nama_dokter.toLowerCase().includes(search) ||
      (review.nama_pasien && review.nama_pasien.toLowerCase().includes(search)) ||
      review.id_pasien.toLowerCase().includes(search)
    )
  }

  
  if (filters.value.status) {
    if (filters.value.status === 'approved') {
      filtered = filtered.filter(review => review.is_approved)
    } else if (filters.value.status === 'pending') {
      filtered = filtered.filter(review => !review.is_approved)
    }
  }

  
  if (filters.value.rating) {
    const rating = parseInt(filters.value.rating)
    filtered = filtered.filter(review => review.rating === rating)
  }

  
  if (filters.value.featured !== '') {
    const isFeatured = filters.value.featured === '1'
    filtered = filtered.filter(review => review.is_featured === isFeatured)
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
  const total = reviews.value.length
  const approved = reviews.value.filter(review => review.is_approved).length
  const pending = total - approved
  const totalRating = reviews.value.reduce((sum, review) => sum + review.rating, 0)
  const averageRating = total > 0 ? (totalRating / total).toFixed(1) : 0

  stats.value = {
    total,
    approved,
    pending,
    averageRating
  }
}

const approveReview = async (id) => {
  try {
    const response = await axios.patch(`/api/doctor-reviews/${id}/approve`)
    
    if (response.data.success) {
      
      const review = reviews.value.find(r => r.id === id)
      if (review) {
        review.is_approved = true
      }
      
      
      if (selectedReview.value && selectedReview.value.id === id) {
        selectedReview.value.is_approved = true
      }
      
      calculateStats()
    }
  } catch (error) {
    console.error('Error approving review:', error)
  }
}

const toggleFeatured = async (id, featured) => {
  try {
    const response = await axios.patch(`/api/doctor-reviews/${id}/feature`, {
      featured: featured
    })
    
    if (response.data.success) {
      
      const review = reviews.value.find(r => r.id === id)
      if (review) {
        review.is_featured = featured
      }
      
      
      if (selectedReview.value && selectedReview.value.id === id) {
        selectedReview.value.is_featured = featured
      }
    }
  } catch (error) {
    console.error('Error toggling featured status:', error)
  }
}

const deleteReview = async (id) => {
  if (!confirm('Apakah Anda yakin ingin menghapus review ini?')) {
    return
  }
  
  try {
    const response = await axios.delete(`/api/doctor-reviews/${id}`)
    
    if (response.data.success) {
      
      reviews.value = reviews.value.filter(r => r.id !== id)
      calculateStats()
      
      
      if (selectedReview.value && selectedReview.value.id === id) {
        selectedReview.value = null
      }
    }
  } catch (error) {
    console.error('Error deleting review:', error)
  }
}

const viewReview = (review) => {
  selectedReview.value = review
}

const closeModal = () => {
  selectedReview.value = null
}

const refreshData = () => {
  fetchReviews()
}

const formatDate = (dateString) => {
  const options = { 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  }
  return new Date(dateString).toLocaleDateString('id-ID', options)
}


watch(filters, () => {
  currentPage.value = 1
}, { deep: true })


onMounted(() => {
  fetchReviews()
})
</script>

<style scoped>
/* Additional custom styles if needed */
</style>