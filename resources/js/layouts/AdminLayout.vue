<template>
  <div class="min-h-screen bg-gradient-to-br from-rose-50 to-pink-50">
    <!-- Mobile menu overlay -->
    <div v-if="sidebarOpen" class="fixed inset-0 z-40 lg:hidden">
      <div class="fixed inset-0 bg-gray-600 bg-opacity-75" @click="sidebarOpen = false"></div>
    </div>

    <!-- Sidebar -->
    <div :class="[
      'fixed inset-y-0 left-0 z-50 w-64 bg-white shadow-xl transform transition-transform duration-300 ease-in-out lg:translate-x-0 lg:static lg:inset-0',
      sidebarOpen ? 'translate-x-0' : '-translate-x-full'
    ]">
      <div class="flex items-center justify-center h-16 px-4 bg-gradient-to-r from-rose-500 to-pink-500">
        <h1 class="text-xl font-bold text-white">Admin Klinik Bungas</h1>
      </div>
      
      <nav class="mt-8 px-4">
        <div class="space-y-2">
          <Link 
            href="/admin/dashboard" 
            :class="[
              'flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200',
              $page.component === 'Admin/Dashboard' 
                ? 'bg-rose-100 text-rose-700 border-l-4 border-rose-500' 
                : 'text-gray-600 hover:bg-rose-50 hover:text-rose-600'
            ]"
          >
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2z"/>
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 5a2 2 0 012-2h4a2 2 0 012 2v6H8V5z"/>
            </svg>
            Dashboard
          </Link>

          <Link 
            href="/admin/bookings" 
            :class="[
              'flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200',
              $page.component === 'Admin/Bookings' 
                ? 'bg-rose-100 text-rose-700 border-l-4 border-rose-500' 
                : 'text-gray-600 hover:bg-rose-50 hover:text-rose-600'
            ]"
          >
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
            </svg>
            Manajemen Booking
          </Link>

          <Link 
            href="/admin/content" 
            :class="[
              'flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200',
              $page.component === 'Admin/Content' 
                ? 'bg-rose-100 text-rose-700 border-l-4 border-rose-500' 
                : 'text-gray-600 hover:bg-rose-50 hover:text-rose-600'
            ]"
          >
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
            </svg>
            Konten Landing Page
          </Link>

          <Link 
            href="/admin/users" 
            :class="[
              'flex items-center px-4 py-3 text-sm font-medium rounded-xl transition-all duration-200',
              $page.component === 'Admin/Users' 
                ? 'bg-rose-100 text-rose-700 border-l-4 border-rose-500' 
                : 'text-gray-600 hover:bg-rose-50 hover:text-rose-600'
            ]"
          >
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
            </svg>
            Manajemen Users
          </Link>
        </div>

        <div class="mt-8 pt-8 border-t border-rose-100">
          <Link 
            href="/klinik" 
            class="flex items-center px-4 py-3 text-sm font-medium text-gray-600 hover:bg-rose-50 hover:text-rose-600 rounded-xl transition-all duration-200"
          >
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
            </svg>
            Lihat Website
          </Link>

          <Link 
            href="/logout" 
            method="post" 
            class="flex items-center px-4 py-3 text-sm font-medium text-gray-600 hover:bg-red-50 hover:text-red-600 rounded-xl transition-all duration-200"
          >
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
            </svg>
            Logout
          </Link>
        </div>
      </nav>
    </div>

    <!-- Main content -->
    <div class="lg:pl-64">
      <!-- Top header -->
      <header class="bg-white shadow-sm border-b border-rose-100">
        <div class="flex items-center justify-between px-4 py-4">
          <div class="flex items-center">
            <button 
              @click="sidebarOpen = !sidebarOpen"
              class="lg:hidden p-2 rounded-md text-gray-600 hover:text-rose-600 hover:bg-rose-50 transition-colors"
            >
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
              </svg>
            </button>
            <h2 class="ml-4 text-xl font-semibold text-gray-800">{{ pageTitle }}</h2>
          </div>

          <div class="flex items-center space-x-4">
            <!-- Notifications -->
            <button class="p-2 text-gray-600 hover:text-rose-600 hover:bg-rose-50 rounded-xl transition-colors relative">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-5 5v-5zM10.07 2.82l3.12 3.12M7.05 5.84L3.93 2.72"/>
              </svg>
              <span class="absolute -top-1 -right-1 w-3 h-3 bg-rose-500 rounded-full"></span>
            </button>

            <!-- User menu -->
            <div class="flex items-center space-x-3">
              <div class="w-8 h-8 bg-gradient-to-r from-rose-500 to-pink-500 rounded-full flex items-center justify-center">
                <span class="text-white text-sm font-semibold">A</span>
              </div>
              <span class="text-sm font-medium text-gray-700">Admin</span>
            </div>
          </div>
        </div>
      </header>

      <!-- Page content -->
      <main class="p-6">
        <slot />
      </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { Link, usePage } from '@inertiajs/vue3'

const sidebarOpen = ref(false)
const { props } = usePage()

const pageTitle = computed(() => {
  const component = props.value.ziggy?.location || ''
  if (component.includes('dashboard')) return 'Dashboard'
  if (component.includes('bookings')) return 'Manajemen Booking'
  if (component.includes('content')) return 'Konten Landing Page'
  if (component.includes('users')) return 'Manajemen Users'
  return 'Admin Panel'
})
</script>