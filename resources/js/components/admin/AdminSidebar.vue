<template>
  <div :class="[
    'fixed inset-y-0 left-0 z-50 w-64 bg-white border-r border-gray-200 transform transition-transform duration-300 lg:translate-x-0 lg:static lg:flex lg:flex-col',
    sidebarOpen ? 'translate-x-0' : '-translate-x-full'
  ]">
    <!-- Sidebar Header -->
    <div class="flex items-center justify-center h-16 px-6 bg-rose-500 flex-shrink-0">
      <div class="flex items-center space-x-3">
        <div class="w-8 h-8 bg-white/20 rounded-lg flex items-center justify-center">
          <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
          </svg>
        </div>
        <div>
          <h1 class="text-lg font-semibold text-white">Klinik Bungas</h1>
          <p class="text-xs text-white/80">Admin Dashboard</p>
        </div>
      </div>
    </div>
    
    <!-- Navigation -->
    <nav class="flex-1 mt-6 px-4 overflow-y-auto">
      <div class="space-y-2">
        <Link 
          href="/admin/dashboard" 
          :class="[
            'flex items-center px-3 py-2 text-sm font-medium rounded-lg transition-colors',
            $page.component === 'Admin/Dashboard' 
              ? 'bg-rose-500 text-white' 
              : 'text-gray-700 hover:bg-gray-100 hover:text-rose-600'
          ]"
        >
          <div :class="[
            'w-8 h-8 rounded-lg flex items-center justify-center mr-3',
            $page.component === 'Admin/Dashboard' 
              ? 'bg-white/20' 
              : 'bg-gray-100'
          ]">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2z"/>
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 5a2 2 0 012-2h4a2 2 0 012 2v6H8V5z"/>
            </svg>
          </div>
          <span>Dashboard</span>
        </Link>

        <Link 
          href="/admin/bookings" 
          :class="[
            'flex items-center px-3 py-2 text-sm font-medium rounded-lg transition-colors',
            $page.component === 'Admin/Bookings' 
              ? 'bg-rose-500 text-white' 
              : 'text-gray-700 hover:bg-gray-100 hover:text-rose-600'
          ]"
        >
          <div :class="[
            'w-8 h-8 rounded-lg flex items-center justify-center mr-3',
            $page.component === 'Admin/Bookings' 
              ? 'bg-white/20' 
              : 'bg-gray-100'
          ]">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
            </svg>
          </div>
          <span>Manajemen Booking</span>
        </Link>

        <Link 
          href="/admin/content" 
          :class="[
            'flex items-center px-3 py-2 text-sm font-medium rounded-lg transition-colors',
            $page.component === 'Admin/Content' 
              ? 'bg-rose-500 text-white' 
              : 'text-gray-700 hover:bg-gray-100 hover:text-rose-600'
          ]"
        >
          <div :class="[
            'w-8 h-8 rounded-lg flex items-center justify-center mr-3',
            $page.component === 'Admin/Content' 
              ? 'bg-white/20' 
              : 'bg-gray-100'
          ]">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
            </svg>
          </div>
          <span>Konten Landing Page</span>
        </Link>

        <Link 
          href="/admin/users" 
          :class="[
            'flex items-center px-3 py-2 text-sm font-medium rounded-lg transition-colors',
            $page.component === 'Admin/Users' 
              ? 'bg-rose-500 text-white' 
              : 'text-gray-700 hover:bg-gray-100 hover:text-rose-600'
          ]"
        >
          <div :class="[
            'w-8 h-8 rounded-lg flex items-center justify-center mr-3',
            $page.component === 'Admin/Users' 
              ? 'bg-white/20' 
              : 'bg-gray-100'
          ]">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
            </svg>
          </div>
          <span>Manajemen Users</span>
        </Link>
      </div>

      <!-- Bottom section -->
      <div class="mt-8 pt-6 border-t border-gray-200">
        <Link 
          href="/klinik" 
          class="flex items-center px-3 py-2 text-sm font-medium text-gray-700 hover:bg-gray-100 hover:text-rose-600 rounded-lg transition-colors"
        >
          <div class="w-8 h-8 rounded-lg bg-gray-100 flex items-center justify-center mr-3">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
            </svg>
          </div>
          <span>Lihat Website</span>
        </Link>

        <Link 
          href="/logout" 
          method="post" 
          as="button"
          class="flex items-center w-full px-3 py-2 text-sm font-medium text-red-600 hover:bg-red-50 hover:text-red-700 rounded-lg transition-colors mt-2"
        >
          <div class="w-8 h-8 rounded-lg bg-red-50 flex items-center justify-center mr-3">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
            </svg>
          </div>
          <span>Logout</span>
        </Link>
      </div>
    </nav>
  </div>
</template>

<script setup lang="ts">
import { Link } from '@inertiajs/vue3'

interface Props {
  sidebarOpen: boolean
}

defineProps<Props>()
</script>