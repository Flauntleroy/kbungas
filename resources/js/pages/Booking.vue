<template>
  <div id="booking" class="min-h-screen bg-gradient-to-br from-rose-50 via-pink-50 to-white relative overflow-hidden">
    <Head title="Booking Konsultasi - Klinik Bungas" />
    
    <!-- Background Decorative Elements -->
    <div class="absolute inset-0 overflow-hidden pointer-events-none">
      <!-- Background Pattern -->
      <div class="absolute inset-0 opacity-5">
        <svg class="w-full h-full" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
          <defs>
            <pattern id="medical-pattern" x="0" y="0" width="20" height="20" patternUnits="userSpaceOnUse">
              <circle cx="10" cy="10" r="1" fill="currentColor" class="text-rose-400"/>
              <path d="M10 6v8M6 10h8" stroke="currentColor" stroke-width="0.5" class="text-rose-300"/>
            </pattern>
          </defs>
          <rect width="100%" height="100%" fill="url(#medical-pattern)"/>
        </svg>
      </div>
      <div class="absolute -top-40 -right-40 w-80 h-80 bg-gradient-to-br from-rose-200/20 to-pink-200/20 rounded-full blur-3xl"></div>
      <div class="absolute -bottom-40 -left-40 w-80 h-80 bg-gradient-to-tr from-rose-200/20 to-pink-200/20 rounded-full blur-3xl"></div>
      <div class="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 w-96 h-96 bg-gradient-to-r from-rose-100/10 to-pink-100/10 rounded-full blur-3xl"></div>
    </div>

    <!-- Navigation Header -->
    <nav class="relative z-10 bg-white/80 backdrop-blur-md border-b border-rose-100/50 sticky top-0">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center py-4">
          <div class="flex items-center space-x-3">
            <div class="w-16 h-16 flex items-center justify-center">
              <img src="/images/RBungas.png" alt="Klinik Bungas Logo" class="w-full h-full object-contain" />
            </div>
            <div>
               <h2 class="text-lg font-bold text-rose-800">Klinik Bungas</h2>
               <p class="text-xs text-rose-600">Layanan Kesehatan Terpercaya</p>
             </div>
          </div>
          <a href="/klinik" class="inline-flex items-center text-rose-600 hover:text-rose-700 font-medium text-sm transition-colors">
            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
            </svg>
            Kembali ke Beranda
          </a>
        </div>
      </div>
    </nav>

    <div class="relative z-10 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 lg:py-20">
      <!-- Hero Section -->
      <div class="text-center mb-16 animate-fade-in-up">
        <div class="inline-flex items-center bg-gradient-to-r from-rose-100 to-pink-100 text-rose-700 px-6 py-3 rounded-full text-sm font-semibold mb-6 shadow-sm">
          <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
          </svg>
          Booking Konsultasi Online
        </div>
        <h1 class="text-4xl md:text-5xl lg:text-6xl font-bold text-rose-800 mb-6 leading-tight">
           Buat Janji <span class="bg-gradient-to-r from-rose-500 to-pink-500 bg-clip-text text-transparent">Konsultasi</span>
         </h1>
         <p class="text-lg text-rose-700 max-w-3xl mx-auto leading-relaxed">
           Dapatkan pelayanan kesehatan terbaik dengan mudah. Isi formulir di bawah ini untuk membuat janji konsultasi sesuai kebutuhan Anda. Tim medis profesional kami siap melayani dengan penuh perhatian.
         </p>
      </div>

      <!-- Success Message -->
      <div v-if="successMessage" class="success-message mb-8 bg-green-50 border border-green-200 rounded-2xl p-6 animate-fade-in-up">
        <div class="flex items-center">
          <svg class="w-6 h-6 text-green-500 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
          </svg>
          <div>
            <h3 class="text-lg font-semibold text-green-800">Booking Berhasil!</h3>
            <p class="text-green-700">{{ successMessage }}</p>
          </div>
        </div>
      </div>

      <!-- Error Message -->
      <div v-if="errorMessage" class="mb-8 bg-red-50 border border-red-200 rounded-2xl p-6 animate-fade-in-up">
        <div class="flex items-center">
          <svg class="w-6 h-6 text-red-500 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
          </svg>
          <div>
            <h3 class="text-lg font-semibold text-red-800">Terjadi Kesalahan</h3>
            <p class="text-red-700">{{ errorMessage }}</p>
          </div>
        </div>
      </div>

      <!-- Main Content -->
      <div class="grid lg:grid-cols-3 gap-12 items-start">
        <!-- Booking Form -->
        <div class="lg:col-span-2">
          <div class="bg-white/70 backdrop-blur-sm rounded-3xl p-8 lg:p-10 border border-rose-100/50 shadow-xl shadow-rose-100/20 animate-fade-in-up animation-delay-200">
            <!-- Form Header -->
            <div class="flex items-center space-x-4 mb-8">
              <div class="w-12 h-12 bg-gradient-to-r from-rose-500 to-pink-500 rounded-2xl flex items-center justify-center">
                <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                </svg>
              </div>
              <div>
                 <h3 class="text-2xl font-bold text-rose-800">Formulir Booking</h3>
                 <p class="text-rose-600">Lengkapi data diri dan pilih jadwal konsultasi</p>
               </div>
            </div>

            <form @submit.prevent="submitBooking" class="space-y-8">
              <!-- Personal Information -->
              <div class="space-y-6">
                <h4 class="text-lg font-semibold text-rose-800 flex items-center">
                  <svg class="w-5 h-5 mr-2 text-rose-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                  </svg>
                  Informasi Pribadi
                </h4>
                <div class="grid md:grid-cols-2 gap-6">
                  <!-- NIK Field -->
                  <div class="group md:col-span-2">
                    <label class="block text-sm font-semibold text-rose-800 mb-3">NIK (Nomor Induk Kependudukan) *</label>
                    <div class="relative">
                      <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H5a2 2 0 00-2 2v9a2 2 0 002 2h14a2 2 0 002-2V8a2 2 0 00-2-2h-5m-4 0V4a2 2 0 114 0v2m-4 0a2 2 0 104 0m-5 8a2 2 0 100-4 2 2 0 000 4zm0 0c1.306 0 2.417.835 2.83 2M9 14a3.001 3.001 0 00-2.83 2M15 11h3m-3 4h2"/>
                        </svg>
                      </div>
                      <input 
                        v-model="form.nik"
                        type="text" 
                        required
                        maxlength="16"
                        pattern="[0-9]{16}"
                        @input="handleNikInput"
                        :disabled="isLoadingNik"
                        class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 placeholder-rose-400 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white disabled:opacity-50 disabled:cursor-not-allowed" 
                        placeholder="Masukkan 16 digit NIK Anda"
                      />
                      <div v-if="isLoadingNik" class="absolute inset-y-0 right-0 pr-4 flex items-center">
                        <svg class="animate-spin h-5 w-5 text-rose-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                          <path class="opacity-75" fill="currentColor" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                        </svg>
                      </div>
                    </div>
                    <div v-if="nikError" class="mt-2 text-sm text-red-600">
                      {{ nikError }}
                    </div>
                    <div v-if="nikSuccess" class="mt-2 text-sm text-green-600">
                      {{ nikSuccess }}
                    </div>
                    <div v-if="errors.nik" class="mt-2 text-sm text-red-600">
                      {{ errors.nik }}
                    </div>
                  </div>
                  
                  <!-- Nomor Kartu BPJS/Asuransi -->
                  <div class="group">
                    <label class="block text-sm font-semibold text-rose-800 mb-3">Nomor Kartu BPJS/Asuransi</label>
                    <div class="relative">
                      <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                        </svg>
                      </div>
                      <input 
                        v-model="form.nomor_kartu"
                        type="text" 
                        maxlength="13"
                        :readonly="isKartuFromNik"
                        class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 placeholder-rose-400 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white readonly:bg-rose-50 readonly:text-rose-700" 
                        placeholder="Masukkan nomor kartu BPJS/Asuransi (opsional)"
                      />
                      <div v-if="isKartuFromNik" class="absolute inset-y-0 right-0 pr-4 flex items-center">
                        <svg class="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                        </svg>
                      </div>
                    </div>
                    <div v-if="isKartuFromNik" class="mt-2 text-sm text-green-600">
                      Nomor kartu otomatis terisi dari data NIK
                    </div>
                    <div v-if="errors.nomor_kartu" class="mt-2 text-sm text-red-600">
                      {{ errors.nomor_kartu }}
                    </div>
                  </div>
                  
                  <div class="group">
                    <label class="block text-sm font-semibold text-rose-800 mb-3">Nama Lengkap *</label>
                    <div class="relative">
                      <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                        </svg>
                      </div>
                      <input 
                        v-model="form.nama"
                        type="text" 
                        required
                        :readonly="isNameFromNik"
                        class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 placeholder-rose-400 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white readonly:bg-rose-50 readonly:text-rose-700" 
                        placeholder="Masukkan nama lengkap Anda"
                      />
                      <div v-if="isNameFromNik" class="absolute inset-y-0 right-0 pr-4 flex items-center">
                        <svg class="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                        </svg>
                      </div>
                    </div>
                    <div v-if="isNameFromNik" class="mt-2 text-sm text-green-600">
                      Nama otomatis terisi dari data NIK
                    </div>
                    <div v-if="errors.nama" class="mt-2 text-sm text-red-600">
                      {{ errors.nama }}
                    </div>
                  </div>
                </div>
                
                <!-- Email field dihapus, nilai default '-' akan diset otomatis -->
                <div class="group">
                  <label class="block text-sm font-semibold text-rose-800 mb-3">Nomor Telepon *</label>
                  <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                      <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                      </svg>
                    </div>
                    <input 
                      v-model="form.no_telp"
                      type="tel" 
                      required
                      class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 placeholder-rose-400 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white" 
                      placeholder="08xx xxxx xxxx"
                    />
                  </div>
                  <div v-if="errors.no_telp" class="mt-2 text-sm text-red-600">
                    {{ errors.no_telp }}
                  </div>
                </div>
                
                <div class="group">
                  <label class="block text-sm font-semibold text-rose-800 mb-3">Alamat *</label>
                  <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                      <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"/>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"/>
                      </svg>
                    </div>
                    <textarea 
                      v-model="form.alamat"
                      required
                      rows="3"
                      class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 placeholder-rose-400 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white resize-none" 
                      placeholder="Masukkan alamat lengkap Anda"
                    ></textarea>
                  </div>
                  <div v-if="errors.alamat" class="mt-2 text-sm text-red-600">
                    {{ errors.alamat }}
                  </div>
                </div>
              </div>

              <!-- Appointment Details -->
              <div class="space-y-6">
                <h4 class="text-lg font-semibold text-rose-800 flex items-center">
                  <svg class="w-5 h-5 mr-2 text-rose-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                  </svg>
                  Detail Konsultasi
                </h4>

                  <div class="grid md:grid-cols-2 gap-6">
                  <div class="group">
                    <label class="block text-sm font-semibold text-rose-800 mb-3">Tanggal & Waktu Konsultasi *</label>
                    <div class="relative">
                      <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                      </div>
                      <input 
                        v-model="form.tanggal"
                        type="datetime-local" 
                        required
                        :min="minDateTime"
                        @change="handleDoctorOrDateChange"
                        class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white"
                      />
                    </div>
                    <div v-if="errors.tanggal" class="mt-2 text-sm text-red-600">
                      {{ errors.tanggal }}
                    </div>
                    <div class="mt-2 text-xs text-rose-600">
                      Format: YYYY-MM-DD HH:MM (contoh: 2025-12-25 10:30)
                    </div>
                  </div>
                  
                  <!-- Poliklinik field dihapus dari tampilan, nilai "Umum" akan diset otomatis -->
                
                <div class="group">
                  <label class="block text-sm font-semibold text-rose-800 mb-3">Pilih Dokter *</label>
                  <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                      <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                      </svg>
                    </div>
                    <select 
                      v-model="form.kd_dokter"
                      required
                      @change="handleDoctorOrDateChange"
                      class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white appearance-none"
                    >
                      <option value="">Pilih dokter konsultasi</option>
                      <option v-for="dokter in formOptions.dokter" :key="dokter.value" :value="dokter.value">
                        {{ dokter.label }}
                      </option>
                    </select>
                    <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                      <svg class="w-5 h-5 text-rose-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                      </svg>
                    </div>
                  </div>
                  <div v-if="errors.kd_dokter" class="mt-2 text-sm text-red-600">
                    {{ errors.kd_dokter }}
                  </div>
                </div>
                </div>
                
                <!-- Jenis Pembayaran field dihapus dari tampilan, nilai "Umum" akan diset otomatis -->
              </div>

              <!-- Additional Information -->
              <div class="space-y-6">
                <h4 class="text-lg font-semibold text-rose-800 flex items-center">
                  <svg class="w-5 h-5 mr-2 text-rose-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-1l-4 4z"/>
                  </svg>
                  Informasi Tambahan
                </h4>
                
                <div class="group">
                  <label class="block text-sm font-semibold text-rose-800 mb-3">Keluhan atau Catatan Khusus</label>
                  <div class="relative">
                    <textarea 
                      v-model="form.catatan"
                      rows="4" 
                      class="w-full px-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 placeholder-rose-400 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white resize-none" 
                      placeholder="Jelaskan keluhan, gejala, atau kebutuhan khusus yang ingin Anda konsultasikan..."
                    ></textarea>
                  </div>
                  <div v-if="errors.catatan" class="mt-2 text-sm text-red-600">
                    {{ errors.catatan }}
                  </div>
                </div>
              </div>

              <!-- Submit Buttons -->
              <div class="flex flex-col sm:flex-row gap-4 pt-6">
                <button 
                  type="submit" 
                  :disabled="isSubmitting"
                  class="flex-1 bg-gradient-to-r from-rose-500 to-pink-500 text-white px-8 py-4 rounded-2xl font-semibold hover:from-rose-600 hover:to-pink-600 focus:from-rose-600 focus:to-pink-600 transition-all duration-300 shadow-lg hover:shadow-xl focus:shadow-xl transform hover:-translate-y-1 focus:-translate-y-1 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none flex items-center justify-center"
                >
                  <svg v-if="!isSubmitting" class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"/>
                  </svg>
                  <svg v-else class="w-5 h-5 mr-2 animate-spin" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                  </svg>
                  {{ isSubmitting ? 'Mengirim...' : 'Kirim Permintaan Booking' }}
                </button>
                <a 
                  href="https://wa.me/6281234567890?text=Halo%20Klinik%20Bungas,%20saya%20ingin%20booking%20janji%20konsultasi" 
                  class="flex-1 sm:flex-none bg-white/80 backdrop-blur-sm border-2 border-rose-200 text-rose-600 px-8 py-4 rounded-2xl font-semibold hover:bg-rose-50 hover:border-rose-300 transition-all duration-300 shadow-sm hover:shadow-md flex items-center justify-center"
                >
                  <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.785"/>
                  </svg>
                  WhatsApp
                </a>
              </div>
            </form>
          </div>
        </div>

        <!-- Sidebar Information -->
        <div class="space-y-8 animate-fade-in-up animation-delay-400">
          <!-- Contact Information -->
          <div class="bg-white/70 backdrop-blur-sm rounded-3xl p-8 border border-rose-100/50 shadow-lg">
            <div class="flex items-center space-x-3 mb-6">
              <div class="w-10 h-10 bg-gradient-to-r from-rose-500 to-pink-500 rounded-xl flex items-center justify-center">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                </svg>
              </div>
              <h3 class="text-lg font-bold text-rose-800">Kontak Darurat</h3>
            </div>
            <div class="space-y-4">
              <div class="flex items-center space-x-3">
                <div class="w-8 h-8 bg-rose-100 rounded-lg flex items-center justify-center">
                  <svg class="w-4 h-4 text-rose-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
                  </svg>
                </div>
                <div>
                  <p class="text-sm font-medium text-rose-800">+62 21 1234 5678</p>
                  <p class="text-xs text-rose-600">24/7 Gawat Darurat</p>
                </div>
              </div>
              <div class="flex items-center space-x-3">
                <div class="w-8 h-8 bg-green-100 rounded-lg flex items-center justify-center">
                  <svg class="w-4 h-4 text-green-600" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.785"/>
                  </svg>
                </div>
                <div>
                  <p class="text-sm font-medium text-rose-800">+62 812 3456 7890</p>
                  <p class="text-xs text-rose-600">WhatsApp Chat</p>
                </div>
              </div>
            </div>
          </div>

          <!-- Operating Hours -->
          <div class="bg-white/70 backdrop-blur-sm rounded-3xl p-8 border border-rose-100/50 shadow-lg">
            <div class="flex items-center space-x-3 mb-6">
              <div class="w-10 h-10 bg-gradient-to-r from-rose-500 to-pink-500 rounded-xl flex items-center justify-center">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
              </div>
              <h3 class="text-lg font-bold text-rose-800">Jam Operasional</h3>
            </div>
            <div class="space-y-3">
              <div class="flex justify-between items-center">
                <span class="text-sm text-rose-600">Senin - Jumat</span>
                <span class="text-sm font-medium text-rose-800">08:00 - 20:00</span>
              </div>
              <div class="flex justify-between items-center">
                <span class="text-sm text-rose-600">Sabtu</span>
                <span class="text-sm font-medium text-rose-800">08:00 - 16:00</span>
              </div>
              <div class="flex justify-between items-center">
                <span class="text-sm text-rose-600">Minggu</span>
                <span class="text-sm font-medium text-rose-800">10:00 - 14:00</span>
              </div>
              <div class="border-t border-rose-100 pt-3 mt-3">
                <div class="flex justify-between items-center">
                  <span class="text-sm text-rose-600">Gawat Darurat</span>
                  <span class="text-sm font-medium text-rose-600">24/7</span>
                </div>
              </div>
            </div>
          </div>

          <!-- Doctor Information -->
          <div class="bg-white/70 backdrop-blur-sm rounded-3xl p-8 border border-rose-100/50 shadow-lg">
            <div class="flex items-center space-x-3 mb-6">
              <div class="w-10 h-10 bg-gradient-to-r from-rose-500 to-pink-500 rounded-xl flex items-center justify-center">
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                </svg>
              </div>
              <h3 class="text-lg font-bold text-rose-800">Dokter Tersedia</h3>
            </div>
            <div class="space-y-4">
              <div class="flex items-center space-x-4">
                <div class="w-12 h-12 bg-gradient-to-r from-rose-400 to-pink-400 rounded-full flex items-center justify-center">
                  <span class="text-white font-semibold text-sm">BS</span>
                </div>
                <div>
                  <p class="font-semibold text-rose-800">dr. Bunga Sari, Sp.KK</p>
                  <p class="text-sm text-rose-600">Spesialis Kulit & Kelamin</p>
                  <p class="text-xs text-rose-600">10+ tahun pengalaman</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head } from '@inertiajs/vue3'
