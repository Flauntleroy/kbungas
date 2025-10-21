<template>
  <AdminLayout>

    <div class="w-full">
    <!-- Header with actions -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-4">
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
    <div v-if="showFilters" class="bg-white rounded-2xl p-6 shadow-sm border border-rose-100 mb-4">
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
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">No Rekam Medis</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Pasien</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tanggal & Waktu</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Dokter</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Aksi & Kontak</th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="booking in filteredBookings" :key="booking.no_booking" class="hover:bg-gray-50">
               <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">
                  <span
                    :class="booking.pasien?.no_rkm_medis
                      ? 'bg-green-300 text-black font-bold px-3 py-1 rounded-lg shadow-md'
                      : 'bg-red-400 text-white font-bold px-3 py-1 rounded-lg shadow-md'"
                  >
                    {{ booking.pasien?.no_rkm_medis || 'Belum' }}
                  </span>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center">
                  <!-- <div class="w-10 h-10 bg-gradient-to-r from-rose-500 to-pink-500 rounded-full flex items-center justify-center">
                    <span class="text-white text-sm font-semibold">{{ booking.nama.charAt(0) }}</span>
                  </div> -->
                  <div class="ml-0">
                    <div class="text-sm font-medium text-gray-900">{{ booking.nama }}</div>
                    <div class="text-sm text-gray-500">{{ booking.no_telp }}</div>
                  </div>
                </div>
              </td>
             
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">{{ formatDate(booking.tanggal).date }}</div>
                <div class="text-sm text-gray-600">Pukul {{ formatDate(booking.tanggal).time }}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">{{ booking.dokter?.nm_dokter || 'N/A' }}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span :class="[
                  'inline-flex px-2 py-1 text-xs font-semibold rounded-full',
                  getStatusClass(booking.status)
                ]">
                  {{ getStatusText(booking.status) }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <div class="relative">
                    <button 
                      @click.stop="toggleDropdown(booking.no_booking)"
                      class="group inline-flex items-center justify-center w-10 h-10 rounded-full bg-gradient-to-br from-gray-50 to-gray-100 hover:from-rose-50 hover:to-pink-100 transition-all duration-300 focus:outline-none focus:ring-2 focus:ring-rose-500 focus:ring-offset-2 shadow-sm hover:shadow-md"
                    >
                    <svg 
                      class="w-5 h-5 text-gray-600 group-hover:text-gray-800 rotate-icon" 
                      :class="{ 'rotated': dropdownOpen === booking.no_booking }"
                      fill="none" 
                      stroke="currentColor" 
                      viewBox="0 0 24 24"
                    >
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z"/>
                    </svg>
                  </button>
                  
                  <Transition name="dropdown" appear>
                    <div 
                      v-show="dropdownOpen === booking.no_booking"
                      class="absolute right-0 mt-3 w-80 bg-white/95 backdrop-blur-sm rounded-2xl shadow-2xl border border-gray-200/50 z-50 overflow-hidden"
                      @click.stop
                    >
                      <!-- Header -->
                      <div class="px-5 py-4 bg-gradient-to-r from-rose-50/80 to-pink-50/80 border-b border-gray-200/30">
                        <div class="flex items-center justify-between">
                          <div class="flex items-center space-x-3">
                            <div class="w-10 h-10 bg-gradient-to-br from-rose-100 to-pink-100 rounded-full flex items-center justify-center">
                              <svg class="w-5 h-5 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                              </svg>
                            </div>
                            <div>
                              <h3 class="text-sm font-semibold text-gray-800">{{ booking.nama }}</h3>
                              <p class="text-xs text-gray-600 mt-0.5">{{ booking.no_telp }}</p>
                            </div>
                          </div>
                          <button 
                            @click="closeDropdown()"
                            class="p-1.5 rounded-full hover:bg-white/70 transition-all duration-200 group"
                          >
                            <svg class="w-4 h-4 text-gray-400 group-hover:text-gray-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                            </svg>
                          </button>
                        </div>
                      </div>

                      <div class="py-3">
                        <!-- Kontak Section -->
                        <div class="px-5 py-3">
                          <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3 flex items-center">
                            <svg class="w-3 h-3 mr-2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                            </svg>
                            Kontak
                          </h4>
                          <div class="space-y-2">
                            <a 
                              :href="`tel:${booking.no_telp}`" 
                              class="action-button flex items-center px-4 py-3 rounded-xl text-sm text-gray-700 hover:bg-blue-50/80 hover:text-blue-700 color-transition group border border-transparent hover:border-blue-200/50"
                            >
                              <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-blue-100 to-blue-200 flex items-center justify-center mr-3 group-hover:from-blue-200 group-hover:to-blue-300 transition-all duration-200">
                                <svg class="w-4 h-4 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                                </svg>
                              </div>
                              <div class="flex-1">
                                <span class="font-medium">Telepon</span>
                                <p class="text-xs text-gray-500 mt-0.5">Hubungi langsung</p>
                              </div>
                            </a>
                          
                            <a 
                              :href="`https://wa.me/${booking.no_telp.replace(/[^0-9]/g, '')}`" 
                              target="_blank"
                              class="action-button flex items-center px-4 py-3 rounded-xl text-sm text-gray-700 hover:bg-green-50/80 hover:text-green-700 color-transition group border border-transparent hover:border-green-200/50"
                            >
                              <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-green-100 to-green-200 flex items-center justify-center mr-3 group-hover:from-green-200 group-hover:to-green-300 transition-all duration-200">
                                <svg class="w-4 h-4 text-green-600" fill="currentColor" viewBox="0 0 24 24">
                                  <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.109"/>
                                </svg>
                              </div>
                              <div class="flex-1">
                                <span class="font-medium">WhatsApp</span>
                                <p class="text-xs text-gray-500 mt-0.5">Kirim pesan</p>
                              </div>
                            </a>
                          </div>
                        </div>
                        
                        <!-- Divider -->
                        <div class="mx-5 my-4 border-t border-gray-200/60"></div>
                        
                        <!-- Aksi Section -->
                        <div class="px-5 py-3">
                          <h4 class="text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3 flex items-center">
                            <svg class="w-3 h-3 mr-2 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z"/>
                            </svg>
                            Aksi
                          </h4>
                          <div class="space-y-2">
                            <button 
                              @click="editBooking(booking); closeDropdown()"
                              class="action-button flex items-center w-full px-4 py-3 rounded-xl text-sm text-gray-700 hover:bg-amber-50/80 hover:text-amber-700 color-transition group border border-transparent hover:border-amber-200/50"
                            >
                              <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-amber-100 to-amber-200 flex items-center justify-center mr-3 group-hover:from-amber-200 group-hover:to-amber-300 transition-all duration-200">
                                <svg class="w-4 h-4 text-amber-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                </svg>
                              </div>
                              <div class="flex-1 text-left">
                                <span class="font-medium">Edit Booking</span>
                                <p class="text-xs text-gray-500 mt-0.5">Ubah detail booking</p>
                              </div>
                            </button>
                            
                            <button 
                              v-if="booking.status === 'Belum Dibalas'"
                              @click="acceptBooking(booking); closeDropdown()"
                              :disabled="isAccepting"
                              class="action-button flex items-center w-full px-4 py-3 rounded-xl text-sm text-gray-700 hover:bg-green-50/80 hover:text-green-700 color-transition group disabled:opacity-50 disabled:cursor-not-allowed border border-transparent hover:border-green-200/50"
                            >
                              <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-green-100 to-green-200 flex items-center justify-center mr-3 group-hover:from-green-200 group-hover:to-green-300 transition-all duration-200">
                                <svg class="w-4 h-4 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                              </div>
                              <div class="flex-1 text-left">
                                <span class="font-medium">Terima Booking</span>
                                <p class="text-xs text-gray-500 mt-0.5">Konfirmasi booking pasien</p>
                              </div>
                            </button>
                            
                            <button 
                              @click="registerPatient(booking); closeDropdown()"
                              :disabled="isRegisteringPatient"
                              class="action-button flex items-center w-full px-4 py-3 rounded-xl text-sm text-gray-700 hover:bg-purple-50/80 hover:text-purple-700 color-transition group disabled:opacity-50 disabled:cursor-not-allowed border border-transparent hover:border-purple-200/50"
                            >
                              <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-purple-100 to-purple-200 flex items-center justify-center mr-3 group-hover:from-purple-200 group-hover:to-purple-300 transition-all duration-200">
                                <svg class="w-4 h-4 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0z"/>
                                </svg>
                              </div>
                              <div class="flex-1 text-left">
                                <span class="font-medium">Daftarkan ke SIMRS</span>
                                <p class="text-xs text-gray-500 mt-0.5">Registrasi pasien ke sistem</p>
                              </div>
                            </button>
                            
                            <button 
                              @click="transferToRegPeriksa(booking); closeDropdown()"
                              :disabled="isTransferring || booking.status !== 'Diterima'"
                              class="action-button flex items-center w-full px-4 py-3 rounded-xl text-sm text-gray-700 hover:bg-indigo-50/80 hover:text-indigo-700 color-transition group disabled:opacity-50 disabled:cursor-not-allowed border border-transparent hover:border-indigo-200/50"
                            >
                              <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-indigo-100 to-indigo-200 flex items-center justify-center mr-3 group-hover:from-indigo-200 group-hover:to-indigo-300 transition-all duration-200">
                                <svg class="w-4 h-4 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"/>
                                </svg>
                              </div>
                              <div class="flex-1 text-left">
                                <span class="font-medium">Transfer ke Reg Periksa</span>
                                <p class="text-xs text-gray-500 mt-0.5">Pindah ke registrasi periksa</p>
                              </div>
                            </button>
                          </div>
                        </div>
                      </div>
                    </div>
                  </Transition>
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
              <label class="block text-sm font-medium text-gray-700 mb-2">Tanggal & Waktu Janji</label>
              <input v-model="bookingForm.appointment_datetime" type="datetime-local" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
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

    <!-- Patient Registration Modal -->
    <div v-if="showRegistrationModal" class="fixed inset-0 z-50 overflow-y-auto">
      <div class="flex items-center justify-center min-h-screen px-4">
        <div class="fixed inset-0 bg-gray-600 bg-opacity-75" @click="closeRegistrationModal"></div>
        <div class="bg-white rounded-2xl p-6 w-full max-w-2xl relative max-h-[90vh] overflow-y-auto">
          <h3 class="text-lg font-semibold text-gray-900 mb-4 flex items-center">
            <svg class="w-5 h-5 mr-2 text-rose-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0z"/>
            </svg>
            Daftarkan Pasien ke SIMRS
          </h3>
          
          <!-- Booking Info -->
          <div class="bg-rose-50 rounded-xl p-4 mb-6">
            <h4 class="font-medium text-gray-900 mb-2">Data Booking</h4>
            <div class="grid grid-cols-2 gap-4 text-sm">
              <div>
                <span class="text-gray-900">No. Booking:</span>
                <span class="text-gray-900 font-medium ml-2">{{ selectedBooking?.no_booking }}</span>
              </div>
              <div>
                <span class="text-gray-600">Nama:</span>
                <span class="text-gray-900 font-medium ml-2">{{ selectedBooking?.nama }}</span>
              </div>
              <div>
                <span class="text-gray-600">NIK:</span>
                <span class="text-gray-900 font-medium ml-2">{{ selectedBooking?.nik }}</span>
              </div>
              <div>
                <span class="text-gray-600">No. Telp:</span>
                <span class="text-gray-900 font-medium ml-2">{{ selectedBooking?.no_telp }}</span>
              </div>
            </div>
          </div>
          
          <form @submit.prevent="submitPatientRegistration" class="space-y-4">
            
            <!-- NIK BPJS Field for Auto-fill (Hidden but functional) -->
            <div v-if="false" class="bg-blue-50 rounded-xl p-4 mb-4">
              <h4 class="font-medium text-gray-900 mb-3">Data BPJS (Opsional)</h4>
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">NIK BPJS</label>
                <div class="relative">
                  <input 
                    v-model="nikBpjs" 
                    @input="handleNikInput"
                    type="text" 
                    maxlength="16"
                    placeholder="Masukkan 16 digit NIK untuk auto-fill data"
                    class="w-full px-3 py-2 border border-blue-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent text-gray-900"
                  >
                  <div v-if="isLoadingNikData" class="absolute right-3 top-3">
                    <svg class="animate-spin h-4 w-4 text-blue-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                      <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                      <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                  </div>
                </div>
                <div v-if="nikError" class="mt-1 text-sm text-red-600">{{ nikError }}</div>
                <div v-if="nikSuccess" class="mt-1 text-sm text-green-600">{{ nikSuccess }}</div>
              </div>
            </div>
            
            <!-- Data Pasien Utama -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Nama Lengkap *</label>
                <input 
                  v-model="registrationForm.nm_pasien" 
                  type="text" 
                  required 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
              
              <div v-if="false">
                <label class="block text-sm font-medium text-gray-700 mb-2">Tempat Lahir</label>
                <input 
                  v-model="registrationForm.tmp_lahir" 
                  type="text" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Tanggal Lahir</label>
                <input 
                  v-model="registrationForm.tgl_lahir" 
                  type="date" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Jenis Kelamin</label>
                <select 
                  v-model="registrationForm.jk" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
                  <option value="L">Laki-laki</option>
                  <option value="P">Perempuan</option>
                </select>
              </div>

              <div v-if="false">
                <label class="block text-sm font-medium text-gray-700 mb-2">Nama Ibu</label>
                <input 
                  v-model="registrationForm.nm_ibu" 
                  type="text" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
              
              <div v-if="false">
                <label class="block text-sm font-medium text-gray-700 mb-2">Golongan Darah</label>
                <select 
                  v-model="registrationForm.gol_darah" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
                  <option value="-">Tidak Diketahui</option>
                  <option value="A">A</option>
                  <option value="B">B</option>
                  <option value="AB">AB</option>
                  <option value="O">O</option>
                </select>
              </div>
              
              <div>
                <label class="block text-sm font-medium text-gray-700 mb-2">Pekerjaan</label>
                <input 
                  v-model="registrationForm.pekerjaan" 
                  type="text" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
              </div>
              
              <div v-if="false">
                <label class="block text-sm font-medium text-gray-700 mb-2">Status Nikah</label>
                <select 
                  v-model="registrationForm.stts_nikah" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
                  <option value="BELUM MENIKAH">Belum Menikah</option>
                  <option value="MENIKAH">Menikah</option>
                  <option value="CERAI HIDUP">Cerai Hidup</option>
                  <option value="CERAI MATI">Cerai Mati</option>
                </select>
              </div>
              
              <div v-if="false">
                <label class="block text-sm font-medium text-gray-700 mb-2">Agama</label>
                <select 
                  v-model="registrationForm.agama" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
                  <option value="ISLAM">Islam</option>
                  <option value="KRISTEN">Kristen</option>
                  <option value="KATOLIK">Katolik</option>
                  <option value="HINDU">Hindu</option>
                  <option value="BUDDHA">Buddha</option>
                  <option value="KONGHUCU">Konghucu</option>
                </select>
              </div>
              
              <div v-if="false">
                <label class="block text-sm font-medium text-gray-700 mb-2">Pendidikan</label>
                <select 
                  v-model="registrationForm.pnd" 
                  class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                >
                  <option value="-">Tidak Diketahui</option>
                  <option value="TS">Tidak Sekolah</option>
                  <option value="TK">TK</option>
                  <option value="SD">SD</option>
                  <option value="SMP">SMP</option>
                  <option value="SMA">SMA</option>
                  <option value="D1">D1</option>
                  <option value="D2">D2</option>
                  <option value="D3">D3</option>
                  <option value="D4">D4</option>
                  <option value="S1">S1</option>
                  <option value="S2">S2</option>
                  <option value="S3">S3</option>
                </select>
              </div>
            </div>
            
            <!-- Alamat -->
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Alamat Lengkap</label>
              <textarea 
                v-model="registrationForm.alamat" 
                rows="3" 
                class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
              ></textarea>
            </div>
            
            <!-- Data Penanggung Jawab -->
            <div v-if="false" class="border-t pt-4">
              <h4 class="font-medium text-gray-900 mb-4">Data Penanggung Jawab</h4>
              <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-2">Hubungan Keluarga</label>
                  <select 
                    v-model="registrationForm.keluarga" 
                    class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                  >
                    <option value="AYAH">Ayah</option>
                    <option value="IBU">Ibu</option>
                    <option value="SUAMI">Suami</option>
                    <option value="ISTRI">Istri</option>
                    <option value="ANAK">Anak</option>
                    <option value="SAUDARA">Saudara</option>
                    <option value="LAINNYA">Lainnya</option>
                  </select>
                </div>
                
                <div>
                  <label class="block text-sm font-medium text-gray-700 mb-2">Nama Penanggung Jawab</label>
                  <input 
                    v-model="registrationForm.namakeluarga" 
                    type="text" 
                    class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900"
                  >
                </div>
              </div>
            </div>
            
            <div class="flex justify-end space-x-3 pt-6 border-t">
              <button 
                type="button" 
                @click="closeRegistrationModal" 
                class="px-6 py-2 text-gray-600 hover:text-gray-800 border border-gray-300 rounded-xl hover:bg-gray-50 transition-colors"
              >
                Batal
              </button>
              <button 
                type="submit" 
                :disabled="isRegisteringPatient"
                class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-2 rounded-xl hover:from-rose-600 hover:to-pink-600 transition-all disabled:opacity-50 disabled:cursor-not-allowed flex items-center"
              >
                <svg v-if="isRegisteringPatient" class="animate-spin -ml-1 mr-2 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                {{ isRegisteringPatient ? 'Mendaftarkan...' : 'Daftarkan ke SIMRS' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
    </div>

    <!-- Registration Success Modal -->
    <RegistrationSuccessModal 
      :is-visible="showSuccessModal"
      :patient-data="successPatientData"
      @ok="handleSuccessModalOk"
      @close="showSuccessModal = false"
    />
  </AdminLayout>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'
import { useSweetAlert } from '@/composables/useSweetAlert'
import RegistrationSuccessModal from '@/components/RegistrationSuccessModal.vue'


interface Props {
  bookings: {
    data: Array<{
      no_booking: string
      nama: string
      no_telp: string
      tanggal: string
      status: string
      nik?: string
      poliklinik?: {
        nm_poli: string
      }
      dokter?: {
        nm_dokter: string
      }
      catatan?: string
    }>
    current_page: number
    last_page: number
    per_page: number
    total: number
  }
}

const props = defineProps<Props>()


const showFilters = ref(false)
const showModal = ref(false)
const showRegistrationModal = ref(false)
const showSuccessModal = ref(false)
const successPatientData = ref({
  no_rkm_medis: '',
  nama: '',
  no_telp: '',
  alamat: ''
})
const editingBooking = ref(null)
const selectedBooking = ref(null)
const searchQuery = ref('')
const currentPage = ref(props.bookings.current_page)
const itemsPerPage = ref(props.bookings.per_page)
const isRegisteringPatient = ref(false)
const isTransferring = ref(false)
const isAccepting = ref(false)


const dropdownOpen = ref(null)


const bookingsData = ref(props.bookings)


const nikBpjs = ref('')
const isLoadingNikData = ref(false)
const nikError = ref('')
const nikSuccess = ref('')
let nikTimeout: NodeJS.Timeout | null = null


const { showSuccess, showError, showWarning, showConfirmation, showDeleteConfirmation, showToast } = useSweetAlert()


onMounted(() => {
  console.log('Bookings component mounted')
})


const filters = ref({
  status: '',
  startDate: '',
  endDate: '',
  doctor: ''
})


const bookingForm = ref({
  patient_name: '',
  patient_phone: '',
  appointment_datetime: '',
  doctor: '',
  status: 'Belum Dibalas',
  notes: ''
})


const registrationForm = ref({
  nm_pasien: '',
  tmp_lahir: '',
  tgl_lahir: '',
  jk: 'L',
  nm_ibu: '',
  gol_darah: '-',
  pekerjaan: '',
  stts_nikah: 'BELUM MENIKAH',
  agama: 'ISLAM',
  pnd: '-',
  alamat: '',
  keluarga: 'AYAH',
  namakeluarga: ''
})


const registerPatient = (booking) => {
  selectedBooking.value = booking
  
  
  registrationForm.value = {
    nm_pasien: booking.nama || '',
    tmp_lahir: '',
    tgl_lahir: '',
    jk: 'L',
    nm_ibu: '',
    gol_darah: '-',
    pekerjaan: '',
    stts_nikah: 'BELUM MENIKAH',
    agama: 'ISLAM',
    pnd: '-',
    alamat: booking.alamat || '', 
    keluarga: 'AYAH',
    namakeluarga: ''
  }
  
  
  fillAddressFromBooking()
  
  
  autoFillNikFromBooking()
  
  showRegistrationModal.value = true
}

const closeRegistrationModal = () => {
  showRegistrationModal.value = false
  selectedBooking.value = null
  registrationForm.value = {
    nm_pasien: '',
    tmp_lahir: '',
    tgl_lahir: '',
    jk: 'L',
    nm_ibu: '',
    gol_darah: '-',
    pekerjaan: '',
    stts_nikah: 'BELUM MENIKAH',
    agama: 'ISLAM',
    pnd: '-',
    alamat: '',
    keluarga: 'AYAH',
    namakeluarga: ''
  }
}

const handleSuccessModalOk = () => {
  showSuccessModal.value = false
  
  refreshBookings()
}

const submitPatientRegistration = async () => {
  if (isRegisteringPatient.value || !selectedBooking.value) return
  
  try {
    isRegisteringPatient.value = true
    
    const response = await fetch(`/api/booking/register-patient/${selectedBooking.value.no_booking}`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      },
      body: JSON.stringify(registrationForm.value)
    })
    
    const result = await response.json()
    
    if (response.ok) {
      console.log('Registration API Response:', result)
      if (result.success === false && result.patient) {
        
        showWarning(
          'Pasien Sudah Terdaftar',
          `Pasien ${selectedBooking.value.nama} sudah terdaftar di SIMRS dengan No. RM: ${result.patient.no_rkm_medis}`
        )
        
        
        const bookingIndex = bookingsData.value.data.findIndex(b => b.no_booking === selectedBooking.value.no_booking)
        if (bookingIndex !== -1) {
          bookingsData.value.data[bookingIndex].status = 'Terdaftar'
        }
      } else if (result.success === true && result.patient) {
        console.log('Setting up success modal with patient data:', result.patient)
        
        
        const bookingIndex = bookingsData.value.data.findIndex(b => b.no_booking === selectedBooking.value.no_booking)
        if (bookingIndex !== -1) {
          bookingsData.value.data[bookingIndex].status = 'Terdaftar'
        }
        
        
        successPatientData.value = {
          no_rkm_medis: result.patient.no_rkm_medis,
          nama: result.patient.nama,
          no_telp: result.patient.no_tlp || selectedBooking.value.no_telp,
          alamat: result.patient.alamat
        }
        console.log('Success patient data set:', successPatientData.value)
        showSuccessModal.value = true
        console.log('showSuccessModal set to:', showSuccessModal.value)
      }
      closeRegistrationModal()
    } else {
      showError(
        'Gagal Mendaftarkan Pasien',
        result.message || 'Terjadi kesalahan saat mendaftarkan pasien'
      )
    }
  } catch (error) {
    console.error('Error registering patient:', error)
    showError(
      'Kesalahan Sistem',
      'Terjadi kesalahan saat mendaftarkan pasien. Silakan coba lagi.'
    )
  } finally {
    isRegisteringPatient.value = false
  }
}

