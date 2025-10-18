<script setup lang="ts">
interface IconProps {
  size?: string | number;
  color?: string;
  class?: string;
}

const props = withDefaults(defineProps<IconProps>(), {
  size: 24,
  color: 'currentColor',
  class: ''
});

const iconSize = computed(() => {
  return typeof props.size === 'number' ? `${props.size}px` : props.size;
});
</script>

<template>
  <!-- Heart Icon -->
  <template v-if="$slots.heart">
    <svg 
      :width="iconSize" 
      :height="iconSize" 
      :class="props.class"
      viewBox="0 0 24 24" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
    >
      <path 
        d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" 
        :fill="props.color"
      />
    </svg>
  </template>

  <!-- Stethoscope Icon -->
  <template v-if="$slots.stethoscope">
    <svg 
      :width="iconSize" 
      :height="iconSize" 
      :class="props.class"
      viewBox="0 0 24 24" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
    >
      <path 
        d="M19 14a2 2 0 1 1-4 0 2 2 0 0 1 4 0zM8.5 2A1.5 1.5 0 0 0 7 3.5v3A1.5 1.5 0 0 0 8.5 8h1A1.5 1.5 0 0 0 11 6.5v-3A1.5 1.5 0 0 0 9.5 2h-1zM13 6.5A1.5 1.5 0 0 1 14.5 8h1A1.5 1.5 0 0 1 17 6.5v-3A1.5 1.5 0 0 1 15.5 2h-1A1.5 1.5 0 0 1 13 3.5v3zM7 10v1a6 6 0 0 0 6 6h.5a2.5 2.5 0 0 1 2.5 2.5v.5a1 1 0 0 0 2 0v-.5a4.5 4.5 0 0 0-4.5-4.5H13a4 4 0 0 1-4-4v-1H7z" 
        :fill="props.color"
      />
    </svg>
  </template>

  <!-- Medical Cross Icon -->
  <template v-if="$slots.medical-cross">
    <svg 
      :width="iconSize" 
      :height="iconSize" 
      :class="props.class"
      viewBox="0 0 24 24" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
    >
      <path 
        d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm5 11h-4v4h-2v-4H7v-2h4V7h2v4h4v2z" 
        :fill="props.color"
      />
    </svg>
  </template>

  <!-- Pill Icon -->
  <template v-if="$slots.pill">
    <svg 
      :width="iconSize" 
      :height="iconSize" 
      :class="props.class"
      viewBox="0 0 24 24" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
    >
      <path 
        d="M4.22 11.29l6.36-6.36a4.5 4.5 0 0 1 6.36 6.36l-6.36 6.36a4.5 4.5 0 0 1-6.36-6.36z" 
        :fill="props.color" 
        opacity="0.7"
      />
      <path 
        d="M12.71 12.71l6.36-6.36a4.5 4.5 0 0 1 0 6.36l-6.36 6.36" 
        :fill="props.color"
      />
    </svg>
  </template>

  <!-- Thermometer Icon -->
  <template v-if="$slots.thermometer">
    <svg 
      :width="iconSize" 
      :height="iconSize" 
      :class="props.class"
      viewBox="0 0 24 24" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
    >
      <path 
        d="M14 14.76V3.5a2.5 2.5 0 0 0-5 0v11.26a4.5 4.5 0 1 0 5 0zM12 4a.5.5 0 0 1 .5.5V8h-1V4.5A.5.5 0 0 1 12 4z" 
        :fill="props.color"
      />
    </svg>
  </template>

  <!-- Bandage Icon -->
  <template v-if="$slots.bandage">
    <svg 
      :width="iconSize" 
      :height="iconSize" 
      :class="props.class"
      viewBox="0 0 24 24" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
    >
      <path 
        d="M20.73 7.31L16.69 3.27a3 3 0 0 0-4.24 0L3.27 12.45a3 3 0 0 0 0 4.24l4.04 4.04a3 3 0 0 0 4.24 0l9.18-9.18a3 3 0 0 0 0-4.24zM11 13a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm2-2a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm2 2a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" 
        :fill="props.color"
      />
    </svg>
  </template>

  <!-- Syringe Icon -->
  <template v-if="$slots.syringe">
    <svg 
      :width="iconSize" 
      :height="iconSize" 
      :class="props.class"
      viewBox="0 0 24 24" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
    >
      <path 
        d="m18 6 4-4-2-2-4 4-2-2-1.5 1.5L15 6l-7 7H4v6h6v-4l7-7 2.5 2.5L21 9l-2-2-1-1z" 
        :fill="props.color"
      />
    </svg>
  </template>

  <!-- Calendar Medical Icon -->
  <template v-if="$slots.calendar-medical">
    <svg 
      :width="iconSize" 
      :height="iconSize" 
      :class="props.class"
      viewBox="0 0 24 24" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
    >
      <path 
        d="M19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM12 13h2v-2h2v-2h-2V7h-2v2h-2v2h2v2z" 
        :fill="props.color"
      />
    </svg>
  </template>

  <!-- User Medical Icon -->
  <template v-if="$slots.user-medical">
    <svg 
      :width="iconSize" 
      :height="iconSize" 
      :class="props.class"
      viewBox="0 0 24 24" 
      fill="none" 
      xmlns="http://www.w3.org/2000/svg"
    >
      <path 
        d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" 
        :fill="props.color"
      />
      <path 
        d="M19 14h-2v2h-2v2h2v2h2v-2h2v-2h-2v-2z" 
        :fill="props.color"
      />
    </svg>
  </template>
</template>

<script lang="ts">
import { computed, withDefaults, defineProps } from 'vue';

export default {
  name: 'MedicalIcons'
};
</script>