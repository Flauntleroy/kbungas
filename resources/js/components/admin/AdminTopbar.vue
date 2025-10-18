<template>
  <header class="bg-white border-b border-gray-100 flex-shrink-0">
    <div class="flex items-center justify-between px-1 py-4">
    <div class="flex items-center h-16 px-auto">
        <div 
          class="lg:hidden h-auto flex items-center px-1 cursor-pointer hover:bg-gray-50 transition-all duration-200 rounded-lg"
          @click="$emit('toggle-sidebar')"
        >
          <img 
            src="/images/RBungas-landscape.png" 
            alt="Klinik Bungas" 
            class="max-h-40 w-auto object-contain"
          >
        </div>

        <div class="hidden lg:block">
          <h2 class="text-xl font-semibold text-gray-900">{{ pageTitle }}</h2>
          <p class="text-sm text-gray-500">{{ getCurrentTime() }}</p>
        </div>
      </div>

      <div class="flex items-center space-x-4">
        <!-- Search -->
        <div class="hidden md:flex items-center bg-gray-50 rounded-lg px-3 py-2 border border-gray-200 focus-within:border-gray-300 transition-colors">
          <svg class="w-4 h-4 text-gray-400 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
          </svg>
          <input 
            type="text" 
            placeholder="Cari..." 
            class="bg-transparent text-sm text-gray-700 placeholder-gray-400 border-none outline-none w-32"
          >
        </div>

        <!-- Notifications -->
        <button class="relative p-2 text-gray-500 hover:text-gray-900 hover:bg-gray-50 rounded-lg transition-all duration-200">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-5 5v-5z"/>
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.07 2.82l3.12 3.12"/>
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7.05 5.84L3.93 2.72"/>
          </svg>
          <span class="absolute -top-1 -right-1 w-4 h-4 bg-red-500 text-white text-xs font-medium rounded-full flex items-center justify-center">3</span>
        </button>

        <!-- User menu -->
        <div class="flex items-center space-x-3 bg-gray-50 rounded-lg px-3 py-2 border border-gray-200">
          <div class="w-8 h-8 bg-gray-900 rounded-lg flex items-center justify-center">
            <span class="text-white text-sm font-medium">A</span>
          </div>
          <div class="hidden sm:block">
            <p class="text-sm font-medium text-gray-900">Admin</p>
            <p class="text-xs text-gray-500">Administrator</p>
          </div>
          <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
          </svg>
        </div>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { usePage } from '@inertiajs/vue3'

const { props } = usePage()

const pageTitle = computed(() => {
  const component = props.value?.ziggy?.location || props.value?.component || ''
  if (component.includes('dashboard') || component.includes('Dashboard')) return 'Dashboard'
  if (component.includes('bookings') || component.includes('Bookings')) return 'Manajemen Booking'
  if (component.includes('content') || component.includes('Content')) return 'Konten Landing Page'
  if (component.includes('users') || component.includes('Users')) return 'Manajemen Users'
  return 'Admin Panel'
})

const getCurrentTime = () => {
  const now = new Date()
  return now.toLocaleString('id-ID', { 
    weekday: 'long', 
    year: 'numeric', 
    month: 'long', 
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

defineEmits<{
  'toggle-sidebar': []
}>()
</script>