<template>
  <div id="booking" class="min-h-screen bg-gradient-to-br from-rose-50 to-pink-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
      <div class="text-center mb-12">
        <div class="inline-flex items-center bg-rose-100 text-rose-700 px-4 py-2 rounded-full text-sm font-medium mb-4">
          <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"/>
          </svg>
          Booking Janji
        </div>
        <h1 class="text-3xl md:text-4xl font-bold text-gray-900">Buat Janji Konsultasi</h1>
        <p class="text-gray-600 max-w-2xl mx-auto mt-3">Isi formulir di bawah ini untuk membuat janji konsultasi sesuai kebutuhan Anda. Tim kami akan segera menghubungi untuk konfirmasi.</p>
      </div>

      <div class="max-w-3xl mx-auto bg-white rounded-3xl p-8 border border-rose-100 shadow-lg">
        <form class="space-y-6">
          <div class="grid md:grid-cols-2 gap-6">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Nama Lengkap</label>
              <input type="text" class="w-full px-4 py-3 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-200 text-gray-900 placeholder-gray-500" placeholder="Masukkan nama lengkap"/>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Nomor Telepon</label>
              <input type="tel" class="w-full px-4 py-3 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-200 text-gray-900 placeholder-gray-500" placeholder="08xx xxxx xxxx"/>
            </div>
          </div>
          <div class="grid md:grid-cols-2 gap-6">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Tanggal Janji</label>
              <input type="date" class="w-full px-4 py-3 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-200 text-gray-900"/>
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Pilih Dokter</label>
              <select class="w-full px-4 py-3 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-200 text-gray-900">
                <option>dr. Bunga Sari, Sp.KK</option>
              </select>
            </div>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-2">Catatan Tambahan</label>
            <textarea rows="4" class="w-full px-4 py-3 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent transition-all duration-200 text-gray-900 placeholder-gray-500" placeholder="Jelaskan keluhan atau kebutuhan khusus..."/>
          </div>
          <div class="flex flex-col sm:flex-row gap-3">
            <button type="submit" class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-3 rounded-xl font-semibold hover:from-rose-600 hover:to-pink-600 transition-all duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-1">Kirim Permintaan</button>
            <a href="https://wa.me/6281234567890?text=Halo%20Klinik%20Bungas,%20saya%20ingin%20booking%20janji" class="bg-white border border-rose-200 text-rose-600 px-6 py-3 rounded-xl font-semibold hover:bg-rose-50 transition-colors shadow-sm">Hubungi via WhatsApp</a>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
// Placeholder setup if needed later.
</script>