import { ref, computed, onMounted } from 'vue'
import { router } from '@inertiajs/vue3'
import Swal from 'sweetalert2'
import html2canvas from 'html2canvas'
import 'animate.css'

defineOptions({
  layout: null
})

// Form data - sesuai dengan struktur database booking_periksa
const form = ref({
  nik: '',
  nomor_kartu: '',
  nama: '',
  tanggal: '',
  alamat: '',
  no_telp: '',
  email: '',
  kd_poli: '',
  kd_dokter: '',
  kd_pj: '',
  catatan: ''
})

// Form options from API
const formOptions = ref({
  dokter: [],
  poliklinik: [],
  penjab: []
})

// Form state
const isSubmitting = ref(false)
const isLoadingNik = ref(false)
const isNameFromNik = ref(false)
const isKartuFromNik = ref(false)
const nikError = ref('')
const nikSuccess = ref('')

// Function to generate receipt HTML
const generateReceiptHTML = (bookingData: any) => {
  const selectedPoli = formOptions.value.poliklinik.find(p => p.value === bookingData.kd_poli)
  const selectedDokter = formOptions.value.dokter.find(d => d.value === bookingData.kd_dokter)
  const selectedPenjab = formOptions.value.penjab.find(p => p.value === bookingData.kd_pj)
  
  return `
    <div id="receipt" style="
      width: 400px;
      padding: 30px;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #fdf2f8 0%, #fce7f3 100%);
      border: 2px solid #f472b6;
      border-radius: 15px;
      box-shadow: 0 10px 25px rgba(244, 114, 182, 0.2);
    ">
      <!-- Header -->
      <div style="text-align: center; margin-bottom: 25px; border-bottom: 2px solid #f472b6; padding-bottom: 20px;">
        <div style="
          width: 60px;
          height: 60px;
          background: linear-gradient(135deg, #ec4899, #f472b6);
          border-radius: 50%;
          margin: 0 auto 15px;
          display: flex;
          align-items: center;
          justify-content: center;
        ">
          <svg width="30" height="30" fill="white" viewBox="0 0 24 24">
            <path d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
          </svg>
        </div>
        <h2 style="color: #be185d; margin: 0; font-size: 24px; font-weight: bold;">Klinik Bungas</h2>
        <p style="color: #ec4899; margin: 5px 0 0; font-size: 14px;">Receipt Booking Konsultasi</p>
      </div>
      
      <!-- Booking Info -->
      <div style="margin-bottom: 25px;">
        <div style="
          background: white;
          padding: 20px;
          border-radius: 10px;
          border-left: 4px solid #ec4899;
          margin-bottom: 15px;
        ">
          <h3 style="color: #be185d; margin: 0 0 10px; font-size: 18px;">Nomor Booking</h3>
          <p style="color: #1f2937; margin: 0; font-size: 24px; font-weight: bold; letter-spacing: 1px;">${bookingData.no_booking}</p>
        </div>
      </div>
      
      <!-- Patient Details -->
      <div style="margin-bottom: 25px;">
        <h3 style="color: #be185d; margin: 0 0 15px; font-size: 16px; border-bottom: 1px solid #f472b6; padding-bottom: 5px;">Detail Pasien</h3>
        <div style="background: white; padding: 15px; border-radius: 8px;">
          <div style="margin-bottom: 10px;">
            <span style="color: #6b7280; font-size: 12px; display: block;">Nama Lengkap</span>
            <span style="color: #1f2937; font-weight: 600;">${bookingData.nama}</span>
          </div>
          <div style="margin-bottom: 10px;">
            <span style="color: #6b7280; font-size: 12px; display: block;">NIK</span>
            <span style="color: #1f2937; font-weight: 600;">${bookingData.nik}</span>
          </div>
          <div style="margin-bottom: 10px;">
            <span style="color: #6b7280; font-size: 12px; display: block;">No. Telepon</span>
            <span style="color: #1f2937; font-weight: 600;">${bookingData.no_telp}</span>
          </div>
          ${bookingData.email ? `
          <div>
            <span style="color: #6b7280; font-size: 12px; display: block;">Email</span>
            <span style="color: #1f2937; font-weight: 600;">${bookingData.email}</span>
          </div>
          ` : ''}
        </div>
      </div>
      
      <!-- Appointment Details -->
      <div style="margin-bottom: 25px;">
        <h3 style="color: #be185d; margin: 0 0 15px; font-size: 16px; border-bottom: 1px solid #f472b6; padding-bottom: 5px;">Detail Konsultasi</h3>
        <div style="background: white; padding: 15px; border-radius: 8px;">
          <div style="margin-bottom: 10px;">
            <span style="color: #6b7280; font-size: 12px; display: block;">Tanggal & Waktu</span>
            <span style="color: #1f2937; font-weight: 600;">${new Date(bookingData.tanggal).toLocaleString('id-ID', { 
              weekday: 'long', 
              year: 'numeric', 
              month: 'long', 
              day: 'numeric',
              hour: '2-digit',
              minute: '2-digit'
            })}</span>
          </div>
          <div style="margin-bottom: 10px;">
            <span style="color: #6b7280; font-size: 12px; display: block;">Poliklinik</span>
            <span style="color: #1f2937; font-weight: 600;">${selectedPoli?.label || bookingData.kd_poli}</span>
          </div>
          <div style="margin-bottom: 10px;">
            <span style="color: #6b7280; font-size: 12px; display: block;">Dokter</span>
            <span style="color: #1f2937; font-weight: 600;">${selectedDokter?.label || bookingData.kd_dokter}</span>
          </div>
          <div>
            <span style="color: #6b7280; font-size: 12px; display: block;">Jenis Pembayaran</span>
            <span style="color: #1f2937; font-weight: 600;">${selectedPenjab?.label || bookingData.kd_pj}</span>
          </div>
        </div>
      </div>
      
      <!-- Status -->
      <div style="margin-bottom: 25px;">
        <div style="
          background: linear-gradient(135deg, #dcfce7, #bbf7d0);
          border: 1px solid #22c55e;
          padding: 15px;
          border-radius: 8px;
          text-align: center;
        ">
          <span style="color: #15803d; font-weight: bold; font-size: 14px;">✓ BOOKING BERHASIL</span>
        </div>
      </div>
      
      <!-- Footer -->
      <div style="text-align: center; border-top: 1px solid #f472b6; padding-top: 15px;">
        <p style="color: #6b7280; font-size: 12px; margin: 0;">
          Terima kasih telah mempercayai Klinik Bungas<br>
          Harap datang 15 menit sebelum jadwal konsultasi
        </p>
        <p style="color: #9ca3af; font-size: 10px; margin: 10px 0 0;">
          Dicetak pada: ${new Date().toLocaleString('id-ID')}
        </p>
      </div>
    </div>
  `
}

