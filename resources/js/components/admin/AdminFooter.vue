<template>
  <footer class="bg-white border-t border-gray-100 mt-auto">
    <div class="px-8 py-4">
      <div class="flex items-center justify-between text-sm text-gray-500">
        <!-- Left side - Copyright -->
        <span>© {{ currentYear }} Klinik Bungas</span>

        <!-- Right side - Status -->
        <div class="flex items-center space-x-4">
          <div class="flex items-center space-x-2">
            <div class="w-2 h-2 bg-green-500 rounded-full"></div>
            <span>Online</span>
          </div>
          <div class="flex items-center space-x-2">
            <svg class="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
            <span>{{ serverTime }}</span>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

const currentYear = new Date().getFullYear()
const serverTime = ref('')
let timeInterval: NodeJS.Timeout | null = null

const updateServerTime = () => {
  const now = new Date()
  serverTime.value = now.toLocaleString('id-ID', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    timeZone: 'Asia/Jakarta'
  })
}

onMounted(() => {
  updateServerTime()
  timeInterval = setInterval(updateServerTime, 1000)
})

onUnmounted(() => {
  if (timeInterval) {
    clearInterval(timeInterval)
  }
})
</script>