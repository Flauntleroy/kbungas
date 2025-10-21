<template>
  <AdminLayout>
    <div class="w-full">
      <!-- Stats Cards -->
      <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-6 mb-8">
        <div class="bg-white rounded-2xl p-6 shadow-sm border border-rose-100">
            <div class="flex items-center justify-between">
              <div class="flex-1">
                <p class="text-sm font-medium text-gray-600">Total Booking</p>
                <p class="text-3xl font-bold text-gray-900 mt-1">{{ props.stats.totalBookings }}</p>
                <p class="text-sm text-green-600 mt-2">+12% dari bulan lalu</p>
              </div>
              <div class="w-14 h-14 bg-rose-100 rounded-xl flex items-center justify-center ml-4">
                <svg class="w-7 h-7 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                </svg>
              </div>
            </div>
          </div>

        <div class="bg-white rounded-2xl p-6 shadow-sm border border-rose-100">
          <div class="flex items-center justify-between">
            <div class="flex-1">
              <p class="text-sm font-medium text-gray-600">Booking Hari Ini</p>
              <p class="text-3xl font-bold text-gray-900 mt-1">{{ props.stats.todayBookings }}</p>
              <p class="text-sm text-blue-600 mt-2">{{ props.stats.pendingBookings }} menunggu konfirmasi</p>
            </div>
            <div class="w-14 h-14 bg-blue-100 rounded-xl flex items-center justify-center ml-4">
              <svg class="w-7 h-7 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-2xl p-6 shadow-sm border border-rose-100">
          <div class="flex items-center justify-between">
            <div class="flex-1">
              <p class="text-sm font-medium text-gray-600">Total Pasien</p>
              <p class="text-3xl font-bold text-gray-900 mt-1">{{ props.stats.totalPatients }}</p>
              <p class="text-sm text-purple-600 mt-2">{{ props.stats.newPatients }} pasien baru</p>
            </div>
            <div class="w-14 h-14 bg-purple-100 rounded-xl flex items-center justify-center ml-4">
              <svg class="w-7 h-7 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
              </svg>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-2xl p-6 shadow-sm border border-rose-100">
          <div class="flex items-center justify-between">
            <div class="flex-1">
              <p class="text-sm font-medium text-gray-600">Rating Rata-rata</p>
              <p class="text-3xl font-bold text-gray-900 mt-1">{{ props.stats.averageRating }}</p>
              <div class="flex items-center mt-2">
                <div class="flex text-yellow-400">
                  <svg v-for="i in 5" :key="i" class="w-4 h-4" :class="i <= Math.floor(props.stats.averageRating) ? 'text-yellow-400' : 'text-gray-300'" fill="currentColor" viewBox="0 0 20 20">
                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
                  </svg>
                </div>
                <span class="text-sm text-gray-500 ml-2">({{ props.stats.totalReviews }} ulasan)</span>
              </div>
            </div>
            <div class="w-14 h-14 bg-yellow-100 rounded-xl flex items-center justify-center ml-4">
              <svg class="w-7 h-7 text-yellow-600" fill="currentColor" viewBox="0 0 20 20">
                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"/>
              </svg>
            </div>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-4 gap-6">
        <!-- Recent Bookings -->
        <div class="lg:col-span-2 xl:col-span-3 bg-white rounded-2xl p-6 shadow-sm border border-rose-100">
          <div class="flex items-center justify-between mb-6">
            <h3 class="text-lg font-semibold text-gray-900">Booking Terbaru</h3>
            <Link href="/admin/bookings" class="text-rose-600 hover:text-rose-700 text-sm font-medium">
              Lihat Semua
            </Link>
          </div>
          
          <div class="space-y-4">
            <div v-for="booking in props.recentBookings" :key="booking.id" class="flex items-center justify-between p-4 bg-gray-50 rounded-xl">
              <div class="flex items-center space-x-4">
                <div class="w-10 h-10 bg-gradient-to-r from-rose-500 to-pink-500 rounded-full flex items-center justify-center">
                  <span class="text-white text-sm font-semibold">{{ booking.patient.name.charAt(0) }}</span>
                </div>
                <div>
                  <p class="font-medium text-gray-900">{{ booking.patient.name }}</p>
                  <p class="text-sm text-gray-500">{{ booking.date }} • {{ booking.time }}</p>
                </div>
              </div>
              <div class="flex items-center space-x-3">
                <span :class="[
                  'px-3 py-1 rounded-full text-xs font-medium',
                  booking.status === 'Diterima' ? 'bg-green-100 text-green-700' :
                  booking.status === 'Belum Dibalas' ? 'bg-yellow-100 text-yellow-700' :
                  'bg-red-100 text-red-700'
                ]">
                  {{ booking.status === 'Diterima' ? 'Dikonfirmasi' : 
                      booking.status === 'Belum Dibalas' ? 'Menunggu' : 'Dibatalkan' }}
                </span>
                <button class="text-gray-400 hover:text-rose-600">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 5v.01M12 12v.01M12 19v.01M12 6a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2zm0 7a1 1 0 110-2 1 1 0 010 2z"/>
                  </svg>
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Quick Actions & Analytics -->
        <div class="lg:col-span-2 xl:col-span-1">
          <div class="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-1 gap-6">
            <!-- Quick Actions -->
            <div class="bg-white rounded-2xl p-6 shadow-sm border border-rose-100">
              <h3 class="text-lg font-semibold text-gray-900 mb-4">Aksi Cepat</h3>
              <div class="space-y-3">
                <Link href="/admin/bookings/create" class="flex items-center p-3 bg-rose-50 hover:bg-rose-100 rounded-xl transition-colors group">
                  <div class="w-8 h-8 bg-rose-500 rounded-lg flex items-center justify-center mr-3">
                    <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                    </svg>
                  </div>
                  <span class="text-sm font-medium text-gray-700 group-hover:text-rose-700">Tambah Booking</span>
                </Link>

                <Link href="/admin/content" class="flex items-center p-3 bg-blue-50 hover:bg-blue-100 rounded-xl transition-colors group">
                  <div class="w-8 h-8 bg-blue-500 rounded-lg flex items-center justify-center mr-3">
                    <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                    </svg>
                  </div>
                  <span class="text-sm font-medium text-gray-700 group-hover:text-blue-700">Edit Konten</span>
                </Link>

                <Link href="/admin/users/create" class="flex items-center p-3 bg-purple-50 hover:bg-purple-100 rounded-xl transition-colors group">
                  <div class="w-8 h-8 bg-purple-500 rounded-lg flex items-center justify-center mr-3">
                    <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"/>
                    </svg>
                  </div>
                  <span class="text-sm font-medium text-gray-700 group-hover:text-purple-700">Tambah User</span>
                </Link>
              </div>
            </div>

            <!-- Monthly Stats -->
            <div class="bg-white rounded-2xl p-6 shadow-sm border border-rose-100">
              <h3 class="text-lg font-semibold text-gray-900 mb-4">Statistik Bulanan</h3>
              <div class="space-y-4">
                <div class="flex items-center justify-between">
                  <span class="text-sm text-gray-600">Booking Selesai</span>
                  <span class="text-sm font-semibold text-green-600">{{ props.monthlyStats.completed }}</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-green-500 h-2 rounded-full" :style="`width: ${(props.monthlyStats.completed / props.monthlyStats.total) * 100}%`"></div>
                </div>

                <div class="flex items-center justify-between">
                  <span class="text-sm text-gray-600">Booking Dibatalkan</span>
                  <span class="text-sm font-semibold text-red-600">{{ props.monthlyStats.cancelled }}</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-red-500 h-2 rounded-full" :style="`width: ${(props.monthlyStats.cancelled / props.monthlyStats.total) * 100}%`"></div>
                </div>

                <div class="flex items-center justify-between">
                  <span class="text-sm text-gray-600">Tingkat Kepuasan</span>
                  <span class="text-sm font-semibold text-yellow-600">{{ props.monthlyStats.satisfaction }}%</span>
                </div>
                <div class="w-full bg-gray-200 rounded-full h-2">
                  <div class="bg-yellow-500 h-2 rounded-full" :style="`width: ${props.monthlyStats.satisfaction}%`"></div>
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
import { Link } from '@inertiajs/vue3'
import AdminLayout from '@/layouts/AdminLayout.vue'


interface Props {
  stats: {
    totalBookings: number
    todayBookings: number
    pendingBookings: number
    totalPatients: number
    newPatients: number
    averageRating: number
    totalReviews: number
  }
  recentBookings: Array<{
    id: string
    patient: {
      name: string
    }
    date: string
    time: string
    status: string
  }>
  monthlyStats: {
    completed: number
    cancelled: number
    total: number
    satisfaction: number
  }
}

const props = defineProps<Props>()
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