// Function to download receipt as JPG
const downloadReceipt = async (bookingData: any) => {
  try {
    // Create temporary div with receipt HTML
    const tempDiv = document.createElement('div')
    tempDiv.innerHTML = generateReceiptHTML(bookingData)
    tempDiv.style.position = 'absolute'
    tempDiv.style.left = '-9999px'
    tempDiv.style.top = '-9999px'
    document.body.appendChild(tempDiv)
    
    // Generate canvas from HTML
    const canvas = await html2canvas(tempDiv.querySelector('#receipt') as HTMLElement, {
      backgroundColor: '#ffffff',
      scale: 2, // Higher quality
      useCORS: true,
      allowTaint: true
    })
    
    // Convert to JPG and download
    const link = document.createElement('a')
    link.download = `receipt-booking-${bookingData.no_booking}.jpg`
    link.href = canvas.toDataURL('image/jpeg', 0.9)
    link.click()
    
    // Clean up
    document.body.removeChild(tempDiv)
    
    // Show success message
    Swal.fire({
      icon: 'success',
      title: 'Receipt Downloaded!',
      text: 'Receipt berhasil diunduh ke perangkat Anda',
      timer: 2000,
      showConfirmButton: false
    })
  } catch (error) {
    console.error('Error generating receipt:', error)
    Swal.fire({
      icon: 'error',
      title: 'Download Gagal',
      text: 'Terjadi kesalahan saat mengunduh receipt'
    })
  }
}
const successMessage = ref('')
const errorMessage = ref('')
const errors = ref({})

