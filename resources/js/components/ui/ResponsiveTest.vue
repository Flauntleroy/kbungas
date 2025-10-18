<script setup lang="ts">
import { ref, computed } from 'vue';

interface ResponsiveTestProps {
  component?: string;
  showBreakpoints?: boolean;
}

const props = withDefaults(defineProps<ResponsiveTestProps>(), {
  component: 'Login',
  showBreakpoints: true
});

const currentBreakpoint = ref('desktop');
const showGrid = ref(false);

const breakpoints = [
  { name: 'mobile', width: '375px', label: 'Mobile (375px)' },
  { name: 'tablet', width: '768px', label: 'Tablet (768px)' },
  { name: 'laptop', width: '1024px', label: 'Laptop (1024px)' },
  { name: 'desktop', width: '1280px', label: 'Desktop (1280px)' },
  { name: 'wide', width: '1920px', label: 'Wide (1920px)' }
];

const currentWidth = computed(() => {
  const bp = breakpoints.find(bp => bp.name === currentBreakpoint.value);
  return bp ? bp.width : '100%';
});

const setBreakpoint = (breakpoint: string) => {
  currentBreakpoint.value = breakpoint;
};

const toggleGrid = () => {
  showGrid.value = !showGrid.value;
};
</script>

<template>
  <div class="fixed inset-0 bg-gray-900 bg-opacity-50 z-50 flex flex-col">
    <!-- Control Panel -->
    <div class="bg-white shadow-lg p-4 flex items-center justify-between">
      <div class="flex items-center space-x-4">
        <h3 class="text-lg font-semibold text-gray-800">Responsive Test - {{ component }}</h3>
        
        <!-- Breakpoint Buttons -->
        <div class="flex space-x-2">
          <button
            v-for="bp in breakpoints"
            :key="bp.name"
            @click="setBreakpoint(bp.name)"
            :class="[
              'px-3 py-1 text-xs font-medium rounded-md transition-colors',
              currentBreakpoint === bp.name
                ? 'bg-pink-500 text-white'
                : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
            ]"
          >
            {{ bp.label }}
          </button>
        </div>
      </div>

      <div class="flex items-center space-x-4">
        <!-- Grid Toggle -->
        <button
          @click="toggleGrid"
          :class="[
            'px-3 py-2 text-sm font-medium rounded-md transition-colors',
            showGrid
              ? 'bg-blue-500 text-white'
              : 'bg-gray-200 text-gray-700 hover:bg-gray-300'
          ]"
        >
          {{ showGrid ? 'Hide Grid' : 'Show Grid' }}
        </button>

        <!-- Close Button -->
        <button
          @click="$emit('close')"
          class="px-4 py-2 bg-red-500 text-white text-sm font-medium rounded-md hover:bg-red-600 transition-colors"
        >
          Close Test
        </button>
      </div>
    </div>

    <!-- Preview Area -->
    <div class="flex-1 bg-gray-100 p-8 flex items-center justify-center relative">
      <!-- Grid Overlay -->
      <div 
        v-if="showGrid"
        class="absolute inset-0 pointer-events-none z-10"
        style="background-image: linear-gradient(rgba(0,0,0,0.1) 1px, transparent 1px), linear-gradient(90deg, rgba(0,0,0,0.1) 1px, transparent 1px); background-size: 20px 20px;"
      ></div>

      <!-- Device Frame -->
      <div 
        class="bg-white rounded-lg shadow-2xl overflow-hidden transition-all duration-300 ease-in-out"
        :style="{ 
          width: currentWidth, 
          maxWidth: '100%',
          height: currentBreakpoint === 'mobile' ? '667px' : 'auto',
          maxHeight: '90vh'
        }"
      >
        <!-- Device Header (for mobile/tablet) -->
        <div 
          v-if="currentBreakpoint === 'mobile' || currentBreakpoint === 'tablet'"
          class="h-6 bg-gray-800 flex items-center justify-center"
        >
          <div class="w-12 h-1 bg-gray-600 rounded-full"></div>
        </div>

        <!-- Content Area -->
        <div class="h-full overflow-auto">
          <slot></slot>
        </div>
      </div>

      <!-- Breakpoint Info -->
      <div class="absolute bottom-4 right-4 bg-black bg-opacity-75 text-white px-3 py-2 rounded-md text-sm">
        {{ breakpoints.find(bp => bp.name === currentBreakpoint)?.label }}
      </div>
    </div>
  </div>
</template>

<script lang="ts">
export default {
  name: 'ResponsiveTest',
  emits: ['close']
};
</script>

<style scoped>
/* Custom scrollbar for preview area */
.overflow-auto::-webkit-scrollbar {
  width: 6px;
}

.overflow-auto::-webkit-scrollbar-track {
  background: #f1f1f1;
}

.overflow-auto::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 3px;
}

.overflow-auto::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}
</style>