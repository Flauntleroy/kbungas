<script setup lang="ts">
import type { HTMLAttributes } from 'vue'
import { cn } from '@/lib/utils'
import { useVModel } from '@vueuse/core'

const props = defineProps<{
  defaultValue?: string | number
  modelValue?: string | number
  class?: HTMLAttributes['class']
}>()

const emits = defineEmits<{
  (e: 'update:modelValue', payload: string | number): void
}>()

const modelValue = useVModel(props, 'modelValue', emits, {
  passive: true,
  defaultValue: props.defaultValue,
})
</script>

<template>
  <input
    v-model="modelValue"
    data-slot="input"
    :class="cn(
      'flex h-9 w-full min-w-0 rounded-md border border-pink-200 bg-white px-3 py-1 text-base text-black shadow-xs transition-[color,box-shadow] outline-none',
      'focus-visible:border-pink-400 focus-visible:ring-pink-200 focus-visible:ring-[3px]',
      'disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 md:text-sm',
      props.class,
    )"
  >
</template>