// Load form data on mount
const loadFormData = async () => {
  try {
    const response = await fetch('/api/booking/form-data', {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      }
    })

    const result = await response.json()
    
    if (result.success) {
      formOptions.value = result.data
      
      // Set default values untuk field yang dihapus
      form.value.email = 'pasien@klinikbungas.com' // Default value untuk email
      
      // Set nilai otomatis untuk poliklinik dan jenis pembayaran ke "Umum"
      const umumPoli = formOptions.value.poliklinik.find(p => 
        p.label && p.label.toLowerCase().includes('umum')
      )
      if (umumPoli) {
        form.value.kd_poli = umumPoli.value
      }
      
      const umumPenjab = formOptions.value.penjab.find(p => 
        p.label && p.label.toLowerCase().includes('umum')
      )
      if (umumPenjab) {
        form.value.kd_pj = umumPenjab.value
      }
    } else {
      console.error('Failed to load form data:', result.message)
    }
  } catch (error) {
    console.error('Error loading form data:', error)
  }
}

// Validate NIK format (16 digits)
const validateNikFormat = (nik: string): boolean => {
  return /^\d{16}$/.test(nik)
}

// Fetch NIK data from BPJS API
const fetchNikData = async (nik: string): Promise<boolean> => {
  if (!validateNikFormat(nik)) {
    nikError.value = 'Format NIK tidak valid'
    nikSuccess.value = ''
    isNameFromNik.value = false
    isKartuFromNik.value = false
    return false
  }

  try {
    const response = await fetch('/api/bpjs/check-nik', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      },
      body: JSON.stringify({ nik })
    })

    const result = await response.json()
    
    // Cek response sesuai struktur BPJS API yang benar
    if (result.metaData && result.metaData.code === '200' && result.response && result.response.peserta) {
      const pesertaData = result.response.peserta
      
      // Auto-fill data dari response BPJS
      form.value.nama = pesertaData.nama || ''
      form.value.nomor_kartu = pesertaData.noKartu || ''
      isNameFromNik.value = true
      isKartuFromNik.value = true
      nikSuccess.value = 'Data NIK berhasil ditemukan dan diisi otomatis'
      nikError.value = ''
      
      // Set penjab to umum (UMU) regardless of BPJS data found
      const umumPenjab = formOptions.value.penjab.find(p => 
        p.label && p.label.toLowerCase().includes('umum')
      )
      if (umumPenjab) {
        form.value.kd_pj = umumPenjab.value
      }
      
      return true
    } else if (result.metaData && result.metaData.code === '201') {
      // Data tidak ditemukan di BPJS
      nikError.value = 'Data NIK tidak ditemukan di BPJS'
      nikSuccess.value = ''
      isNameFromNik.value = false
      isKartuFromNik.value = false
      
      // Set penjab to umum if NIK not found in BPJS
      const umumPenjab = formOptions.value.penjab.find(p => 
        p.label && p.label.toLowerCase().includes('umum')
      )
      if (umumPenjab) {
        form.value.kd_pj = umumPenjab.value
      }
      
      return false
    } else {
      // Error atau response tidak valid
      nikError.value = result.metaData?.message || 'Gagal mengambil data NIK dari BPJS'
      nikSuccess.value = ''
      isNameFromNik.value = false
      isKartuFromNik.value = false
      
      return false
    }
  } catch (error) {
    nikError.value = error instanceof Error ? error.message : 'Gagal mengambil data NIK'
    nikSuccess.value = ''
    isNameFromNik.value = false
    isKartuFromNik.value = false
    return false
  }
}

