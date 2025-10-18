<template>
  <div :class="[
    'fixed inset-y-0 left-0 z-50 w-64 bg-white border-r border-gray-100 transform transition-transform duration-300 lg:translate-x-0 lg:static lg:flex lg:flex-col',
    sidebarOpen ? 'translate-x-0' : '-translate-x-full'
  ]">
    <!-- Sidebar Header -->
    <div class="flex items-center h-16 px-0 border-b border-gray-100 flex-shrink-0 justify-start">
      <img 
        src="/images/RBungas-landscape.png" 
        alt="Klinik Bungas" 
        class="max-h-50 w-auto object-contain mt-2"
      >
    </div>
    
    <!-- Navigation -->
    <nav class="flex-1 px-4 py-6 overflow-y-auto">
      <!-- Menu Utama Title -->
      <div class="mb-6">
        <h3 class="px-4 text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
          Menu Utama
        </h3>
      </div>
      
      <div class="space-y-1">
        <Link 
          href="/admin/dashboard" 
          class="flex items-center px-4 py-3 text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-lg transition-all duration-200 group"
          :class="{ 'bg-gray-100 text-gray-900': $page.component === 'Admin/Dashboard' }"
        >
          <svg class="w-5 h-5 mr-3 transition-transform duration-200 group-hover:scale-110" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2z"/>
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 5a2 2 0 012-2h2a2 2 0 012 2v0M8 5a2 2 0 012-2h2a2 2 0 012 2v0"/>
          </svg>
          <span class="font-medium">Dashboard</span>
        </Link>

        <Link 
          href="/admin/patients" 
          class="flex items-center px-4 py-3 text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-lg transition-all duration-200 group"
          :class="{ 'bg-gray-100 text-gray-900': $page.component.startsWith('Admin/Patient') }"
        >
          <svg class="w-5 h-5 mr-3 transition-transform duration-200 group-hover:scale-110" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
          </svg>
          <span class="font-medium">Data Pasien</span>
        </Link>

        <Link 
          href="/admin/examinations" 
          class="flex items-center px-4 py-3 text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-lg transition-all duration-200 group"
          :class="{ 'bg-gray-100 text-gray-900': $page.component.startsWith('Admin/Examination') }"
        >
          <svg class="w-5 h-5 mr-3 transition-transform duration-200 group-hover:scale-110" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"/>
          </svg>
          <span class="font-medium">Pemeriksaan</span>
        </Link>

        <Link 
          href="/admin/users" 
          class="flex items-center px-4 py-3 text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-lg transition-all duration-200 group"
          :class="{ 'bg-gray-100 text-gray-900': $page.component.startsWith('Admin/User') }"
        >
          <svg class="w-5 h-5 mr-3 transition-transform duration-200 group-hover:scale-110" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
          </svg>
          <span class="font-medium">Kelola User</span>
        </Link>
      </div>

      <!-- Bottom section -->
      <div class="mt-8 pt-6 border-t border-gray-100">
        <!-- Menu Lainnya Title -->
        <div class="mb-4">
          <h3 class="px-4 text-xs font-semibold text-gray-500 uppercase tracking-wider mb-3">
            Menu Lainnya
          </h3>
        </div>
        
        <div class="space-y-1">
          <Link 
            href="/klinik" 
            class="flex items-center px-4 py-2.5 text-sm font-medium text-gray-700 hover:bg-gray-50 hover:text-gray-900 rounded-lg transition-all duration-200"
          >
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
            </svg>
            <span>Lihat Website</span>
          </Link>

          <Link 
            href="/logout" 
            method="post" 
            as="button"
            class="flex items-center w-full px-4 py-2.5 text-sm font-medium text-red-600 hover:bg-red-50 hover:text-red-700 rounded-lg transition-all duration-200"
          >
            <svg class="w-5 h-5 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
            </svg>
            <span>Logout</span>
          </Link>
        </div>
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