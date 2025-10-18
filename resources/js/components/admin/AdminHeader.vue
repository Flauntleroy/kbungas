<template>
  <div class="bg-gradient-to-r from-rose-50 via-white to-rose-50 border-b border-rose-100 px-6 py-4">
    <div class="flex items-center justify-between">
      <div class="flex items-center space-x-4">
        <div class="flex items-center space-x-3">
          <div class="w-12 h-12 bg-gradient-to-r from-rose-500 to-pink-600 rounded-2xl flex items-center justify-center shadow-lg shadow-rose-200/50">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
            </svg>
          </div>
          <div>
            <h1 class="text-2xl font-bold text-slate-800 tracking-tight">Klinik Bungas</h1>
            <p class="text-sm text-slate-600 font-medium">Admin Dashboard</p>
          </div>
        </div>
      </div>

      <div class="flex items-center space-x-4">
        <!-- Quick Stats -->
        <div class="hidden lg:flex items-center space-x-6">
          <div class="text-center">
            <div class="text-2xl font-bold text-rose-600">{{ stats.totalBookings }}</div>
            <div class="text-xs text-slate-500 font-medium">Total Booking</div>
          </div>
          <div class="w-px h-8 bg-slate-200"></div>
          <div class="text-center">
            <div class="text-2xl font-bold text-emerald-600">{{ stats.todayBookings }}</div>
            <div class="text-xs text-slate-500 font-medium">Hari Ini</div>
          </div>
          <div class="w-px h-8 bg-slate-200"></div>
          <div class="text-center">
            <div class="text-2xl font-bold text-amber-600">{{ stats.pendingBookings }}</div>
            <div class="text-xs text-slate-500 font-medium">Menunggu</div>
          </div>
        </div>

        <!-- Quick Actions -->
        <div class="flex items-center space-x-2">
          <button class="group p-2.5 text-slate-600 hover:text-rose-600 hover:bg-rose-50 rounded-xl transition-all duration-300 transform hover:scale-110 active:scale-95">
            <svg class="w-5 h-5 transition-transform duration-300 group-hover:rotate-12" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
            </svg>
          </button>
          <button class="group p-2.5 text-slate-600 hover:text-blue-600 hover:bg-blue-50 rounded-xl transition-all duration-300 transform hover:scale-110 active:scale-95">
            <svg class="w-5 h-5 transition-transform duration-300 group-hover:rotate-12" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
            </svg>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

interface Stats {
  totalBookings: number
  todayBookings: number
  pendingBookings: number
}

const stats = ref<Stats>({
  totalBookings: 0,
  todayBookings: 0,
  pendingBookings: 0
})

// Mock data - in real app, this would come from API
onMounted(() => {
  // Simulate loading stats
  setTimeout(() => {
    stats.value = {
      totalBookings: 1247,
      todayBookings: 23,
      pendingBookings: 8
    }
  }, 500)
})
</script>