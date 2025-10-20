<?php

namespace App\Http\Controllers;

use App\Models\BookingPeriksa;
use App\Models\ClinicSetting;
use App\Models\Service;
use App\Models\ClinicDoctor;
use App\Models\User;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Carbon\Carbon;

class AdminController extends Controller
{
    /**
     * Display admin dashboard with real data
     */
    public function dashboard()
    {
        try {
            // Get current date
            $today = Carbon::today();
            $currentMonth = Carbon::now()->month;
            $currentYear = Carbon::now()->year;

            // Calculate statistics
            $stats = [
                'totalBookings' => BookingPeriksa::count(),
                'todayBookings' => BookingPeriksa::whereDate('tanggal', $today)->count(),
                'pendingBookings' => BookingPeriksa::where('status', 'Belum Dibalas')->count(),
                'totalPatients' => BookingPeriksa::distinct('nik')->count(),
                'newPatients' => BookingPeriksa::whereDate('tanggal_booking', $today)->distinct('nik')->count(),
                'averageRating' => 4.8, // Placeholder - implement rating system later
                'totalReviews' => 0 // Placeholder - implement review system later
            ];

            // Get recent bookings with real data
            $recentBookings = BookingPeriksa::with(['poliklinik', 'dokter'])
                ->orderBy('tanggal_booking', 'desc')
                ->limit(4)
                ->get()
                ->map(function ($booking) {
                    return [
                        'id' => $booking->no_booking,
                        'patient' => ['name' => $booking->nama],
                        'date' => $booking->tanggal ? Carbon::parse($booking->tanggal)->format('Y-m-d') : '',
                        'time' => $booking->tanggal ? Carbon::parse($booking->tanggal)->format('H:i') : '',
                        'status' => $booking->status ?? 'Belum Dibalas',
                        'poliklinik' => $booking->poliklinik->nm_poli ?? 'N/A',
                        'dokter' => $booking->dokter->nm_dokter ?? 'N/A'
                    ];
                });

            // Calculate monthly statistics
            $monthlyBookings = BookingPeriksa::whereMonth('tanggal', $currentMonth)
                ->whereYear('tanggal', $currentYear)
                ->get();

            $monthlyStats = [
                'completed' => $monthlyBookings->where('status', 'Diterima')->count(),
                'cancelled' => $monthlyBookings->where('status', 'Ditolak')->count(),
                'total' => $monthlyBookings->count(),
                'satisfaction' => 92 // Placeholder - implement satisfaction survey later
            ];

            return Inertia::render('Admin/Dashboard', [
                'stats' => $stats,
                'recentBookings' => $recentBookings,
                'monthlyStats' => $monthlyStats
            ]);

        } catch (\Exception $e) {
            // Log error and return with default data
            \Log::error('Admin Dashboard Error: ' . $e->getMessage());
            
            return Inertia::render('Admin/Dashboard', [
                'stats' => [
                    'totalBookings' => 0,
                    'todayBookings' => 0,
                    'pendingBookings' => 0,
                    'totalPatients' => 0,
                    'newPatients' => 0,
                    'averageRating' => 0,
                    'totalReviews' => 0
                ],
                'recentBookings' => [],
                'monthlyStats' => [
                    'completed' => 0,
                    'cancelled' => 0,
                    'total' => 0,
                    'satisfaction' => 0
                ]
            ]);
        }
    }

    /**
     * Display bookings management page
     */
    public function bookings()
    {
        $bookings = BookingPeriksa::with(['poliklinik', 'dokter', 'pasien'])
            ->orderBy('tanggal_booking', 'desc')
            ->paginate(20);

        return Inertia::render('Admin/Bookings', [
            'bookings' => $bookings
        ]);
    }