const handleNikInput = async (event: Event) => {
  const target = event.target as HTMLInputElement
  const nik = target.value.replace(/\D/g, '') // Clean NIK (numbers only)
  
  // Update form with cleaned NIK
  form.value.nik = nik
  
  // Reset states
  nikError.value = ''
  nikSuccess.value = ''
  
  // Clear name if it was auto-filled previously
  if (isNameFromNik.value) {
    form.value.nama = ''
    form.value.nomor_kartu = ''
    isNameFromNik.value = false
    isKartuFromNik.value = false
  }
  
  // Validate and fetch data if NIK is complete
  if (nik.length === 16) {
    isLoadingNik.value = true
    await fetchNikData(nik)
    isLoadingNik.value = false
  } else if (nik.length > 0) {
    nikError.value = `NIK harus 16 digit (${nik.length}/16)`
  }
}

// Handle doctor or date change
const handleDoctorOrDateChange = () => {
  // This function can be used to load available slots if needed
  console.log('Doctor or date changed')
}

// Computed minimum datetime (now)
const minDateTime = computed(() => {
  const now = new Date()
  // Add 1 hour to current time as minimum booking time
  now.setHours(now.getHours() + 1)
  return now.toISOString().slice(0, 16) // Format: YYYY-MM-DDTHH:MM
})

