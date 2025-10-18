<script setup lang="ts">
interface FloatingElementsProps {
  density?: 'light' | 'medium' | 'heavy';
  theme?: 'pink' | 'rose' | 'mixed';
  animated?: boolean;
}

const props = withDefaults(defineProps<FloatingElementsProps>(), {
  density: 'medium',
  theme: 'mixed',
  animated: true
});

const elementCount = computed(() => {
  switch (props.density) {
    case 'light': return 3;
    case 'medium': return 6;
    case 'heavy': return 9;
    default: return 6;
  }
});

const themeColors = computed(() => {
  switch (props.theme) {
    case 'pink': return ['text-pink-200', 'text-pink-300', 'text-pink-400'];
    case 'rose': return ['text-rose-200', 'text-rose-300', 'text-rose-400'];
    case 'mixed': return ['text-pink-200', 'text-rose-200', 'text-pink-300', 'text-rose-300'];
    default: return ['text-pink-200', 'text-rose-200', 'text-pink-300'];
  }
});

const elements = computed(() => {
  const items = [];
  for (let i = 0; i < elementCount.value; i++) {
    items.push({
      id: i,
      type: ['heart', 'plus', 'circle', 'star'][i % 4],
      color: themeColors.value[i % themeColors.value.length],
      size: ['w-4 h-4', 'w-6 h-6', 'w-8 h-8'][i % 3],
      position: {
        top: `${Math.random() * 80 + 10}%`,
        left: `${Math.random() * 80 + 10}%`
      },
      animation: props.animated ? ['animate-pulse', 'animate-bounce', 'animate-ping'][i % 3] : '',
      delay: `${i * 0.5}s`
    });
  }
  return items;
});
</script>

<template>
  <div class="absolute inset-0 overflow-hidden pointer-events-none">
    <!-- Floating Medical Elements -->
    <div
      v-for="element in elements"
      :key="element.id"
      :class="[
        'absolute opacity-20',
        element.color,
        element.size,
        element.animation
      ]"
      :style="{
        top: element.position.top,
        left: element.position.left,
        animationDelay: element.delay
      }"
    >
      <!-- Heart Shape -->
      <svg v-if="element.type === 'heart'" fill="currentColor" viewBox="0 0 24 24">
        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>
      </svg>

      <!-- Medical Plus -->
      <svg v-else-if="element.type === 'plus'" fill="currentColor" viewBox="0 0 24 24">
        <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm5 11h-4v4h-2v-4H7v-2h4V7h2v4h4v2z"/>
      </svg>

      <!-- Circle -->
      <svg v-else-if="element.type === 'circle'" fill="currentColor" viewBox="0 0 24 24">
        <circle cx="12" cy="12" r="8"/>
      </svg>

      <!-- Star -->
      <svg v-else-if="element.type === 'star'" fill="currentColor" viewBox="0 0 24 24">
        <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
      </svg>
    </div>

    <!-- Gradient Orbs -->
    <div class="absolute -top-40 -right-40 w-80 h-80 bg-gradient-to-br from-pink-200 to-rose-300 rounded-full opacity-20 blur-3xl"></div>
    <div class="absolute -bottom-40 -left-40 w-96 h-96 bg-gradient-to-tr from-rose-200 to-pink-300 rounded-full opacity-15 blur-3xl"></div>
    <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-64 h-64 bg-gradient-to-r from-pink-100 to-rose-200 rounded-full opacity-10 blur-2xl"></div>

    <!-- Floating Particles -->
    <div class="absolute top-10 left-1/4 w-2 h-2 bg-pink-300 rounded-full opacity-30 animate-ping" style="animation-delay: 0s;"></div>
    <div class="absolute top-1/3 right-1/4 w-1 h-1 bg-rose-400 rounded-full opacity-40 animate-pulse" style="animation-delay: 1s;"></div>
    <div class="absolute bottom-1/4 left-1/3 w-3 h-3 bg-pink-200 rounded-full opacity-25 animate-bounce" style="animation-delay: 2s;"></div>
    <div class="absolute bottom-10 right-10 w-2 h-2 bg-rose-300 rounded-full opacity-35 animate-ping" style="animation-delay: 3s;"></div>

    <!-- Decorative Lines -->
    <svg class="absolute top-20 right-20 opacity-10" width="100" height="100" viewBox="0 0 100 100">
      <path d="M10,10 Q50,50 90,10" stroke="currentColor" stroke-width="2" fill="none" class="text-pink-300"/>
      <path d="M10,30 Q50,70 90,30" stroke="currentColor" stroke-width="1" fill="none" class="text-rose-300"/>
    </svg>

    <svg class="absolute bottom-20 left-20 opacity-10" width="80" height="80" viewBox="0 0 80 80">
      <circle cx="40" cy="40" r="30" stroke="currentColor" stroke-width="1" fill="none" class="text-pink-200"/>
      <circle cx="40" cy="40" r="20" stroke="currentColor" stroke-width="1" fill="none" class="text-rose-200"/>
    </svg>
  </div>
</template>

<script lang="ts">
import { computed, withDefaults, defineProps } from 'vue';

export default {
  name: 'FloatingElements'
};
</script>

<style scoped>
/* Custom floating animation */
@keyframes float {
  0%, 100% { 
    transform: translateY(0px) rotate(0deg); 
  }
  50% { 
    transform: translateY(-10px) rotate(5deg); 
  }
}

@keyframes float-reverse {
  0%, 100% { 
    transform: translateY(0px) rotate(0deg); 
  }
  50% { 
    transform: translateY(10px) rotate(-5deg); 
  }
}

.animate-float {
  animation: float 4s ease-in-out infinite;
}

.animate-float-reverse {
  animation: float-reverse 3s ease-in-out infinite;
}

/* Subtle glow effect */
.glow {
  filter: drop-shadow(0 0 8px rgba(236, 72, 153, 0.3));
}
</style>