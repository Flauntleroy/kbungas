<script setup lang="ts">
interface BrandElementsProps {
  type: 'watermark' | 'favicon' | 'decorative' | 'badge';
  size?: 'xs' | 'sm' | 'md' | 'lg';
  opacity?: number;
  position?: 'top-left' | 'top-right' | 'bottom-left' | 'bottom-right' | 'center';
  animated?: boolean;
  theme?: 'light' | 'dark' | 'gradient';
}

const props = withDefaults(defineProps<BrandElementsProps>(), {
  size: 'md',
  opacity: 0.1,
  position: 'bottom-right',
  animated: false,
  theme: 'gradient'
});

const sizeClasses = computed(() => {
  switch (props.size) {
    case 'xs': return 'w-8 h-8';
    case 'sm': return 'w-12 h-12';
    case 'md': return 'w-16 h-16';
    case 'lg': return 'w-24 h-24';
    default: return 'w-16 h-16';
  }
});

const positionClasses = computed(() => {
  switch (props.position) {
    case 'top-left': return 'top-4 left-4';
    case 'top-right': return 'top-4 right-4';
    case 'bottom-left': return 'bottom-4 left-4';
    case 'bottom-right': return 'bottom-4 right-4';
    case 'center': return 'top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2';
    default: return 'bottom-4 right-4';
  }
});

const themeColors = computed(() => {
  switch (props.theme) {
    case 'light':
      return 'text-pink-300';
    case 'dark':
      return 'text-pink-600';
    case 'gradient':
      return 'text-pink-400';
    default:
      return 'text-pink-400';
  }
});
</script>

<template>
  <!-- Watermark -->
  <div 
    v-if="type === 'watermark'" 
    :class="[
      'fixed pointer-events-none z-0',
      positionClasses,
      sizeClasses,
      themeColors,
      animated ? 'animate-float' : ''
    ]"
    :style="{ opacity: opacity }"
  >
    <svg fill="currentColor" viewBox="0 0 24 24" class="w-full h-full">
      <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
      <rect x="10.5" y="6" width="3" height="12" rx="1.5" fill="rgba(255,255,255,0.7)"/>
      <rect x="6" y="10.5" width="12" height="3" rx="1.5" fill="rgba(255,255,255,0.7)"/>
    </svg>
  </div>

  <!-- Favicon/Small Icon -->
  <div 
    v-else-if="type === 'favicon'" 
    :class="[
      'inline-flex items-center justify-center rounded-lg',
      sizeClasses,
      'bg-gradient-to-br from-pink-500 to-rose-600 shadow-lg'
    ]"
  >
    <svg class="w-3/5 h-3/5 text-white" fill="currentColor" viewBox="0 0 24 24">
      <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
      <rect x="10.5" y="6" width="3" height="12" rx="1.5" fill="rgba(255,255,255,0.9)"/>
      <rect x="6" y="10.5" width="12" height="3" rx="1.5" fill="rgba(255,255,255,0.9)"/>
    </svg>
  </div>

  <!-- Decorative Element -->
  <div 
    v-else-if="type === 'decorative'" 
    :class="[
      'absolute pointer-events-none',
      positionClasses,
      animated ? 'animate-pulse' : ''
    ]"
    :style="{ opacity: opacity }"
  >
    <!-- Decorative pattern with medical theme -->
    <div class="relative">
      <!-- Main heart -->
      <svg 
        :class="[sizeClasses, themeColors]" 
        fill="currentColor" 
        viewBox="0 0 24 24"
      >
        <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
      </svg>
      
      <!-- Floating particles -->
      <div 
        v-if="animated"
        class="absolute -top-2 -right-2 w-2 h-2 bg-pink-300 rounded-full animate-bounce"
        style="animation-delay: 0.5s"
      ></div>
      <div 
        v-if="animated"
        class="absolute -bottom-1 -left-1 w-1.5 h-1.5 bg-rose-300 rounded-full animate-bounce"
        style="animation-delay: 1s"
      ></div>
    </div>
  </div>

  <!-- Badge -->
  <div 
    v-else-if="type === 'badge'" 
    :class="[
      'inline-flex items-center px-3 py-1 rounded-full text-xs font-medium',
      'bg-gradient-to-r from-pink-100 to-rose-100 text-pink-800 border border-pink-200',
      animated ? 'animate-fade-in' : ''
    ]"
  >
    <svg class="w-3 h-3 mr-1.5" fill="currentColor" viewBox="0 0 24 24">
      <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
    </svg>
    Trusted Healthcare
  </div>
</template>

<script lang="ts">
import { computed, withDefaults, defineProps } from 'vue';

export default {
  name: 'BrandElements'
};
</script>

<style scoped>
/* Custom animations for brand elements */
@keyframes float {
  0%, 100% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-10px);
  }
}

.animate-float {
  animation: float 3s ease-in-out infinite;
}

/* Subtle glow effect */
.glow {
  filter: drop-shadow(0 0 8px rgba(236, 72, 153, 0.3));
}

/* Breathing animation */
@keyframes breathe {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.05);
  }
}

.animate-breathe {
  animation: breathe 4s ease-in-out infinite;
}
</style>