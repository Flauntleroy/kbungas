<template>
  <div class="min-h-screen bg-gray-50 flex">
    <!-- Mobile menu overlay -->
    <div 
      v-if="sidebarOpen" 
      class="fixed inset-0 z-40 lg:hidden"
      @click="sidebarOpen = false"
    >
      <div class="absolute inset-0 bg-gray-900/10 backdrop-blur-sm transition-all duration-300"></div>
    </div>

    <!-- Sidebar -->
    <AdminSidebar 
      :sidebar-open="sidebarOpen"
      @close-sidebar="sidebarOpen = false"
    />

    <!-- Main content -->
    <div class="flex-1 flex flex-col min-w-0">
      <!-- Top navigation bar -->
      <AdminTopbar @toggle-sidebar="sidebarOpen = true" />

      <!-- Main content area -->
      <main class="flex-1 overflow-auto p-4 bg-gray-50">
        <div class="max-w-7xl mx-auto">
          <slot />
        </div>
      </main>

      <!-- Footer -->
      <AdminFooter />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import AdminSidebar from '@/components/admin/AdminSidebar.vue'
import AdminTopbar from '@/components/admin/AdminTopbar.vue'
import AdminFooter from '@/components/admin/AdminFooter.vue'

const sidebarOpen = ref(false)
</script>