const closeModal = () => {
  showModal.value = false
  selectedBooking.value = null
  registrationForm.value = {
    nm_pasien: '',
    tmp_lahir: '',
    tgl_lahir: '',
    jk: 'L',
    nm_ibu: '',
    gol_darah: '-',
    pekerjaan: '',
    stts_nikah: 'BELUM MENIKAH',
    agama: 'ISLAM',
    pnd: '-',
    alamat: '',
    keluarga: 'AYAH',
    namakeluarga: ''
  }
}


const filteredBookings = computed(() => {
  let filtered = bookingsData.value.data

  if (searchQuery.value) {
    filtered = filtered.filter(booking => 
      booking.nama.toLowerCase().includes(searchQuery.value.toLowerCase())
    )
  }

  if (filters.value.status) {
    filtered = filtered.filter(booking => booking.status === filters.value.status)
  }

  return filtered
})

const totalItems = computed(() => bookingsData.value.total)
const totalPages = computed(() => bookingsData.value.last_page)

const visiblePages = computed(() => {
  const pages = []
  const start = Math.max(1, currentPage.value - 2)
  const end = Math.min(totalPages.value, currentPage.value + 2)
  
  for (let i = start; i <= end; i++) {
    pages.push(i)
  }
  
  return pages
})


const toggleDropdown = (bookingId) => {
  dropdownOpen.value = dropdownOpen.value === bookingId ? null : bookingId
}

