<script setup lang="ts">
interface LogoProps {
  size?: 'xs' | 'sm' | 'md' | 'lg' | 'xl' | '2xl';
  variant?: 'full' | 'icon' | 'text';
  theme?: 'light' | 'dark' | 'gradient';
  animated?: boolean;
  clickable?: boolean;
}

const props = withDefaults(defineProps<LogoProps>(), {
  size: 'md',
  variant: 'full',
  theme: 'gradient',
  animated: false,
  clickable: false
});

const emit = defineEmits<{
  click: [event: MouseEvent];
}>();

const sizeClasses = computed(() => {
  switch (props.size) {
    case 'xs': return 'w-6 h-6';
    case 'sm': return 'w-8 h-8';
    case 'md': return 'w-12 h-12';
    case 'lg': return 'w-16 h-16';
    case 'xl': return 'w-20 h-20';
    case '2xl': return 'w-24 h-24';
    default: return 'w-12 h-12';
  }
});

const textSizeClasses = computed(() => {
  switch (props.size) {
    case 'xs': return 'text-xs';
    case 'sm': return 'text-sm';
    case 'md': return 'text-lg';
    case 'lg': return 'text-xl';
    case 'xl': return 'text-2xl';
    case '2xl': return 'text-3xl';
    default: return 'text-lg';
  }
});

const themeClasses = computed(() => {
  switch (props.theme) {
    case 'light':
      return {
        icon: 'text-pink-600',
        text: 'text-gray-800',
        gradient: 'from-pink-500 to-rose-500'
      };
    case 'dark':
      return {
        icon: 'text-pink-400',
        text: 'text-white',
        gradient: 'from-pink-400 to-rose-400'
      };
    case 'gradient':
      return {
        icon: 'text-transparent bg-gradient-to-br from-pink-500 to-rose-600 bg-clip-text',
        text: 'text-transparent bg-gradient-to-r from-pink-600 to-rose-600 bg-clip-text',
        gradient: 'from-pink-500 to-rose-600'
      };
    default:
      return {
        icon: 'text-pink-600',
        text: 'text-gray-800',
        gradient: 'from-pink-500 to-rose-500'
      };
  }
});

const containerClasses = computed(() => {
  const classes = ['inline-flex items-center'];
  
  if (props.clickable) {
    classes.push('cursor-pointer transition-transform duration-200 hover:scale-105');
  }
  
  if (props.animated) {
    classes.push('animate-fade-in-up');
  }
  
  return classes;
});

const handleClick = (event: MouseEvent) => {
  if (props.clickable) {
    emit('click', event);
  }
};
</script>

<template>
  <div :class="containerClasses" @click="handleClick">
    <!-- Icon Only -->
    <template v-if="variant === 'icon'">
      <div 
        :class="[
          sizeClasses,
          'relative flex items-center justify-center'
        ]"
      >
        <!-- RBungas Logo Image -->
        <img 
          src="/images/RBungas.png" 
          alt="Klinik Bungas Logo" 
          class="w-full h-full object-contain"
        />
        
        <!-- Subtle glow effect -->
        <div 
          v-if="animated" 
          class="absolute inset-0 rounded-2xl bg-gradient-to-br from-pink-400 to-rose-500 opacity-20 animate-pulse"
        ></div>
      </div>
    </template>

    <!-- Text Only -->
    <template v-else-if="variant === 'text'">
      <div class="flex flex-col">
        <h1 :class="[textSizeClasses, 'font-bold', themeClasses.text]">
          Klinik Bungas
        </h1>
        <p 
          v-if="size !== 'xs' && size !== 'sm'" 
          class="text-xs text-gray-500 font-medium -mt-1"
        >
          Caring with Love
        </p>
      </div>
    </template>

    <!-- Full Logo (Icon + Text) -->
    <template v-else>
      <!-- Icon -->
        <div 
          :class="[
            sizeClasses,
            'relative flex items-center justify-center mr-3'
          ]"
        >
          <img 
            src="/images/RBungas.png" 
            alt="Klinik Bungas Logo" 
            class="w-full h-full object-contain"
          />
          
          <!-- Animated glow -->
          <div 
            v-if="animated" 
            class="absolute inset-0 rounded-2xl bg-gradient-to-br from-pink-400 to-rose-500 opacity-20 animate-glow-pulse"
          ></div>
        </div>

      <!-- Text -->
      <div class="flex flex-col">
        <h1 :class="[textSizeClasses, 'font-bold leading-tight', themeClasses.text]">
          Klinik Bungas
        </h1>
        <p 
          v-if="size !== 'xs' && size !== 'sm'" 
          :class="[
            'text-xs font-medium leading-tight',
            props.theme === 'dark' ? 'text-gray-300' : 'text-gray-500'
          ]"
        >
          Caring with Love
        </p>
      </div>
    </template>
  </div>
</template>

<script lang="ts">
import { computed, withDefaults, defineProps, defineEmits } from 'vue';

export default {
  name: 'KlinikBungasLogo'
};
</script>

<style scoped>
/* Custom glow animation for the logo */
@keyframes logo-glow {
  0%, 100% {
    box-shadow: 0 0 20px rgba(236, 72, 153, 0.3);
  }
  50% {
    box-shadow: 0 0 30px rgba(236, 72, 153, 0.6);
  }
}

.animate-logo-glow {
  animation: logo-glow 2s ease-in-out infinite;
}

/* Gradient text animation */
.bg-gradient-to-r {
  background-size: 200% 200%;
  animation: gradient-shift 3s ease infinite;
}

@keyframes gradient-shift {
  0%, 100% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
}

/* Hover effects */
.hover-glow:hover {
  filter: drop-shadow(0 0 10px rgba(236, 72, 153, 0.5));
}
</style>