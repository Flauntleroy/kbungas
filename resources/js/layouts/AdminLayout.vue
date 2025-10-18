<template>
  <div class="min-h-screen bg-white flex">
    <!-- Mobile menu overlay -->
    <div 
      v-if="sidebarOpen" 
      class="fixed inset-0 z-40 lg:hidden"
      @click="sidebarOpen = false"
    >
      <div class="absolute inset-0 bg-slate-900/20 backdrop-blur-sm"></div>
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
      <main class="flex-1 overflow-auto p-6">
        <slot />
      </main>

      <!-- Footer -->
      <AdminFooter />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import AdminSidebar from '@/Components/Admin/AdminSidebar.vue'
import AdminTopbar from '@/Components/Admin/AdminTopbar.vue'
import AdminFooter from '@/Components/Admin/AdminFooter.vue'

const sidebarOpen = ref(false)
</script>