const closeDropdown = () => {
  dropdownOpen.value = null
}

const refreshBookings = async () => {
  try {
    const response = await fetch(`/admin/bookings?page=${currentPage.value}`, {
      headers: {
        'Accept': 'application/json',
        'X-Requested-With': 'XMLHttpRequest'
      }
    })
    
    if (response.ok) {
      const data = await response.json()
      if (data.props && data.props.bookings) {
        bookingsData.value = data.props.bookings
      }
    }
  } catch (error) {
    console.error('Error refreshing bookings:', error)
  }
}

const formatDate = (dateString) => {
  if (!dateString || typeof dateString !== 'string') {
    return { date: 'Tanggal tidak tersedia', time: '—' }
  }

  
  const clean = dateString.replace('T', ' ').replace('Z', '').split('.')[0]

  const m = clean.match(/^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})(?::(\d{2}))?$/)
  if (!m) {
    console.warn('Format tanggal tidak cocok:', dateString)
    return { date: 'Tanggal tidak valid', time: '—' }
  }

  const [_, y, mo, d, h, mi, s] = m.map(Number)
  const date = new Date(y, mo - 1, d, h, mi, s || 0)

  const dateStr = date.toLocaleDateString('id-ID', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })

  const timeStr = date.toLocaleTimeString('id-ID', {
    hour: '2-digit',
    minute: '2-digit'
  }) + ' WITA'

  return { date: dateStr, time: timeStr }
}

