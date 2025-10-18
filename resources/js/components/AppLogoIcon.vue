<script setup lang="ts">
import type { HTMLAttributes } from 'vue';

defineOptions({
    inheritAttrs: false,
});

interface Props {
    className?: HTMLAttributes['class'];
}

defineProps<Props>();
</script>

<template>
    <img
        src="/images/RBungas.png"
        alt="Klinik Bungas Logo"
        :class="className"
        v-bind="$attrs"
    />
</template>
