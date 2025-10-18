<template>
  <div class="flex h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-100">
    <!-- Mobile menu overlay -->
    <div v-if="sidebarOpen" class="fixed inset-0 z-40 lg:hidden">
      <div class="fixed inset-0 bg-black/50 backdrop-blur-sm" @click="sidebarOpen = false"></div>
    </div>

    <!-- Sidebar -->
    <div :class="[
      'fixed inset-y-0 left-0 z-50 w-72 bg-white/95 backdrop-blur-xl border-r border-slate-200/60 shadow-2xl transform transition-all duration-500 ease-out lg:translate-x-0 lg:static lg:flex lg:flex-col',
      sidebarOpen ? 'translate-x-0' : '-translate-x-full'
    ]">
      <!-- Sidebar Header -->
      <div class="relative flex items-center justify-center h-20 px-6 bg-gradient-to-r from-rose-400 via-pink-500 to-rose-500 flex-shrink-0 overflow-hidden">
        <!-- Background decoration -->
        <div class="absolute inset-0 bg-gradient-to-r from-rose-400/90 via-pink-500/90 to-rose-500/90"></div>
        <div class="absolute -top-4 -right-4 w-24 h-24 bg-white/10 rounded-full blur-xl"></div>
        <div class="absolute -bottom-4 -left-4 w-32 h-32 bg-white/5 rounded-full blur-2xl"></div>
        
        <div class="relative flex items-center space-x-3">
          <div class="w-10 h-10 bg-white/20 backdrop-blur-sm rounded-xl flex items-center justify-center border border-white/30">
            <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"/>
            </svg>
          </div>
          <div>
            <h1 class="text-lg font-bold text-white tracking-tight">Klinik Bungas</h1>
            <p class="text-xs text-white/80 font-medium">Admin Dashboard</p>
          </div>
        </div>
      </div>
      
      <!-- Navigation -->
      <nav class="flex-1 mt-6 px-4 overflow-y-auto scrollbar-thin scrollbar-thumb-slate-300 scrollbar-track-transparent">
        <div class="space-y-1">
          <Link 
            href="/admin/dashboard" 
            :class="[
              'group flex items-center px-4 py-3.5 text-sm font-medium rounded-2xl transition-all duration-300 transform hover:scale-[1.02] active:scale-[0.98]',
              $page.component === 'Admin/Dashboard' 
                ? 'bg-gradient-to-r from-rose-400 to-pink-500 text-white shadow-lg shadow-rose-400/25 border border-rose-300/20' 
                : 'text-slate-700 hover:bg-gradient-to-r hover:from-rose-50 hover:to-pink-50 hover:text-rose-700 hover:shadow-md hover:shadow-rose-100/50'
            ]"
          >
            <div :class="[
              'w-10 h-10 rounded-xl flex items-center justify-center mr-3 transition-all duration-300',
              $page.component === 'Admin/Dashboard' 
                ? 'bg-white/20 backdrop-blur-sm border border-white/30' 
                : 'bg-slate-100 group-hover:bg-rose-100 group-hover:scale-110'
            ]">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2H5a2 2 0 00-2-2z"/>
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 5a2 2 0 012-2h4a2 2 0 012 2v6H8V5z"/>
              </svg>
            </div>
            <span class="font-semibold">Dashboard</span>
            <div class="ml-auto opacity-0 group-hover:opacity-100 transition-opacity duration-300">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
              </svg>
            </div>
          </Link>

          <Link 
            href="/admin/bookings" 
            :class="[
              'group flex items-center px-4 py-3.5 text-sm font-medium rounded-2xl transition-all duration-300 transform hover:scale-[1.02] active:scale-[0.98]',
              $page.component === 'Admin/Bookings' 
                ? 'bg-gradient-to-r from-rose-400 to-pink-500 text-white shadow-lg shadow-rose-400/25 border border-rose-300/20' 
                : 'text-slate-700 hover:bg-gradient-to-r hover:from-rose-50 hover:to-pink-50 hover:text-rose-700 hover:shadow-md hover:shadow-rose-100/50'
            ]"
          >
            <div :class="[
              'w-10 h-10 rounded-xl flex items-center justify-center mr-3 transition-all duration-300',
              $page.component === 'Admin/Bookings' 
                ? 'bg-white/20 backdrop-blur-sm border border-white/30' 
                : 'bg-slate-100 group-hover:bg-rose-100 group-hover:scale-110'
            ]">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
              </svg>
            </div>
            <span class="font-semibold">Manajemen Booking</span>
            <div class="ml-auto opacity-0 group-hover:opacity-100 transition-opacity duration-300">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
              </svg>
            </div>
          </Link>

          <Link 
            href="/admin/content" 
            :class="[
              'group flex items-center px-4 py-3.5 text-sm font-medium rounded-2xl transition-all duration-300 transform hover:scale-[1.02] active:scale-[0.98]',
              $page.component === 'Admin/Content' 
                ? 'bg-gradient-to-r from-rose-400 to-pink-500 text-white shadow-lg shadow-rose-400/25 border border-rose-300/20' 
                : 'text-slate-700 hover:bg-gradient-to-r hover:from-rose-50 hover:to-pink-50 hover:text-rose-700 hover:shadow-md hover:shadow-rose-100/50'
            ]"
          >
            <div :class="[
              'w-10 h-10 rounded-xl flex items-center justify-center mr-3 transition-all duration-300',
              $page.component === 'Admin/Content' 
                ? 'bg-white/20 backdrop-blur-sm border border-white/30' 
                : 'bg-slate-100 group-hover:bg-rose-100 group-hover:scale-110'
            ]">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
              </svg>
            </div>
            <span class="font-semibold">Konten Landing Page</span>
            <div class="ml-auto opacity-0 group-hover:opacity-100 transition-opacity duration-300">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
              </svg>
            </div>
          </Link>

          <Link 
            href="/admin/users" 
            :class="[
              'group flex items-center px-4 py-3.5 text-sm font-medium rounded-2xl transition-all duration-300 transform hover:scale-[1.02] active:scale-[0.98]',
              $page.component === 'Admin/Users' 
                ? 'bg-gradient-to-r from-rose-400 to-pink-500 text-white shadow-lg shadow-rose-400/25 border border-rose-300/20' 
                : 'text-slate-700 hover:bg-gradient-to-r hover:from-rose-50 hover:to-pink-50 hover:text-rose-700 hover:shadow-md hover:shadow-rose-100/50'
            ]"
          >
            <div :class="[
              'w-10 h-10 rounded-xl flex items-center justify-center mr-3 transition-all duration-300',
              $page.component === 'Admin/Users' 
                ? 'bg-white/20 backdrop-blur-sm border border-white/30' 
                : 'bg-slate-100 group-hover:bg-rose-100 group-hover:scale-110'
            ]">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"/>
              </svg>
            </div>
            <span class="font-semibold">Manajemen Users</span>
            <div class="ml-auto opacity-0 group-hover:opacity-100 transition-opacity duration-300">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"/>
              </svg>
            </div>
          </Link>
        </div>

        <!-- Bottom section -->
        <div class="mt-8 pt-6 border-t border-slate-200/60">
          <Link 
            href="/klinik" 
            class="group flex items-center px-4 py-3.5 text-sm font-medium text-slate-600 hover:bg-gradient-to-r hover:from-rose-50 hover:to-pink-50 hover:text-rose-700 rounded-2xl transition-all duration-300 transform hover:scale-[1.02] active:scale-[0.98] hover:shadow-md hover:shadow-rose-100/50"
          >
            <div class="w-10 h-10 rounded-xl bg-slate-100 group-hover:bg-rose-100 flex items-center justify-center mr-3 transition-all duration-300 group-hover:scale-110">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
              </svg>
            </div>
            <span class="font-semibold">Lihat Website</span>
            <div class="ml-auto opacity-0 group-hover:opacity-100 transition-opacity duration-300">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
              </svg>
            </div>
          </Link>

          <Link 
            href="/logout" 
            method="post" 
            as="button"
            class="group flex items-center w-full px-4 py-3.5 text-sm font-medium text-red-600 hover:bg-gradient-to-r hover:from-red-50 hover:to-rose-50 hover:text-red-700 rounded-2xl transition-all duration-300 mt-2 transform hover:scale-[1.02] active:scale-[0.98] hover:shadow-md hover:shadow-red-100/50"
          >
            <div class="w-10 h-10 rounded-xl bg-red-50 group-hover:bg-red-100 flex items-center justify-center mr-3 transition-all duration-300 group-hover:scale-110">
              <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
              </svg>
            </div>
            <span class="font-semibold">Logout</span>
            <div class="ml-auto opacity-0 group-hover:opacity-100 transition-opacity duration-300">
              <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"/>
              </svg>
            </div>
          </Link>
        </div>
      </nav>
    </div>

    <!-- Main content area -->
    <div class="flex-1 flex flex-col lg:ml-0">
      <!-- Top header -->
      <header class="relative bg-white/80 backdrop-blur-xl border-b border-slate-200/60 shadow-lg shadow-slate-200/20 flex-shrink-0 overflow-hidden">
        <!-- Background decoration -->
        <div class="absolute inset-0 bg-gradient-to-r from-white via-rose-50/30 to-white"></div>
        <div class="absolute top-0 left-0 w-full h-px bg-gradient-to-r from-transparent via-rose-200 to-transparent"></div>
        
        <div class="relative flex items-center justify-between px-6 py-4">
          <div class="flex items-center space-x-4">
            <button 
              @click="sidebarOpen = !sidebarOpen"
              class="lg:hidden group p-3 rounded-2xl text-slate-600 hover:text-rose-600 hover:bg-rose-50 transition-all duration-300 transform hover:scale-110 active:scale-95 hover:shadow-lg hover:shadow-rose-100/50"
            >
              <svg class="w-6 h-6 transition-transform duration-300 group-hover:rotate-180" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
              </svg>
            </button>
            
            <div class="flex items-center space-x-3">
              <div class="w-2 h-8 bg-gradient-to-b from-rose-400 to-pink-500 rounded-full"></div>
              <div>
                <h2 class="text-xl font-bold text-slate-800 tracking-tight">{{ pageTitle }}</h2>
                <p class="text-xs text-slate-500 font-medium">{{ getCurrentTime() }}</p>
              </div>
            </div>
          </div>

          <div class="flex items-center space-x-4">
            <!-- Search -->
            <div class="hidden md:flex items-center space-x-2 bg-slate-100/80 backdrop-blur-sm rounded-2xl px-4 py-2.5 border border-slate-200/60 hover:border-rose-200 transition-all duration-300 hover:shadow-md hover:shadow-rose-200/50">
              <svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
              </svg>
              <input 
                type="text" 
                placeholder="Cari..." 
                class="bg-transparent text-sm text-slate-700 placeholder-slate-400 border-none outline-none w-32 focus:w-48 transition-all duration-300"
              >
            </div>

            <!-- Notifications -->
            <button class="group relative p-3 text-slate-600 hover:text-rose-600 hover:bg-rose-50 rounded-2xl transition-all duration-300 transform hover:scale-110 active:scale-95 hover:shadow-lg hover:shadow-rose-100/50">
              <svg class="w-6 h-6 transition-transform duration-300 group-hover:rotate-12" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-5 5v-5zM10.07 2.82l3.12 3.12M7.05 5.84L3.93 2.72"/>
              </svg>
              <span class="absolute -top-1 -right-1 w-5 h-5 bg-gradient-to-r from-red-500 to-pink-500 text-white text-xs font-bold rounded-full flex items-center justify-center animate-pulse border-2 border-white shadow-lg">3</span>
            </button>

            <!-- Settings -->
            <button class="group p-3 text-slate-600 hover:text-rose-600 hover:bg-rose-50 rounded-2xl transition-all duration-300 transform hover:scale-110 active:scale-95 hover:shadow-lg hover:shadow-rose-100/50">
              <svg class="w-6 h-6 transition-transform duration-300 group-hover:rotate-90" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
              </svg>
            </button>

            <!-- User menu -->
            <div class="flex items-center space-x-3 bg-slate-100/80 backdrop-blur-sm rounded-2xl px-4 py-2.5 border border-slate-200/60 hover:border-rose-200 transition-all duration-300 hover:shadow-md hover:shadow-rose-200/50">
              <div class="relative">
                <div class="w-10 h-10 bg-gradient-to-r from-rose-400 via-pink-500 to-rose-500 rounded-2xl flex items-center justify-center shadow-lg shadow-rose-200/50">
                  <span class="text-white text-sm font-bold">A</span>
                </div>
                <div class="absolute -bottom-1 -right-1 w-4 h-4 bg-emerald-500 border-2 border-white rounded-full"></div>
              </div>
              <div class="hidden sm:block">
                <p class="text-sm font-semibold text-slate-700">Admin</p>
                <p class="text-xs text-slate-500">Administrator</p>
              </div>
              <svg class="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
              </svg>
            </div>
          </div>
        </div>
      </header>

      <!-- Page content -->
      <main class="flex-1 p-6 overflow-y-auto bg-gradient-to-br from-rose-50/30 via-white to-pink-50/20">
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
</script>