const getStatusClass = (status) => {
  const statusClasses = {
    'pending': 'bg-yellow-100 text-yellow-800',
    'confirmed': 'bg-green-100 text-green-800',
    'completed': 'bg-blue-100 text-blue-800',
    'cancelled': 'bg-red-100 text-red-800'
  }
  return statusClasses[status] || 'bg-gray-100 text-gray-800'
}

const getStatusText = (status) => {
  const statusTexts = {
    'pending': 'Menunggu',
    'confirmed': 'Dikonfirmasi',
    'completed': 'Selesai',
    'cancelled': 'Dibatalkan'
  }
  return statusTexts[status] || status
}

const openCreateModal = () => {
  editingBooking.value = null
  bookingForm.value = {
    patient_name: '',
    patient_phone: '',
    appointment_datetime: '',
    doctor: '',
    status: 'pending',
    notes: ''
  }
  showModal.value = true
}

const editBooking = (booking) => {
  editingBooking.value = booking
  bookingForm.value = {
    patient_name: booking.nama,
    patient_phone: booking.no_telp,
    appointment_datetime: booking.tanggal,
    doctor: booking.dokter?.nm_dokter || '',
    status: booking.status,
    notes: booking.catatan || ''
  }
  showModal.value = true
}

const saveBooking = async () => {
  
  console.log('Saving booking:', bookingForm.value)
  closeModal()
}