    /**
     * Display content management page
     */
    public function content()
    {
        // Get all content settings from the database using the correct key format
        $allSettings = ClinicSetting::getAll();

        $heroContent = [
            'title' => $allSettings['hero.title'] ?? 'Klinik Kulit & Kecantikan Terpercaya',
            'subtitle' => $allSettings['hero.subtitle'] ?? 'Dapatkan perawatan kulit terbaik dengan teknologi modern dan dokter berpengalaman. Konsultasi gratis untuk semua pasien baru.',
            'ctaText' => $allSettings['hero.cta_text'] ?? 'Booking Konsultasi',
            'ctaLink' => $allSettings['hero.cta_link'] ?? '/booking'
        ];

        // Get services from dedicated table
        $servicesFromDb = Service::active()->ordered()->get();
        $servicesContent = [];
        
        if ($servicesFromDb->isNotEmpty()) {
            $servicesContent = $servicesFromDb->map(function ($service) {
                return [
                    'name' => $service->name,
                    'description' => $service->description,
                    'icon' => $service->icon
                ];
            })->toArray();
        } else {
            // Fallback to JSON data if no services in dedicated table
            if (isset($allSettings['services.items'])) {
                $servicesData = is_string($allSettings['services.items']) 
                    ? json_decode($allSettings['services.items'], true) 
                    : $allSettings['services.items'];
                $servicesContent = is_array($servicesData) ? $servicesData : [];
            }
            
            // If still no services, use defaults
            if (empty($servicesContent)) {
                $servicesContent = [
                    [
                        'name' => 'Konsultasi Kulit',
                        'description' => 'Konsultasi menyeluruh untuk berbagai masalah kulit dengan dokter spesialis',
                        'icon' => '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>'
                    ],
                    [
                        'name' => 'Perawatan Jerawat',
                        'description' => 'Treatment khusus untuk mengatasi jerawat dan bekasnya',
                        'icon' => '<svg class="w-8 h-8" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"/></svg>'
                    ]
                ];
            }
        }

        // Get doctors from dedicated table
        $doctorsFromDb = ClinicDoctor::active()->ordered()->get();
        $doctorsContent = [];
        
        if ($doctorsFromDb->isNotEmpty()) {
            $doctorsContent = $doctorsFromDb->map(function ($doctor) {
                return [
                    'name' => $doctor->name,
                    'specialization' => $doctor->specialization,
                    'description' => $doctor->description,
                    'photo' => $doctor->photo,
                    'whatsapp' => $doctor->whatsapp,
                    'available' => $doctor->available
                ];
            })->toArray();
        } else {
            // Fallback to JSON data if no doctors in dedicated table
            if (isset($allSettings['doctors.all'])) {
                $doctorsData = is_string($allSettings['doctors.all']) 
                    ? json_decode($allSettings['doctors.all'], true) 
                    : $allSettings['doctors.all'];
                $doctorsContent = is_array($doctorsData) ? $doctorsData : [];
            }
            
            // If no doctors in database, create from primary doctor data or use defaults
            if (empty($doctorsContent)) {
                if (isset($allSettings['doctors.primary.name'])) {
                    $doctorsContent = [[
                        'name' => $allSettings['doctors.primary.name'],
                        'specialization' => $allSettings['doctors.primary.specialization'] ?? '',
                        'description' => $allSettings['doctors.primary.description'] ?? '',
                        'photo' => $allSettings['doctors.primary.photo'] ?? '',
                        'whatsapp' => $allSettings['doctors.primary.whatsapp'] ?? '',
                        'available' => ($allSettings['doctors.primary.available'] ?? '1') === '1'
                    ]];
                } else {
                    $doctorsContent = [[
                        'name' => 'Dr. Sarah Wijaya, Sp.KK',
                        'specialization' => 'Spesialis Kulit & Kelamin',
                        'description' => 'Berpengalaman lebih dari 10 tahun dalam menangani berbagai masalah kulit',
                        'photo' => '/images/doctors/dr-sarah.jpg',
                        'whatsapp' => '081234567890',
                        'available' => true
                    ]];
                }
            }
        }

        // Get contact hours from database or use defaults
        $contactHours = [];
        if (isset($allSettings['contact.hours'])) {
            $hoursData = is_string($allSettings['contact.hours']) 
                ? json_decode($allSettings['contact.hours'], true) 
                : $allSettings['contact.hours'];
            $contactHours = is_array($hoursData) ? $hoursData : [];
        }
        
        if (empty($contactHours)) {
            $contactHours = [
                'senin' => ['open' => '08:00', 'close' => '17:00', 'closed' => false],
                'selasa' => ['open' => '08:00', 'close' => '17:00', 'closed' => false],
                'rabu' => ['open' => '08:00', 'close' => '17:00', 'closed' => false],
                'kamis' => ['open' => '08:00', 'close' => '17:00', 'closed' => false],
                'jumat' => ['open' => '08:00', 'close' => '17:00', 'closed' => false],
                'sabtu' => ['open' => '08:00', 'close' => '14:00', 'closed' => false],
                'minggu' => ['open' => '', 'close' => '', 'closed' => true]
            ];
        }

        $contactContent = [
            'address' => $allSettings['contact.address'] ?? 'Jl. Kesehatan No. 123, Jakarta Selatan',
            'phone' => $allSettings['contact.phone'] ?? '021-12345678',
            'whatsapp' => $allSettings['contact.whatsapp'] ?? '081234567890',
            'email' => $allSettings['contact.email'] ?? 'info@klinikbungas.com',
            'hours' => $contactHours
        ];

        return Inertia::render('Admin/Content', [
            'heroContent' => $heroContent,
            'servicesContent' => $servicesContent,
            'doctorsContent' => $doctorsContent,
            'contactContent' => $contactContent
        ]);
    }

