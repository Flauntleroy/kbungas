<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>Konfirmasi Booking - Klinik Bungas</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; }
        
        @keyframes fade-in-up {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes pulse-glow {
            0%, 100% {
                opacity: 0.3;
            }
            50% {
                opacity: 0.6;
            }
        }
        
        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-10px);
            }
        }
        
        .animate-fade-in-up {
            animation: fade-in-up 0.8s ease-out;
        }
        
        .animate-pulse-glow {
            animation: pulse-glow 2s ease-in-out infinite;
        }
        
        .animate-float {
            animation: float 3s ease-in-out infinite;
        }
        
        .glass-effect {
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-pink-50 via-rose-50 to-pink-100 flex items-center justify-center p-4 relative overflow-hidden">
    
    <!-- Decorative Background Elements -->
    <div class="absolute inset-0 overflow-hidden pointer-events-none">
        <!-- Floating Hearts -->
        <div class="absolute top-20 left-10 text-pink-200 opacity-30 animate-pulse">
            <svg class="w-8 h-8" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
            </svg>
        </div>
        <div class="absolute top-40 right-20 text-rose-200 opacity-40 animate-float" style="animation-delay: 1s;">
            <svg class="w-12 h-12" fill="currentColor" viewBox="0 0 24 24">
                <path d="M19 8h-2v3h-3v2h3v3h2v-3h3v-2h-3V8zM4 6h9v2H4zm0 5h9v2H4zm0 5h6v2H4z"/>
            </svg>
        </div>
        <div class="absolute bottom-32 left-20 text-pink-300 opacity-25 animate-pulse" style="animation-delay: 2s;">
            <svg class="w-10 h-10" fill="currentColor" viewBox="0 0 24 24">
                <path d="M12,1L3,5V11C3,16.55 6.84,21.74 12,23C17.16,21.74 21,16.55 21,11V5L12,1M12,7C13.4,7 14.8,8.6 14.8,10V11H16V18H8V11H9.2V10C9.2,8.6 10.6,7 12,7M12,8.2C11.2,8.2 10.4,8.7 10.4,10V11H13.6V10C13.6,8.7 12.8,8.2 12,8.2Z"/>
            </svg>
        </div>
        
        <!-- Gradient Orbs -->
        <div class="absolute -top-40 -right-40 w-80 h-80 bg-gradient-to-br from-pink-200 to-rose-300 rounded-full opacity-20 blur-3xl"></div>
        <div class="absolute -bottom-40 -left-40 w-96 h-96 bg-gradient-to-tr from-rose-200 to-pink-300 rounded-full opacity-15 blur-3xl"></div>
    </div>

    <!-- Main Container -->
    <div class="w-full max-w-md relative z-10">
        
        <!-- Logo Section -->
        <div class="flex justify-center mb-8">
            <img 
                src="/images/RBungas.png" 
                alt="Klinik Bungas Logo" 
                class="w-94 h-94 object-contain drop-shadow-lg animate-fade-in-up"
            />
        </div>

        <!-- Confirmation Card -->
        <div class="glass-effect rounded-3xl shadow-xl border border-pink-100 p-8 relative animate-fade-in-up" style="animation-delay: 0.2s;">
            
            <!-- Decorative Corner Elements -->
            <div class="absolute top-0 right-0 w-20 h-20 bg-gradient-to-bl from-pink-100 to-transparent rounded-tr-3xl opacity-50"></div>
            <div class="absolute bottom-0 left-0 w-16 h-16 bg-gradient-to-tr from-rose-100 to-transparent rounded-bl-3xl opacity-50"></div>
            
            <!-- Loading State -->
            <div id="loading-state" class="text-center">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-pink-100 to-rose-100 rounded-full mb-6 animate-pulse-glow">
                    <svg class="w-8 h-8 text-pink-600 animate-spin" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                </div>
                <h2 class="text-2xl font-semibold text-gray-800 mb-2">Memproses Konfirmasi</h2>
                <p class="text-gray-600 text-sm">Mohon tunggu sebentar...</p>
            </div>

            <!-- Success State -->
            <div id="success-state" class="text-center hidden">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-green-100 to-emerald-100 rounded-full mb-6">
                    <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                </div>
                <h2 class="text-2xl font-semibold text-gray-800 mb-4">Booking Berhasil Dikonfirmasi!</h2>
                
                <!-- Booking Details -->
                <div id="booking-details" class="bg-gradient-to-r from-pink-50 to-rose-50 rounded-2xl p-6 mb-6 text-left">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 text-center">Detail Booking</h3>
                    <div class="space-y-3">
                        <div class="flex justify-between items-center">
                            <span class="text-gray-600 font-medium">No. Booking:</span>
                            <span id="booking-number" class="font-semibold text-gray-800"></span>
                        </div>
                        <div class="flex justify-between items-center">
                            <span class="text-gray-600 font-medium">Nama Pasien:</span>
                            <span id="patient-name" class="font-semibold text-gray-800"></span>
                        </div>
                        <div class="flex justify-between items-center">
                            <span class="text-gray-600 font-medium">Tanggal:</span>
                            <span id="appointment-date" class="font-semibold text-gray-800"></span>
                        </div>
                        <div class="flex justify-between items-center">
                            <span class="text-gray-600 font-medium">Status:</span>
                            <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium bg-green-100 text-green-800">
                                <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                Diterima
                            </span>
                        </div>
                        <div class="flex justify-between items-center">
                            <span class="text-gray-600 font-medium">Dikonfirmasi:</span>
                            <span id="confirmed-at" class="font-semibold text-gray-800"></span>
                        </div>
                    </div>
                </div>
                
                <div class="bg-blue-50 border border-blue-200 rounded-xl p-4 mb-6">
                    <div class="flex items-start">
                        <svg class="w-5 h-5 text-blue-600 mt-0.5 mr-3 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"></path>
                        </svg>
                        <div class="text-sm text-blue-800">
                            <p class="font-medium mb-1">Notifikasi Terkirim</p>
                            <p>Pasien akan menerima notifikasi WhatsApp tentang konfirmasi booking ini.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Error State -->
            <div id="error-state" class="text-center hidden">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-red-100 to-rose-100 rounded-full mb-6">
                    <svg class="w-8 h-8 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </div>
                <h2 class="text-2xl font-semibold text-gray-800 mb-4">Konfirmasi Gagal</h2>
                <div class="bg-red-50 border border-red-200 rounded-xl p-4 mb-6">
                    <p id="error-message" class="text-red-800 text-sm"></p>
                </div>
            </div>

            <!-- Footer -->
            <div class="text-center pt-6 border-t border-pink-100">
                <p class="text-xs text-gray-500">
                    © 2025 IT R - All Rights Reserved
                </p>
            </div>
        </div>
    </div>

    <script>
        // Get token from URL
        const urlPath = window.location.pathname;
        const token = urlPath.split('/').pop();
        
        // Get CSRF token
        const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');
        
        // Process confirmation
        fetch(`/api/booking/confirm/${token}`, {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': csrfToken || ''
            }
        })
        .then(response => response.json())
        .then(data => {
            // Hide loading state
            document.getElementById('loading-state').classList.add('hidden');
            
            if (data.success) {
                // Show success state
                document.getElementById('success-state').classList.remove('hidden');
                
                // Populate booking details
                if (data.data) {
                    document.getElementById('booking-number').textContent = data.data.no_booking || '-';
                    document.getElementById('patient-name').textContent = data.data.patient_name || '-';
                    document.getElementById('appointment-date').textContent = data.data.appointment_date || '-';
                    document.getElementById('confirmed-at').textContent = data.data.confirmed_at || '-';
                }
            } else {
                // Show error state
                document.getElementById('error-state').classList.remove('hidden');
                document.getElementById('error-message').textContent = data.message || 'Terjadi kesalahan yang tidak diketahui.';
            }
        })
        .catch(error => {
            console.error('Error:', error);
            
            // Hide loading state
            document.getElementById('loading-state').classList.add('hidden');
            
            // Show error state
            document.getElementById('error-state').classList.remove('hidden');
            document.getElementById('error-message').textContent = 'Terjadi kesalahan jaringan. Silakan coba lagi.';
        });
    </script>
</body>
</html>