const deleteBooking = async (booking) => {
  const result = await showDeleteConfirmation(
    'Hapus Booking',
    `Apakah Anda yakin ingin menghapus booking ${booking.nama}?`
  )
  
  if (result.isConfirmed) {
    try {
      
      console.log('Deleting booking:', booking)
      showToast('Booking berhasil dihapus', 'success')
    } catch (error) {
      console.error('Error deleting booking:', error)
      showError('Gagal Menghapus', 'Terjadi kesalahan saat menghapus booking')
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
  
  console.log('Applying filters:', filters.value)
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

const goToPage = (page) => {
  currentPage.value = page
  
}


const handleNikInput = async () => {
  
  if (nikTimeout) {
    clearTimeout(nikTimeout)
  }
  
  
  
  
  
  if (nikBpjs.value.length !== 16) {
    return
  }
  
  
  nikTimeout = setTimeout(async () => {
    await fetchNikData()
  }, 500) 
}


const autoFillNikFromBooking = () => {
  if (selectedBooking.value?.nik) {
    nikBpjs.value = selectedBooking.value.nik
    
    if (selectedBooking.value.nik.length === 16) {
      fetchNikData()
    }
  }
}

const fetchNikData = async () => {
  if (!nikBpjs.value || nikBpjs.value.length !== 16) {
    return
  }
  
  try {
    isLoadingNikData.value = true
    
    
    const response = await fetch('/api/bpjs/check-nik', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      },
      body: JSON.stringify({ nik: nikBpjs.value })
    })
    
    const result = await response.json()
    
    
    if (response.ok && result.metaData && result.metaData.code === '200') {
      const pesertaData = result.response?.peserta
      
      if (pesertaData) {
        let hasAutoFilled = false
        
        
        if (pesertaData.tglLahir) {
          registrationForm.value.tgl_lahir = pesertaData.tglLahir
          hasAutoFilled = true
        }
        
        
        if (pesertaData.nama) {
          registrationForm.value.nm_pasien = pesertaData.nama
          hasAutoFilled = true
        }
        
        
        if (pesertaData.sex) {
          registrationForm.value.jk = pesertaData.sex === 'L' ? 'L' : 'P'
          hasAutoFilled = true
        } else if (pesertaData.jenisKelamin) {
          registrationForm.value.jk = pesertaData.jenisKelamin === 'Laki-laki' ? 'L' : 'P'
          hasAutoFilled = true
        }
        
        
        if (pesertaData.jenisPeserta && pesertaData.jenisPeserta.keterangan) {
          registrationForm.value.pekerjaan = pesertaData.jenisPeserta.keterangan
          hasAutoFilled = true
        }
        
        
        if (pesertaData.nik) {
          registrationForm.value.no_ktp = pesertaData.nik
          hasAutoFilled = true
        }
        
        
        if (pesertaData.noKartu) {
          registrationForm.value.no_peserta = pesertaData.noKartu
          hasAutoFilled = true
        }
        
        
        if (pesertaData.alamat) {
          registrationForm.value.alamat = pesertaData.alamat
          hasAutoFilled = true
        }
        
        
        if (pesertaData.noHP) {
          registrationForm.value.no_tlp = pesertaData.noHP
          hasAutoFilled = true
        }
        
        if (hasAutoFilled) {
          showToast('Data peserta berhasil diambil dari BPJS dan form telah diisi otomatis', 'success')
        } else {
          showToast('Data peserta ditemukan di BPJS', 'info')
        }
      } else {
        showToast('Data peserta ditemukan tetapi informasi tidak lengkap', 'warning')
      }
    } else if (result.metaData && result.metaData.code === '201') {
      showToast(result.metaData.message || 'Data peserta tidak ditemukan di BPJS', 'error')
    } else {
      showToast(result.metaData?.message || 'Gagal mengambil data dari BPJS', 'error')
    }
  } catch (error) {
    console.error('Error fetching NIK data:', error)
    showToast('Terjadi kesalahan saat mengambil data BPJS', 'error')
  } finally {
    isLoadingNikData.value = false
  }
}


const fillAddressFromBooking = () => {
  if (selectedBooking.value?.alamat) {
    registrationForm.value.alamat = selectedBooking.value.alamat
  }
}


const acceptBooking = async (booking) => {
  if (isAccepting.value) return
  
  const result = await showConfirmation(
    'Terima Booking',
    `Apakah Anda yakin ingin menerima booking dari ${booking.nama}?`
  )
  
  if (result.isConfirmed) {
    try {
      isAccepting.value = true
      
      const response = await fetch(`/api/bookings/${booking.no_booking}/accept`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
        }
      })
      
      const result = await response.json()
      
      if (response.ok && result.success) {
        
        const bookingIndex = bookingsData.value.data.findIndex(b => b.no_booking === booking.no_booking)
        if (bookingIndex !== -1) {
          bookingsData.value.data[bookingIndex].status = 'Diterima'
        }
        
        await showSuccess(
          'Booking Diterima!',
          undefined,
          `
            <div class="text-left">
              <p class="mb-3">Booking dari <strong>${booking.nama}</strong> berhasil diterima.</p>
              <div class="bg-green-50 p-4 rounded-lg mb-4">
                <h4 class="font-semibold text-green-800 mb-2">Detail Booking:</h4>
                <p class="text-sm"><strong>No. Booking:</strong> ${booking.no_booking}</p>
                <p class="text-sm"><strong>Nama:</strong> ${booking.nama}</p>
                <p class="text-sm"><strong>Tanggal:</strong> ${new Date(booking.tanggal).toLocaleDateString('id-ID')}</p>
                <p class="text-sm"><strong>Dokter:</strong> ${booking.dokter?.nm_dokter || 'N/A'}</p>
                <p class="text-sm"><strong>Poli:</strong> ${booking.poliklinik?.nm_poli || 'N/A'}</p>
              </div>
              <p class="mb-4 text-sm text-gray-600">Notifikasi telah dikirim ke pasien melalui WhatsApp.</p>
            </div>
          `
        )
        
        
      } else {
        await showError(
          'Gagal Menerima Booking',
          result.message || 'Terjadi kesalahan saat menerima booking'
        )
      }
    } catch (error) {
      console.error('Error accepting booking:', error)
      await showError(
        'Kesalahan Sistem',
        'Terjadi kesalahan saat menerima booking. Silakan coba lagi.'
      )
    } finally {
      isAccepting.value = false
    }
  }
}