    /**
     * Update content settings
     */
    public function updateContent(Request $request)
    {
        $request->validate([
            'type' => 'required|in:hero,services,doctors,contact',
            'content' => 'required'
        ]);

        $type = $request->input('type');
        $content = $request->input('content');

        // Log the received data for debugging
        \Log::info("Updating content type: {$type}", ['content' => $content]);

        try {
            // Save content with the correct key format that matches the landing page expectations
            switch ($type) {
                case 'hero':
                    ClinicSetting::set('hero.title', $content['title'] ?? '', 'string', 'Hero section title');
                    ClinicSetting::set('hero.subtitle', $content['subtitle'] ?? '', 'string', 'Hero section subtitle');
                    ClinicSetting::set('hero.cta_text', $content['ctaText'] ?? '', 'string', 'Hero section CTA text');
                    ClinicSetting::set('hero.cta_link', $content['ctaLink'] ?? '', 'string', 'Hero section CTA link');
                    break;

                case 'services':
                    // Clear existing services
                    Service::query()->delete();
                    
                    // Validate and save services to dedicated table
                    if (is_array($content)) {
                        foreach ($content as $index => $serviceData) {
                            if (!isset($serviceData['name']) || !isset($serviceData['description'])) {
                                throw new \Exception('Invalid service data structure');
                            }
                            
                            Service::create([
                                'name' => $serviceData['name'],
                                'description' => $serviceData['description'],
                                'icon' => $serviceData['icon'] ?? '',
                                'order' => $index + 1,
                                'is_active' => true
                            ]);
                        }
                    }
                    break;

                case 'doctors':
                    // Clear existing doctors
                    ClinicDoctor::query()->delete();
                    
                    // Validate and save doctors to dedicated table
                    if (is_array($content)) {
                        foreach ($content as $index => $doctorData) {
                            if (!isset($doctorData['name']) || !isset($doctorData['specialization'])) {
                                throw new \Exception('Invalid doctor data structure');
                            }
                            
                            ClinicDoctor::create([
                                'name' => $doctorData['name'],
                                'specialization' => $doctorData['specialization'],
                                'description' => $doctorData['description'] ?? '',
                                'photo' => $doctorData['photo'] ?? '',
                                'whatsapp' => $doctorData['whatsapp'] ?? '',
                                'available' => $doctorData['available'] ?? true,
                                'is_primary' => $index === 0, // First doctor is primary
                                'order' => $index + 1,
                                'is_active' => true
                            ]);
                        }
                        
                        // Keep backward compatibility by saving primary doctor to settings
                        if (!empty($content)) {
                            $primaryDoctor = $content[0];
                            ClinicSetting::set('doctors.primary.name', $primaryDoctor['name'] ?? '', 'string', 'Primary doctor name');
                            ClinicSetting::set('doctors.primary.specialization', $primaryDoctor['specialization'] ?? '', 'string', 'Primary doctor specialization');
                            ClinicSetting::set('doctors.primary.description', $primaryDoctor['description'] ?? '', 'string', 'Primary doctor description');
                            ClinicSetting::set('doctors.primary.photo', $primaryDoctor['photo'] ?? '', 'string', 'Primary doctor photo');
                            ClinicSetting::set('doctors.primary.whatsapp', $primaryDoctor['whatsapp'] ?? '', 'string', 'Primary doctor WhatsApp');
                            ClinicSetting::set('doctors.primary.available', ($primaryDoctor['available'] ?? true) ? '1' : '0', 'boolean', 'Primary doctor availability');
                        }
                    }
                    break;

                case 'contact':
                    ClinicSetting::set('contact.address', $content['address'] ?? '', 'string', 'Clinic address');
                    ClinicSetting::set('contact.phone', $content['phone'] ?? '', 'string', 'Clinic phone');
                    ClinicSetting::set('contact.whatsapp', $content['whatsapp'] ?? '', 'string', 'Clinic WhatsApp');
                    ClinicSetting::set('contact.email', $content['email'] ?? '', 'string', 'Clinic email');
                    
                    // Handle both 'hours' and 'schedule' keys from frontend
                    $hours = $content['hours'] ?? $content['schedule'] ?? null;
                    if ($hours) {
                        ClinicSetting::set('contact.hours', json_encode($hours), 'json', 'Clinic operating hours');
                    }
                    break;
            }

            \Log::info("Content saved successfully for type: {$type}");

            return response()->json([
                'success' => true,
                'message' => 'Konten berhasil diperbarui',
                'data' => [
                    'type' => $type,
                    'timestamp' => now()->toISOString()
                ]
            ]);
        } catch (\Exception $e) {
            \Log::error("Error saving content: " . $e->getMessage(), [
                'type' => $type, 
                'content' => $content,
                'trace' => $e->getTraceAsString()
            ]);
            return response()->json([
                'success' => false,
                'message' => 'Terjadi kesalahan saat menyimpan: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Display users management page
     */
    public function users()
    {
        $users = User::orderBy('created_at', 'desc')->get();

        return Inertia::render('Admin/Users', [
            'users' => $users
        ]);
    }

    /**
     * Store a new user
     */
    public function storeUser(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'role' => 'required|in:super_admin,admin,staff',
            'status' => 'required|in:active,inactive,suspended'
        ]);

        User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'role' => $request->role,
            'status' => $request->status
        ]);

        return redirect()->back()->with('success', 'User berhasil ditambahkan');
    }