// Validasi form
const validateForm = () => {
  errors.value = {}
  
  // Validasi NIK (opsional, tapi jika diisi harus valid)
  if (form.value.nik && !/^\d{16}$/.test(form.value.nik)) {
    errors.value.nik = 'NIK harus 16 digit angka'
  }
  
  // Validasi nama
  if (!form.value.nama) {
    errors.value.nama = 'Nama lengkap wajib diisi'
  } else if (form.value.nama.length < 3) {
    errors.value.nama = 'Nama minimal 3 karakter'
  } else if (form.value.nama.length > 40) {
    errors.value.nama = 'Nama maksimal 40 karakter'
  }
  
  // Validasi nomor telepon
  if (!form.value.no_telp) {
    errors.value.no_telp = 'Nomor telepon wajib diisi'
  } else if (!/^(\+62|62|0)[0-9]{8,13}$/.test(form.value.no_telp)) {
    errors.value.no_telp = 'Format nomor telepon tidak valid'
  }
  
  // Validasi email
  if (form.value.email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.value.email)) {
    errors.value.email = 'Format email tidak valid'
  }
  
  // Validasi alamat
  if (!form.value.alamat) {
    errors.value.alamat = 'Alamat wajib diisi'
  } else if (form.value.alamat.length > 200) {
    errors.value.alamat = 'Alamat maksimal 200 karakter'
  }
  
  // Validasi tanggal
  if (!form.value.tanggal) {
    errors.value.tanggal = 'Tanggal dan waktu konsultasi wajib diisi'
  } else {
    const selectedDateTime = new Date(form.value.tanggal)
    const now = new Date()
    const minBookingTime = new Date(now.getTime() + 60 * 60 * 1000) // 1 hour from now
    
    if (selectedDateTime < minBookingTime) {
      errors.value.tanggal = 'Waktu konsultasi minimal 1 jam dari sekarang'
    }
    
    // Cek maksimal 30 hari ke depan
    const maxDate = new Date()
    maxDate.setDate(maxDate.getDate() + 30)
    if (selectedDateTime > maxDate) {
      errors.value.tanggal = 'Tanggal maksimal 30 hari dari sekarang'
    }
  }
  
  // Validasi poliklinik
  if (!form.value.kd_poli) {
    errors.value.kd_poli = 'Poliklinik wajib dipilih'
  }
  
  // Validasi dokter
  if (!form.value.kd_dokter) {
    errors.value.kd_dokter = 'Dokter wajib dipilih'
  }
  
  // Validasi jenis pembayaran
  if (!form.value.kd_pj) {
    errors.value.kd_pj = 'Jenis pembayaran wajib dipilih'
  }
  
  // Validasi nomor kartu BPJS jika diperlukan
  if (form.value.kd_pj && formOptions.value.penjab.length > 0) {
    const selectedPenjab = formOptions.value.penjab.find(p => p.value === form.value.kd_pj)
    if (selectedPenjab && selectedPenjab.label && selectedPenjab.label.toLowerCase().includes('bpjs')) {
      // Nomor kartu boleh kosong atau berisi tanda hubung
      if (form.value.nomor_kartu && form.value.nomor_kartu !== '-' && !/^\d{13}$/.test(form.value.nomor_kartu)) {
        errors.value.nomor_kartu = 'Nomor kartu BPJS harus 13 digit atau kosong'
      }
    }
  }
  
  // Validasi catatan
  if (form.value.catatan && form.value.catatan.length > 255) {
    errors.value.catatan = 'Catatan maksimal 255 karakter'
  }
  
  return Object.keys(errors.value).length === 0
}

// Submit form
const submitBooking = async () => {
  if (isSubmitting.value) return

  // Validasi form
  if (!validateForm()) {
    return
  }

  isSubmitting.value = true

  try {
    // Konversi format tanggal dari datetime-local (2025-10-20T10:00) ke Y-m-d H:i (2025-10-20 10:00)
    const formattedTanggal = form.value.tanggal ? form.value.tanggal.replace('T', ' ') : ''
    
    const response = await fetch('/api/booking/store', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
      },
      body: JSON.stringify({
        nik: form.value.nik,
        nomor_kartu: form.value.nomor_kartu,
        nama: form.value.nama,
        tanggal: formattedTanggal,
        alamat: form.value.alamat,
        no_telp: form.value.no_telp,
        email: form.value.email,
        kd_poli: form.value.kd_poli,
        kd_dokter: form.value.kd_dokter,
        kd_pj: form.value.kd_pj,
        catatan: form.value.catatan
      })
    })

    const result = await response.json()

    if (response.ok && result.success) {
      // Show SweetAlert2 success popup with booking details
      const selectedPoli = formOptions.value.poliklinik.find(p => p.value === result.data.kd_poli)
      const selectedDokter = formOptions.value.dokter.find(d => d.value === result.data.kd_dokter)
      const selectedPenjab = formOptions.value.penjab.find(p => p.value === result.data.kd_pj)
      
      Swal.fire({
        icon: false,
        title: 'Booking Berhasil',
        html: `
          <div class="elegant-popup-content">
            <div class="decorative-header">
              <div class="ornament-top"></div>
              <div class="success-icon">
                <svg width="60" height="60" viewBox="0 0 60 60" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <circle cx="30" cy="30" r="28" fill="url(#successGradient)" stroke="url(#borderGradient)" stroke-width="2"/>
                  <path d="M20 30L26 36L40 22" stroke="white" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                  <defs>
                    <linearGradient id="successGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                      <stop offset="0%" style="stop-color:#f8d7da"/>
                      <stop offset="50%" style="stop-color:#ec4899"/>
                      <stop offset="100%" style="stop-color:#be185d"/>
                    </linearGradient>
                    <linearGradient id="borderGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                      <stop offset="0%" style="stop-color:#fdf2f8"/>
                      <stop offset="100%" style="stop-color:#ec4899"/>
                    </linearGradient>
                  </defs>
                </svg>
              </div>
              <div class="ornament-bottom"></div>
            </div>
            <div class="message-content">
              <p class="elegant-message">Booking berhasil dilakukan. Tim kami akan segera menghubungi Anda untuk konfirmasi lebih lanjut.</p>
            </div>
            <div class="decorative-footer">
              <div class="ornament-line"></div>
            </div>
          </div>
        `,
        confirmButtonText: 'OK',
        confirmButtonColor: '#ec4899',
        width: '480px',
        padding: '0',
        background: 'transparent',
        customClass: {
          popup: 'elegant-booking-popup',
          confirmButton: 'elegant-ok-btn',
          htmlContainer: 'elegant-html-container'
        },
        showClass: {
          popup: 'animate__animated animate__fadeInUp animate__faster'
        },
        hideClass: {
          popup: 'animate__animated animate__fadeOutDown animate__faster'
        }
      })
      
      // Clear messages and reset form
      successMessage.value = ''
      errorMessage.value = ''
      
      // Reset form
      form.value = {
        nik: '',
        nomor_kartu: '',
        nama: '',
        tanggal: '',
        alamat: '',
        no_telp: '',
        email: '',
        kd_poli: '',
        kd_dokter: '',
        kd_pj: '',
        catatan: ''
      }
      
    } else {
      // Show error popup for failed booking
      Swal.fire({
        icon: 'error',
        title: 'Booking Gagal',
        text: result.message || 'Terjadi kesalahan saat menyimpan booking',
        confirmButtonText: 'OK',
        confirmButtonColor: '#dc2626',
        customClass: {
          popup: 'elegant-error-popup'
        }
      })
      
      errorMessage.value = result.message || 'Terjadi kesalahan saat menyimpan booking'
      successMessage.value = ''
      
      // Handle validation errors
      if (result.errors) {
        errors.value = result.errors
      }
    }
  } catch (error) {
    console.error('Error submitting booking:', error)
    
    // Show error popup for network/server errors
    Swal.fire({
      icon: 'error',
      title: 'Kesalahan Jaringan',
      text: 'Terjadi kesalahan jaringan. Silakan coba lagi.',
      confirmButtonText: 'OK',
      confirmButtonColor: '#dc2626',
      customClass: {
        popup: 'elegant-error-popup'
      }
    })
    
    errorMessage.value = 'Terjadi kesalahan jaringan. Silakan coba lagi.'
    successMessage.value = ''
  } finally {
    isSubmitting.value = false
  }
}

