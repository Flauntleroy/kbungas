<script setup lang="ts">
interface GradientCardProps {
  variant?: 'primary' | 'secondary' | 'accent' | 'subtle';
  size?: 'sm' | 'md' | 'lg' | 'xl';
  rounded?: 'sm' | 'md' | 'lg' | 'xl' | '2xl' | '3xl';
  shadow?: 'none' | 'sm' | 'md' | 'lg' | 'xl';
  blur?: boolean;
  border?: boolean;
  hover?: boolean;
  animated?: boolean;
}

const props = withDefaults(defineProps<GradientCardProps>(), {
  variant: 'primary',
  size: 'md',
  rounded: 'xl',
  shadow: 'lg',
  blur: true,
  border: true,
  hover: true,
  animated: false
});

const cardClasses = computed(() => {
  const classes = ['relative transition-all duration-300'];

  // Variant styles
  switch (props.variant) {
    case 'primary':
      classes.push('bg-white/80');
      if (props.blur) classes.push('backdrop-blur-sm');
      break;
    case 'secondary':
      classes.push('bg-gradient-to-br from-pink-50/90 to-rose-50/90');
      if (props.blur) classes.push('backdrop-blur-sm');
      break;
    case 'accent':
      classes.push('bg-gradient-to-r from-pink-500 to-rose-500 text-white');
      break;
    case 'subtle':
      classes.push('bg-pink-50/50');
      if (props.blur) classes.push('backdrop-blur-sm');
      break;
  }

  // Size styles
  switch (props.size) {
    case 'sm':
      classes.push('p-4');
      break;
    case 'md':
      classes.push('p-6');
      break;
    case 'lg':
      classes.push('p-8');
      break;
    case 'xl':
      classes.push('p-10');
      break;
  }

  // Rounded styles
  classes.push(`rounded-${props.rounded}`);

  // Shadow styles
  if (props.shadow !== 'none') {
    classes.push(`shadow-${props.shadow}`);
  }

  // Border styles
  if (props.border) {
    switch (props.variant) {
      case 'primary':
      case 'secondary':
      case 'subtle':
        classes.push('border border-pink-100');
        break;
      case 'accent':
        classes.push('border border-pink-400');
        break;
    }
  }

  // Hover effects
  if (props.hover) {
    switch (props.variant) {
      case 'primary':
      case 'secondary':
      case 'subtle':
        classes.push('hover:shadow-xl hover:border-pink-200');
        break;
      case 'accent':
        classes.push('hover:shadow-xl hover:from-pink-600 hover:to-rose-600');
        break;
    }
    classes.push('hover:scale-[1.02]');
  }

  // Animation
  if (props.animated) {
    classes.push('animate-fade-in');
  }

  return classes;
});
</script>

<template>
  <div :class="cardClasses">
    <!-- Decorative corner elements for primary variant -->
    <template v-if="variant === 'primary'">
      <div class="absolute top-0 right-0 w-20 h-20 bg-gradient-to-bl from-pink-100 to-transparent rounded-tr-xl opacity-50"></div>
      <div class="absolute bottom-0 left-0 w-16 h-16 bg-gradient-to-tr from-rose-100 to-transparent rounded-bl-xl opacity-50"></div>
    </template>

    <!-- Decorative glow for accent variant -->
    <template v-if="variant === 'accent'">
      <div class="absolute inset-0 bg-gradient-to-r from-pink-500 to-rose-500 rounded-xl blur-xl opacity-20 -z-10"></div>
    </template>

    <!-- Content slot -->
    <div class="relative z-10">
      <slot />
    </div>
  </div>
</template>

<script lang="ts">
import { computed, withDefaults, defineProps } from 'vue';

export default {
  name: 'GradientCard'
};
</script>

<style scoped>
/* Fade in animation */
@keyframes fade-in {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in {
  animation: fade-in 0.5s ease-out;
}

/* Subtle pulse animation for accent cards */
.variant-accent {
  animation: subtle-pulse 3s ease-in-out infinite;
}

@keyframes subtle-pulse {
  0%, 100% {
    box-shadow: 0 0 20px rgba(236, 72, 153, 0.3);
  }
  50% {
    box-shadow: 0 0 30px rgba(236, 72, 153, 0.5);
  }
}
</style>