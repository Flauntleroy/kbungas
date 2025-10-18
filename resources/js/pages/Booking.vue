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
            <div class="w-10 h-10 bg-gradient-to-r from-rose-500 to-pink-500 rounded-xl flex items-center justify-center">
              <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/>
              </svg>
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
                
                <div class="grid md:grid-cols-2 gap-6">
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
                    <label class="block text-sm font-semibold text-rose-800 mb-3">Email</label>
                    <div class="relative">
                      <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"/>
                        </svg>
                      </div>
                      <input 
                        v-model="form.email"
                        type="email" 
                        class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 placeholder-rose-400 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white" 
                        placeholder="email@example.com"
                      />
                    </div>
                    <div v-if="errors.email" class="mt-2 text-sm text-red-600">
                      {{ errors.email }}
                    </div>
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
                    <label class="block text-sm font-semibold text-rose-800 mb-3">Tanggal Konsultasi *</label>
                    <div class="relative">
                      <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                        </svg>
                      </div>
                      <input 
                        v-model="form.tanggal"
                        type="date" 
                        required
                        :min="minDate"
                        @change="handleDoctorOrDateChange"
                        class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white"
                      />
                    </div>
                    <div v-if="errors.tanggal" class="mt-2 text-sm text-red-600">
                      {{ errors.tanggal }}
                    </div>
                  </div>
                  
                  <div class="group">
                    <label class="block text-sm font-semibold text-rose-800 mb-3">Poliklinik *</label>
                    <div class="relative">
                      <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                        </svg>
                      </div>
                      <select 
                        v-model="form.kd_poli"
                        required
                        class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white appearance-none"
                      >
                        <option value="">Pilih Poliklinik</option>
                        <option v-for="poli in formOptions.poliklinik" :key="poli.kd_poli" :value="poli.kd_poli">
                          {{ poli.nm_poli }}
                        </option>
                      </select>
                      <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-rose-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                        </svg>
                      </div>
                    </div>
                    <div v-if="errors.kd_poli" class="mt-2 text-sm text-red-600">
                      {{ errors.kd_poli }}
                    </div>
                  </div>
                </div>
                
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
                      <option v-for="dokter in formOptions.dokter" :key="dokter.kd_dokter" :value="dokter.kd_dokter">
                        {{ dokter.nm_dokter }}
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
                
                <!-- Jenis Pembayaran -->
                <div class="group">
                  <label class="block text-sm font-semibold text-rose-800 mb-3">Jenis Pembayaran *</label>
                  <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                      <svg class="w-5 h-5 text-rose-400 group-focus-within:text-rose-500 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"/>
                      </svg>
                    </div>
                    <select 
                      v-model="form.kd_pj"
                      required
                      class="w-full pl-12 pr-4 py-4 border border-rose-200 rounded-2xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-300 text-rose-900 bg-white/50 backdrop-blur-sm hover:bg-white/80 focus:bg-white appearance-none"
                    >
                      <option value="">Pilih jenis pembayaran</option>
                      <option v-for="pj in formOptions.penjab" :key="pj.kd_pj" :value="pj.kd_pj">
                        {{ pj.png_jawab }}
                      </option>
                    </select>
                    <div class="absolute inset-y-0 right-0 pr-4 flex items-center pointer-events-none">
                      <svg class="w-5 h-5 text-rose-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"/>
                      </svg>
                    </div>
                  </div>
                  <div v-if="errors.kd_pj" class="mt-2 text-sm text-red-600">
                    {{ errors.kd_pj }}
                  </div>
                </div>
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
    
    if (result.success && result.data) {
      form.value.nama = result.data.nama || ''
      form.value.nomor_kartu = result.data.noKartu || ''
      isNameFromNik.value = true
      isKartuFromNik.value = true
      nikSuccess.value = 'Data NIK berhasil ditemukan'
      nikError.value = ''
      
      // Set penjab to BPJS if data found
      const bpjsPenjab = formOptions.value.penjab.find(p => 
        p.png_jawab.toLowerCase().includes('bpjs') || 
        p.png_jawab.toLowerCase().includes('jkn')
      )
      if (bpjsPenjab) {
        form.value.kd_pj = bpjsPenjab.kd_pj
      }
      
      return true
    } else {
      nikError.value = 'Data NIK tidak ditemukan di BPJS'
      nikSuccess.value = ''
      isNameFromNik.value = false
      isKartuFromNik.value = false
      
      // Set penjab to umum if NIK not found in BPJS
      const umumPenjab = formOptions.value.penjab.find(p => 
        p.png_jawab.toLowerCase().includes('umum')
      )
      if (umumPenjab) {
        form.value.kd_pj = umumPenjab.kd_pj
      }
      
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

// Computed minimum date (today)
const minDate = computed(() => {
  const today = new Date()
  return today.toISOString().split('T')[0]
})

// Validasi form
const validateForm = () => {
  errors.value = {}
  
  // Validasi NIK
  if (!form.value.nik) {
    errors.value.nik = 'NIK wajib diisi'
  } else if (!/^\d{16}$/.test(form.value.nik)) {
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
    errors.value.tanggal = 'Tanggal konsultasi wajib dipilih'
  } else {
    const selectedDate = new Date(form.value.tanggal)
    const today = new Date()
    today.setHours(0, 0, 0, 0)
    
    if (selectedDate < today) {
      errors.value.tanggal = 'Tanggal tidak boleh kurang dari hari ini'
    }
    
    // Cek maksimal 30 hari ke depan
    const maxDate = new Date()
    maxDate.setDate(maxDate.getDate() + 30)
    if (selectedDate > maxDate) {
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
    const selectedPenjab = formOptions.value.penjab.find(p => p.kd_pj === form.value.kd_pj)
    if (selectedPenjab && selectedPenjab.png_jawab.toLowerCase().includes('bpjs')) {
      if (!form.value.nomor_kartu) {
        errors.value.nomor_kartu = 'Nomor kartu BPJS wajib diisi untuk pembayaran BPJS'
      } else if (!/^\d{13}$/.test(form.value.nomor_kartu)) {
        errors.value.nomor_kartu = 'Nomor kartu BPJS harus 13 digit'
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
        tanggal: form.value.tanggal,
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
      successMessage.value = `Booking berhasil! Nomor booking Anda: ${result.data.no_booking}`
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
      
      // Scroll to success message
      setTimeout(() => {
        document.querySelector('.success-message')?.scrollIntoView({ behavior: 'smooth' })
      }, 100)
      
    } else {
      errorMessage.value = result.message || 'Terjadi kesalahan saat menyimpan booking'
      successMessage.value = ''
      
      // Handle validation errors
      if (result.errors) {
        errors.value = result.errors
      }
    }
  } catch (error) {
    console.error('Error submitting booking:', error)
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