// Add animation classes on mount
onMounted(() => {
  // Add fade-in animation classes
  const elements = document.querySelectorAll('.animate-fade-in-up')
  elements.forEach((el, index) => {
    setTimeout(() => {
      el.classList.add('opacity-100', 'translate-y-0')
    }, index * 200)
  })
  
  // Load form data
  loadFormData()
})
</script>

<style scoped>
/* Animations */
.animate-fade-in-up {
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.6s ease-out;
}

.animate-fade-in-up.opacity-100 {
  opacity: 1;
}

.animate-fade-in-up.translate-y-0 {
  transform: translateY(0);
}

/* Custom scrollbar */
::-webkit-scrollbar {
  width: 8px;
}

::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb {
  background: #e91e63;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #c2185b;
}

/* Form focus states */
.form-input:focus {
  outline: none;
  border-color: #e91e63;
  box-shadow: 0 0 0 3px rgba(233, 30, 99, 0.1);
}

.form-select:focus {
  outline: none;
  border-color: #e91e63;
  box-shadow: 0 0 0 3px rgba(233, 30, 99, 0.1);
}

/* Loading spinner */
.loading-spinner {
  border: 2px solid #f3f3f3;
  border-top: 2px solid #e91e63;
  border-radius: 50%;
  width: 20px;
  height: 20px;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

/* Button hover effects */
.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(233, 30, 99, 0.3);
}

.btn-whatsapp:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(37, 211, 102, 0.3);
}

/* Card hover effects */
.info-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .container {
    padding: 0 1rem;
  }
  
  .form-grid {
    grid-template-columns: 1fr;
  }
  
  .hero-title {
    font-size: 2rem;
  }
  
  .hero-subtitle {
    font-size: 1rem;
  }
}

/* Error message styling */
.error-message {
  animation: shake 0.5s ease-in-out;
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-5px); }
  75% { transform: translateX(5px); }
}

/* Success message styling */
.success-message {
  animation: slideInDown 0.5s ease-out;
}

@keyframes slideInDown {
  0% {
    transform: translateY(-100%);
    opacity: 0;
  }
  100% {
    transform: translateY(0);
    opacity: 1;
  }
}
</style>

<style>
/* Global SweetAlert2 Custom Styles */
.booking-success-popup {
  border-radius: 20px !important;
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15) !important;
}

.booking-success-popup .swal2-title {
  color: #be185d !important;
  font-size: 28px !important;
  font-weight: bold !important;
  margin-bottom: 20px !important;
}

.booking-success-popup .swal2-html-container {
  margin: 0 !important;
  padding: 0 !important;
}

