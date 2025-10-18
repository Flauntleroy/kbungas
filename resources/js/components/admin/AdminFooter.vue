<template>
  <footer class="bg-white border-t border-gray-100 mt-auto">
    <div class="px-8 py-4">
      <div class="flex items-center justify-between text-sm text-gray-500">
        <!-- Left side - Copyright -->
        <span>© {{ currentYear }} Klinik Bungas</span>

        <!-- Right side - Status -->
        <div class="flex items-center space-x-2">
          <div class="w-2 h-2 bg-green-500 rounded-full"></div>
          <span>Online</span>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
const currentYear = new Date().getFullYear()
</script>