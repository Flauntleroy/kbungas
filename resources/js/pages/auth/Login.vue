<script setup lang="ts">
import InputError from '@/components/InputError.vue';
import TextLink from '@/components/TextLink.vue';
import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { register } from '@/routes';
import { store } from '@/routes/login';
import { request } from '@/routes/password';
import { Form, Head } from '@inertiajs/vue3';
import { LoaderCircle, Heart, Stethoscope, Shield } from 'lucide-vue-next';
import KlinikBungasLogo from '@/components/brand/KlinikBungasLogo.vue';
import BrandElements from '@/components/brand/BrandElements.vue';

defineProps<{
    status?: string;
    canResetPassword: boolean;
}>();
</script>

<template>
    <Head title="Masuk - Klinik Bungas" />
    
    <!-- Main Container with Pink Gradient Background -->
    <div class="min-h-screen bg-gradient-to-br from-pink-50 via-rose-50 to-pink-100 flex items-center justify-center p-4 relative overflow-hidden">
        
        <!-- Brand Watermark -->
        <BrandElements 
            type="watermark" 
            size="lg" 
            :opacity="0.05" 
            position="bottom-right" 
            :animated="true"
        />
        
        <!-- Decorative Background Elements -->
        <div class="absolute inset-0 overflow-hidden pointer-events-none">
            <!-- Floating Hearts -->
            <div class="absolute top-20 left-10 text-pink-200 opacity-30 animate-pulse">
                <Heart class="w-8 h-8" />
            </div>
            <div class="absolute top-40 right-20 text-rose-200 opacity-40 animate-bounce" style="animation-delay: 1s;">
                <Stethoscope class="w-12 h-12" />
            </div>
            <div class="absolute bottom-32 left-20 text-pink-300 opacity-25 animate-pulse" style="animation-delay: 2s;">
                <Shield class="w-10 h-10" />
            </div>
            
            <!-- Gradient Orbs -->
            <div class="absolute -top-40 -right-40 w-80 h-80 bg-gradient-to-br from-pink-200 to-rose-300 rounded-full opacity-20 blur-3xl"></div>
            <div class="absolute -bottom-40 -left-40 w-96 h-96 bg-gradient-to-tr from-rose-200 to-pink-300 rounded-full opacity-15 blur-3xl"></div>
        </div>

        <!-- Login Card Container -->
        <div class="w-full max-w-md relative z-10">
            
            <!-- Logo and Brand Section -->
             <!-- Logo and Brand Section -->
            <div class="flex justify-center mb-2">
            <img 
                src="/images/RBungas.png" 
                alt="Klinik Bungas Logo" 
                class="w-92 h-92 object-contain drop-shadow-lg animate-fade-in-up"
            />
            </div>
            <!-- <div class="text-center mb-8">
                <KlinikBungasLogo 
                    size="2xl" 
                    variant="full" 
                    theme="gradient" 
                    :animated="true"
                    class="justify-center mb-4 animate-fade-in-up"
                />
                <p class="text-gray-600 font-medium animate-fade-in-up" style="animation-delay: 0.2s">
                    Masuk ke akun Anda
                </p>
            </div> -->

            <!-- Login Form Card -->
            <div class="bg-white/80 backdrop-blur-sm rounded-3xl shadow-xl border border-pink-100 p-8 relative">
                
                <!-- Decorative Corner Elements -->
                <div class="absolute top-0 right-0 w-20 h-20 bg-gradient-to-bl from-pink-100 to-transparent rounded-tr-3xl opacity-50"></div>
                <div class="absolute bottom-0 left-0 w-16 h-16 bg-gradient-to-tr from-rose-100 to-transparent rounded-bl-3xl opacity-50"></div>
                
                <!-- Form Header -->
                <div class="text-center mb-6">
                    <h2 class="text-2xl font-semibold text-gray-800 mb-2">Masuk ke Akun Anda</h2>
                    <p class="text-gray-600 text-sm">Masukkan email dan password untuk melanjutkan</p>
                </div>

                <!-- Status Message -->
                <div
                    v-if="status"
                    class="mb-6 p-4 bg-green-50 border border-green-200 rounded-xl text-center text-sm font-medium text-green-700"
                >
                    {{ status }}
                </div>

                <!-- Login Form -->
                <Form
                    v-bind="store.form()"
                    :reset-on-success="['password']"
                    v-slot="{ errors, processing }"
                    class="space-y-6"
                >
                    <!-- Email Field -->
                    <div class="space-y-2">
                        <Label for="email" class="text-sm font-semibold text-gray-700">
                            Username/Email
                        </Label>
                        <div class="relative">
                            <Input
                                id="email"
                                type="email"
                                name="email"
                                placeholder="nama@klinikbungas.com"
                                class="w-full px-4 py-3 border-2 border-pink-100 rounded-xl focus:border-pink-300 focus:ring-4 focus:ring-pink-100 transition-all duration-200 bg-white/70 backdrop-blur-sm"
                                :tabindex="1"
                                autocomplete="username"
                                autofocus
                            />
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                <svg class="w-5 h-5 text-pink-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207" />
                                </svg>
                            </div>
                        </div>
                        <InputError :message="errors.email" class="text-rose-500 text-xs" />
                    </div>

                    <!-- Password Field -->
                    <div class="space-y-2">
                        <Label for="password" class="text-sm font-semibold text-gray-700">
                            Password
                        </Label>
                        <div class="relative">
                            <Input
                                id="password"
                                type="password"
                                name="password"
                                placeholder="Masukkan password"
                                class="w-full px-4 py-3 border-2 border-pink-100 rounded-xl focus:border-pink-300 focus:ring-4 focus:ring-pink-100 transition-all duration-200 bg-white/70 backdrop-blur-sm"
                                :tabindex="2"
                                autocomplete="current-password"
                            />
                            <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                                <svg class="w-5 h-5 text-pink-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                                </svg>
                            </div>
                        </div>
                        <InputError :message="errors.password" class="text-rose-500 text-xs" />
                    </div>

                    <!-- Remember Me & Forgot Password -->
                    <div class="flex items-center justify-between">
                        <Label class="flex items-center space-x-2 cursor-pointer group">
                            <Checkbox
                                name="remember"
                                :tabindex="3"
                                class="border-pink-200 text-pink-500 focus:ring-pink-200"
                            />
                            <span class="text-sm text-gray-600 group-hover:text-pink-600 transition-colors">
                                Ingat saya
                            </span>
                        </Label>

                        <TextLink
                            v-if="canResetPassword"
                            :href="request()"
                            :tabindex="4"
                            class="text-sm text-pink-600 hover:text-pink-700 font-medium transition-colors"
                        >
                            Lupa password?
                        </TextLink>
                    </div>

                    <!-- Login Button -->
                    <Button
                        type="submit"
                        class="w-full py-3 bg-[#eca8ae] hover:bg-[#b56a72] text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transform hover:scale-[1.02] transition-all duration-200 focus:ring-4 focus:ring-[#c67981]/40"
                        :tabindex="4"
                        :disabled="processing"
                        data-test="login-button"
                        >
                        <LoaderCircle
                            v-if="processing"
                            class="h-5 w-5 animate-spin mr-2"
                        />
                        <span v-if="!processing">Login</span>
                        <span v-else>Memproses...</span>
                    </Button>


                    <!-- Register Link -->
                    <div class="text-center pt-4 border-t border-pink-100">
                        <!-- <p class="text-sm text-gray-600">
                            Belum punya akun?
                            <TextLink 
                                :href="register()" 
                                :tabindex="5"
                                class="text-pink-600 hover:text-pink-700 font-semibold ml-1 transition-colors"
                            >
                                Daftar sekarang
                            </TextLink>
                        </p> -->
                    </div>
                </Form>
            </div>

            <!-- Footer -->
            <div class="text-center mt-6">
                <p class="text-xs text-gray-500">
                    © 2025 IT R. All rights reserved.
                </p>
            </div>
        </div>
    </div>
</template>

<style scoped>
/* Custom animations */
@keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
}

.animate-float {
    animation: float 3s ease-in-out infinite;
}

/* Smooth focus transitions */
.focus\:ring-4:focus {
    transition: box-shadow 0.2s ease-in-out;
}

/* Gradient text animation */
@keyframes gradient-shift {
    0%, 100% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
}

.bg-gradient-to-r {
    background-size: 200% 200%;
    animation: gradient-shift 3s ease infinite;
}
</style>