    /**
     * Update an existing user
     */
    public function updateUser(Request $request, User $user)
    {
        $rules = [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email,' . $user->id,
            'role' => 'required|in:super_admin,admin,staff',
            'status' => 'required|in:active,inactive,suspended'
        ];

        if ($request->filled('password')) {
            $rules['password'] = 'required|string|min:8|confirmed';
        }

        $request->validate($rules);

        $userData = [
            'name' => $request->name,
            'email' => $request->email,
            'role' => $request->role,
            'status' => $request->status
        ];

        if ($request->filled('password')) {
            $userData['password'] = bcrypt($request->password);
        }

        $user->update($userData);

        return redirect()->back()->with('success', 'User berhasil diperbarui');
    }

    /**
     * Delete a user
     */
    public function deleteUser(User $user)
    {
        $user->delete();
        return redirect()->back()->with('success', 'User berhasil dihapus');
    }

    /**
     * Toggle user status
     */
    public function toggleUserStatus(User $user)
    {
        $newStatus = $user->status === 'active' ? 'inactive' : 'active';
        $user->update(['status' => $newStatus]);
        
        return redirect()->back()->with('success', 'Status user berhasil diperbarui');
    }

    /**
     * Display reg_periksa management page
     */
    public function regPeriksa(Request $request)
    {
        $query = \App\Models\RegPeriksa::with(['dokter', 'poliklinik', 'pasien', 'penjab']);

        // Apply filters
        if ($request->filled('tanggal')) {
            $query->whereDate('tgl_registrasi', $request->tanggal);
        }

        if ($request->filled('kd_poli')) {
            $query->where('kd_poli', $request->kd_poli);
        }

        if ($request->filled('status')) {
            $query->where('stts', $request->status);
        }

        $registrations = $query->orderBy('tgl_registrasi', 'desc')
                              ->orderBy('jam_reg', 'desc')
                              ->paginate(15);

        // Get available bookings for transfer
        $availableBookings = BookingPeriksa::where('status', 'confirmed')
                                          ->whereDoesntHave('regPeriksa')
                                          ->orderBy('tanggal', 'desc')
                                          ->get();

        // Get polikliniks for filter
        $polikliniks = \App\Models\Poliklinik::all();

        return view('admin.reg-periksa.index', compact('registrations', 'availableBookings', 'polikliniks'));
    }

    /**
     * Show specific reg_periksa details
     */
    public function showRegPeriksa($noRawat)
    {
        $registration = \App\Models\RegPeriksa::with(['dokter', 'poliklinik', 'pasien', 'penjab'])
                                             ->where('no_rawat', $noRawat)
                                             ->firstOrFail();

        return view('admin.reg-periksa.show', compact('registration'));
    }

    /**
     * Display doctor reviews management page
     */
    public function doctorReviews()
    {
        return Inertia::render('Admin/DoctorReviews');
    }
}