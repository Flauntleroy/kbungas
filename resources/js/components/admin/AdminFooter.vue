<template>
  <footer class="bg-white border-t border-gray-200 mt-auto">
    <div class="px-6 py-3">
      <div class="flex flex-col md:flex-row items-center justify-between space-y-2 md:space-y-0">
        <!-- Left side - Copyright -->
        <div class="flex items-center space-x-4 text-sm text-gray-500">
          <span>© {{ currentYear }} Klinik Bungas. All rights reserved.</span>
          <span class="hidden md:inline">Version {{ version }}</span>
        </div>

        <!-- Right side - Status -->
        <div class="flex items-center space-x-2 text-sm text-gray-500">
          <div class="flex items-center space-x-1">
            <div class="w-2 h-2 bg-green-500 rounded-full"></div>
            <span>System Online</span>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

const currentYear = new Date().getFullYear()
const version = ref('1.0.0')
const lastUpdated = ref('')

const updateLastUpdated = () => {
  const now = new Date()
  lastUpdated.value = now.toLocaleTimeString('id-ID', {
    hour: '2-digit',
    minute: '2-digit'
  })
}

onMounted(() => {
  updateLastUpdated()
  // Update time every minute
  setInterval(updateLastUpdated, 60000)
})
</script>