const transferToRegPeriksa = async (booking) => {
  if (isTransferring.value) return
  
  const result = await showConfirmation(
    'Daftarkan pasien ke PendaSIMRS',
    `Apakah Anda yakin ingin mentransfer booking ${booking.nama} ke Reg Periksa?`
  )
  
  if (result.isConfirmed) {
    try {
      isTransferring.value = true
      
      console.log('Starting transfer for booking:', booking.no_booking)
      
      const response = await fetch(`/api/reg-periksa/transfer/${booking.no_booking}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
        }
      })
      
      console.log('Raw response:', {
        status: response.status,
        statusText: response.statusText,
        ok: response.ok,
        headers: Object.fromEntries(response.headers.entries())
      })
      
      
      const contentType = response.headers.get('content-type')
      console.log('Content-Type:', contentType)
      
      if (!contentType || !contentType.includes('application/json')) {
        const textResponse = await response.text()
        console.error('Non-JSON response:', textResponse)
        throw new Error('Server returned non-JSON response: ' + textResponse.substring(0, 200))
      }
      
      const result = await response.json()
      
      console.log('Parsed JSON result:', result)
      console.log('Response conditions:', {
        'response.ok': response.ok,
        'result.success': result.success,
        'combined': response.ok && result.success
      })
      
      if (response.ok && result.success) {
        console.log('Success condition met, showing success popup')
        
        
        const bookingIndex = bookingsData.value.data.findIndex(b => b.no_booking === booking.no_booking)
        if (bookingIndex !== -1) {
          bookingsData.value.data[bookingIndex].status = 'Terdaftar'
        }
        
        
        await showSuccess(
          'Transfer Berhasil!',
          undefined,
          `
            <div class="text-left">
              <p class="mb-3">Booking <strong>${booking.nama}</strong> berhasil ditransfer ke Reg Periksa.</p>
              <div class="bg-green-50 p-4 rounded-lg mb-4">
                <h4 class="font-semibold text-green-800 mb-2">Detail Registrasi SIMRS:</h4>
                <p class="text-sm"><strong>No. Rawat:</strong> ${result.data.no_rawat}</p>
                <p class="text-sm"><strong>No. Registrasi:</strong> ${result.data.no_reg}</p>
                <p class="text-sm"><strong>No. RM:</strong> ${result.data.no_rkm_medis}</p>
                <p class="text-sm"><strong>Pasien:</strong> ${result.data.nama_pasien}</p>
                <p class="text-sm"><strong>Tanggal:</strong> ${new Date(result.data.tgl_registrasi).toLocaleDateString('id-ID')}</p>
                <p class="text-sm"><strong>Poli:</strong> ${result.data.poli}</p>
                <p class="text-sm"><strong>Dokter:</strong> ${result.data.dokter}</p>
              </div>
              <p class="mb-4 text-sm text-gray-600">Pasien sudah terdaftar di SIMRS dan siap untuk pemeriksaan.</p>
            </div>
          `
        )
        
        
      } else {
        console.log('Failure condition met, showing error popup')
        console.error('Transfer failed:', {
          responseOk: response.ok,
          resultSuccess: result.success,
          result: result
        })
        showError(
          'Transfer Gagal',
          result.message || 'Terjadi kesalahan saat mentransfer booking'
        )
      }
    } catch (error) {
      console.error('Error transferring booking:', error)
      showError(
        'Kesalahan Sistem',
        'Terjadi kesalahan saat mentransfer booking. Silakan coba lagi.'
      )
    } finally {
      isTransferring.value = false
    }
  }
}


onMounted(() => {
  document.addEventListener('click', closeDropdown)
})

onUnmounted(() => {
  document.removeEventListener('click', closeDropdown)
})
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

/* Dropdown Animations */
.dropdown-enter-active {
  animation: dropdownFadeIn 0.3s ease-out;
}

.dropdown-leave-active {
  animation: dropdownFadeOut 0.2s ease-in;
}

@keyframes dropdownFadeIn {
  from {
    opacity: 0;
    transform: translateY(-8px) scale(0.95);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

@keyframes dropdownFadeOut {
  from {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
  to {
    opacity: 0;
    transform: translateY(-8px) scale(0.95);
  }
}

/* Button Hover Animations */
.action-button {
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
}

.action-button:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

/* Icon Rotation Animation */
.rotate-icon {
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.rotate-icon.rotated {
  transform: rotate(180deg);
}

/* Smooth Color Transitions */
.color-transition {
  transition: color 0.2s ease-in-out, background-color 0.2s ease-in-out;
}

/* Backdrop Blur Effect */
.backdrop-blur {
  backdrop-filter: blur(4px);
  -webkit-backdrop-filter: blur(4px);
}
</style>