.download-receipt-btn {
  background: linear-gradient(135deg, #ec4899, #f472b6) !important;
  border: none !important;
  border-radius: 12px !important;
  padding: 12px 24px !important;
  font-weight: 600 !important;
  font-size: 16px !important;
  transition: all 0.3s ease !important;
  box-shadow: 0 4px 15px rgba(236, 72, 153, 0.3) !important;
}

.download-receipt-btn:hover {
  transform: translateY(-2px) !important;
  box-shadow: 0 8px 25px rgba(236, 72, 153, 0.4) !important;
}

.close-btn {
  background: #6b7280 !important;
  border: none !important;
  border-radius: 12px !important;
  padding: 12px 24px !important;
  font-weight: 600 !important;
  font-size: 16px !important;
  transition: all 0.3s ease !important;
}

.close-btn:hover {
  background: #4b5563 !important;
  transform: translateY(-2px) !important;
}

.booking-success-popup .swal2-actions {
  margin-top: 25px !important;
  gap: 15px !important;
}

/* Responsive SweetAlert2 */
@media (max-width: 768px) {
  .booking-success-popup {
    width: 95% !important;
    margin: 0 auto !important;
  }
  
  .booking-success-popup .swal2-title {
    font-size: 24px !important;
  }
  
  .download-receipt-btn,
  .close-btn {
    font-size: 14px !important;
    padding: 10px 20px !important;
  }
}

@media (max-width: 480px) {
  .booking-success-popup .swal2-title {
    font-size: 20px !important;
  }
  
  .booking-success-popup .swal2-actions {
    flex-direction: column !important;
    gap: 10px !important;
  }
  
  .download-receipt-btn,
  .close-btn {
    width: 100% !important;
  }
}

/* Elegant Booking Popup Styles */
.elegant-booking-popup {
  background: linear-gradient(145deg, #fdf2f8 0%, #fce7f3 50%, #fbcfe8 100%) !important;
  border: none !important;
  border-radius: 24px !important;
  box-shadow: 
    0 25px 50px rgba(190, 24, 93, 0.15),
    0 15px 35px rgba(236, 72, 153, 0.1),
    inset 0 1px 0 rgba(255, 255, 255, 0.6) !important;
  backdrop-filter: blur(10px) !important;
  position: relative !important;
  overflow: hidden !important;
}

.elegant-booking-popup::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: 
    radial-gradient(circle at 20% 20%, rgba(236, 72, 153, 0.1) 0%, transparent 50%),
    radial-gradient(circle at 80% 80%, rgba(190, 24, 93, 0.08) 0%, transparent 50%);
  pointer-events: none;
  z-index: -1;
}

.elegant-html-container {
  margin: 0 !important;
  padding: 0 !important;
}

.elegant-popup-content {
  padding: 40px 30px 30px;
  text-align: center;
  position: relative;
}

.decorative-header {
  margin-bottom: 30px;
  position: relative;
}

.ornament-top {
  width: 80px;
  height: 3px;
  background: linear-gradient(90deg, transparent, #ec4899, transparent);
  margin: 0 auto 20px;
  border-radius: 2px;
  position: relative;
}

.ornament-top::before,
.ornament-top::after {
  content: '';
  position: absolute;
  width: 8px;
  height: 8px;
  background: linear-gradient(45deg, #ec4899, #f472b6);
  border-radius: 50%;
  top: -2.5px;
}

.ornament-top::before {
  left: -4px;
}

.ornament-top::after {
  right: -4px;
}

.success-icon {
  margin: 0 auto 20px;
  filter: drop-shadow(0 8px 16px rgba(236, 72, 153, 0.2));
  animation: gentle-pulse 2s ease-in-out infinite;
  display: flex;
  justify-content: center;
  align-items: center;
}

@keyframes gentle-pulse {
  0%, 100% { 
    transform: scale(1);
    opacity: 1;
  }
  50% { 
    transform: scale(1.05);
    opacity: 0.9;
  }
}

.ornament-bottom {
  width: 60px;
  height: 2px;
  background: linear-gradient(90deg, transparent, #f472b6, transparent);
  margin: 0 auto;
  border-radius: 1px;
}

.elegant-booking-popup .swal2-title {
  color: #be185d !important;
  font-family: 'Georgia', 'Times New Roman', serif !important;
  font-size: 28px !important;
  font-weight: 400 !important;
  letter-spacing: 0.5px !important;
  margin: 0 0 25px !important;
  text-shadow: 0 2px 4px rgba(190, 24, 93, 0.1) !important;
}

.message-content {
  margin: 25px 0;
}

.elegant-message {
  color: #4a5568 !important;
  font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif !important;
  font-size: 16px !important;
  line-height: 1.7 !important;
  font-weight: 400 !important;
  margin: 0 !important;
  letter-spacing: 0.3px !important;
}

.decorative-footer {
  margin-top: 25px;
}

.ornament-line {
  width: 120px;
  height: 1px;
  background: linear-gradient(90deg, transparent, #ec4899, transparent);
  margin: 0 auto;
  position: relative;
}

.ornament-line::before {
  content: '';
  position: absolute;
  left: 50%;
  top: -2px;
  transform: translateX(-50%);
  width: 5px;
  height: 5px;
  background: #ec4899;
  border-radius: 50%;
}

.elegant-ok-btn {
  background: #ec4899 !important;
  border: none !important;
  border-radius: 50px !important;
  padding: 14px 40px !important;
  font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif !important;
  font-weight: 500 !important;
  font-size: 16px !important;
  letter-spacing: 0.5px !important;
  color: white !important;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1) !important;
  box-shadow: 
    0 8px 20px rgba(236, 72, 153, 0.3),
    0 3px 6px rgba(236, 72, 153, 0.2),
    inset 0 1px 0 rgba(255, 255, 255, 0.2) !important;
  transition: all 0.3s ease !important;
  position: relative !important;
  overflow: hidden !important;
}

.elegant-ok-btn::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.15), transparent);
  transition: left 0.5s ease;
}

.elegant-ok-btn:hover {
  background: #db2777 !important;
  transform: translateY(-2px) !important;
  box-shadow: 
    0 12px 25px rgba(236, 72, 153, 0.4),
    0 6px 12px rgba(236, 72, 153, 0.3),
    inset 0 1px 0 rgba(255, 255, 255, 0.3) !important;
}

.elegant-ok-btn:hover::before {
  left: 100%;
}

.elegant-ok-btn:active {
  background: #be185d !important;
  transform: translateY(-1px) scale(0.98) !important;
}

/* Responsive Design */
@media (max-width: 768px) {
  .elegant-booking-popup {
    width: 90% !important;
    margin: 0 5% !important;
  }
  
  .elegant-popup-content {
    padding: 30px 20px 25px;
  }
  
  .elegant-booking-popup .swal2-title {
    font-size: 24px !important;
  }
  
  .elegant-message {
    font-size: 15px !important;
  }
  
  .elegant-ok-btn {
    padding: 12px 35px !important;
    font-size: 15px !important;
  }
}

@media (max-width: 480px) {
  .elegant-popup-content {
    padding: 25px 15px 20px;
  }
  
  .elegant-booking-popup .swal2-title {
    font-size: 22px !important;
  }
  
  .elegant-message {
    font-size: 14px !important;
  }
  
  .elegant-ok-btn {
    width: 100% !important;
    padding: 12px 20px !important;
  }
}
@media (max-width: 768px) {
  .confirmation-popup {
    width: 90% !important;
  }
  
  .confirmation-popup .swal2-title {
    font-size: 20px !important;
  }
  
  .confirmation-popup .swal2-content {
    font-size: 14px !important;
  }
  
  .ok-btn {
    font-size: 14px !important;
    padding: 10px 25px !important;
  }
}

/* Error popup styling */
.elegant-error-popup {
  border-radius: 20px !important;
  box-shadow: 0 25px 50px rgba(220, 38, 38, 0.15) !important;
}

.elegant-error-popup .swal2-title {
  color: #dc2626 !important;
  font-size: 24px !important;
  font-weight: bold !important;
  margin-bottom: 15px !important;
}

.elegant-error-popup .swal2-content {
  color: #374151 !important;
  font-size: 16px !important;
  line-height: 1.5 !important;
}

.elegant-error-popup .swal2-confirm {
  background: linear-gradient(135deg, #dc2626, #ef4444) !important;
  border: none !important;
  border-radius: 12px !important;
  padding: 12px 24px !important;
  font-weight: 600 !important;
  font-size: 16px !important;
  transition: all 0.3s ease !important;
  box-shadow: 0 4px 15px rgba(220, 38, 38, 0.3) !important;
}

.elegant-error-popup .swal2-confirm:hover {
  transform: translateY(-2px) !important;
  box-shadow: 0 8px 25px rgba(220, 38, 38, 0.4) !important;
}
</style>