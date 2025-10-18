<template>
  <AdminLayout>
    <!-- Header with actions -->
    <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-6">
      <div>
        <h1 class="text-2xl font-bold text-gray-900">Manajemen Pengguna</h1>
        <p class="text-gray-600 mt-1">Kelola akun admin dan pengguna sistem</p>
      </div>
      <div class="mt-4 sm:mt-0 flex space-x-3">
        <button 
          @click="showFilters = !showFilters"
          class="bg-white border border-rose-200 text-rose-600 px-4 py-2 rounded-xl hover:bg-rose-50 transition-colors flex items-center"
        >
          <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 4a1 1 0 011-1h16a1 1 0 011 1v2.586a1 1 0 01-.293.707l-6.414 6.414a1 1 0 00-.293.707V17l-4 4v-6.586a1 1 0 00-.293-.707L3.293 7.293A1 1 0 013 6.586V4z"/>
          </svg>
          Filter
        </button>
        <button 
          @click="openCreateModal"
          class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-2 rounded-xl hover:from-rose-600 hover:to-pink-600 transition-all shadow-lg flex items-center"
        >
          <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
          </svg>
          Tambah Pengguna
        </button>
      </div>
    </div>

    <!-- Filters -->
    <div v-if="showFilters" class="bg-white rounded-2xl p-6 shadow-sm border border-rose-100 mb-6">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Role</label>
          <select v-model="filters.role" class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            <option value="">Semua Role</option>
            <option value="super_admin">Super Admin</option>
            <option value="admin">Admin</option>
            <option value="staff">Staff</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
          <select v-model="filters.status" class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            <option value="">Semua Status</option>
            <option value="active">Aktif</option>
            <option value="inactive">Tidak Aktif</option>
            <option value="suspended">Suspended</option>
          </select>
        </div>
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-2">Tanggal Bergabung</label>
          <input v-model="filters.joinDate" type="date" class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
        </div>
      </div>
      <div class="flex justify-end mt-4 space-x-3">
        <button @click="resetFilters" class="px-4 py-2 text-gray-600 hover:text-gray-800">Reset</button>
        <button @click="applyFilters" class="bg-rose-500 text-white px-6 py-2 rounded-xl hover:bg-rose-600 transition-colors">Terapkan Filter</button>
      </div>
    </div>

    <!-- Users Table -->
    <div class="bg-white rounded-2xl shadow-sm border border-rose-100 overflow-hidden">
      <div class="px-6 py-4 border-b border-rose-100">
        <div class="flex items-center justify-between">
          <h3 class="text-lg font-semibold text-gray-900">Daftar Pengguna</h3>
          <div class="flex items-center space-x-4">
            <div class="relative">
              <input 
                v-model="searchQuery"
                type="text" 
                placeholder="Cari nama atau email..."
                class="pl-10 pr-4 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900 placeholder-gray-500"
              >
              <svg class="w-4 h-4 text-gray-400 absolute left-3 top-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/>
              </svg>
            </div>
          </div>
        </div>
      </div>

      <div class="overflow-x-auto">
        <table class="w-full">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Pengguna</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Role</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Bergabung</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Login Terakhir</th>
              <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Aksi</th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <tr v-for="user in filteredUsers" :key="user.id" class="hover:bg-gray-50">
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center">
                  <div class="w-10 h-10 bg-gradient-to-r from-rose-500 to-pink-500 rounded-full flex items-center justify-center">
                    <span class="text-white text-sm font-semibold">{{ user.name.charAt(0) }}</span>
                  </div>
                  <div class="ml-4">
                    <div class="text-sm font-medium text-gray-900">{{ user.name }}</div>
                    <div class="text-sm text-gray-500">{{ user.email }}</div>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span :class="[
                  'inline-flex px-2 py-1 text-xs font-semibold rounded-full',
                  user.role === 'super_admin' ? 'bg-purple-100 text-purple-800' :
                  user.role === 'admin' ? 'bg-blue-100 text-blue-800' :
                  'bg-gray-100 text-gray-800'
                ]">
                  {{ getRoleText(user.role) }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <span :class="[
                  'inline-flex px-2 py-1 text-xs font-semibold rounded-full',
                  user.status === 'active' ? 'bg-green-100 text-green-800' :
                  user.status === 'inactive' ? 'bg-gray-100 text-gray-800' :
                  'bg-red-100 text-red-800'
                ]">
                  {{ getStatusText(user.status) }}
                </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {{ formatDate(user.created_at) }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {{ user.last_login ? formatDateTime(user.last_login) : 'Belum pernah' }}
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <div class="flex space-x-2">
                  <button @click="editUser(user)" class="text-rose-600 hover:text-rose-800">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                    </svg>
                  </button>
                  <button 
                    @click="toggleUserStatus(user)" 
                    :class="user.status === 'active' ? 'text-yellow-600 hover:text-yellow-800' : 'text-green-600 hover:text-green-800'"
                  >
                    <svg v-if="user.status === 'active'" class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728L5.636 5.636m12.728 12.728L18.364 5.636M5.636 18.364l12.728-12.728"/>
                    </svg>
                    <svg v-else class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                  </button>
                  <button @click="deleteUser(user)" class="text-red-600 hover:text-red-800">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                    </svg>
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="px-6 py-4 border-t border-rose-100">
        <div class="flex items-center justify-between">
          <div class="text-sm text-gray-500">
            Menampilkan {{ (currentPage - 1) * itemsPerPage + 1 }} - {{ Math.min(currentPage * itemsPerPage, totalItems) }} dari {{ totalItems }} pengguna
          </div>
          <div class="flex space-x-2">
            <button 
              @click="previousPage" 
              :disabled="currentPage === 1"
              class="px-3 py-1 border border-rose-200 rounded-lg text-sm text-gray-600 hover:bg-rose-50 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Sebelumnya
            </button>
            <button 
              v-for="page in visiblePages" 
              :key="page"
              @click="goToPage(page)"
              :class="[
                'px-3 py-1 border rounded-lg text-sm',
                page === currentPage 
                  ? 'bg-rose-500 text-white border-rose-500' 
                  : 'border-rose-200 text-gray-600 hover:bg-rose-50'
              ]"
            >
              {{ page }}
            </button>
            <button 
              @click="nextPage" 
              :disabled="currentPage === totalPages"
              class="px-3 py-1 border border-rose-200 rounded-lg text-sm text-gray-600 hover:bg-rose-50 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Selanjutnya
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Create/Edit Modal -->
    <div v-if="showModal" class="fixed inset-0 z-50 overflow-y-auto">
      <div class="flex items-center justify-center min-h-screen px-4">
        <div class="fixed inset-0 bg-gray-600 bg-opacity-75" @click="closeModal"></div>
        <div class="bg-white rounded-2xl p-6 w-full max-w-md relative">
          <h3 class="text-lg font-semibold text-gray-900 mb-4">
            {{ editingUser ? 'Edit Pengguna' : 'Tambah Pengguna Baru' }}
          </h3>
          
          <form @submit.prevent="saveUser" class="space-y-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Nama Lengkap</label>
              <input v-model="userForm.name" type="text" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Email</label>
              <input v-model="userForm.email" type="email" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            </div>
            
            <div v-if="!editingUser">
              <label class="block text-sm font-medium text-gray-700 mb-2">Password</label>
              <input v-model="userForm.password" type="password" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            </div>
            
            <div v-if="!editingUser">
              <label class="block text-sm font-medium text-gray-700 mb-2">Konfirmasi Password</label>
              <input v-model="userForm.password_confirmation" type="password" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Role</label>
              <select v-model="userForm.role" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
                <option value="">Pilih Role</option>
                <option value="super_admin">Super Admin</option>
                <option value="admin">Admin</option>
                <option value="staff">Staff</option>
              </select>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
              <select v-model="userForm.status" required class="w-full px-3 py-2 border border-rose-200 rounded-xl focus:ring-2 focus:ring-rose-500 focus:border-transparent text-gray-900">
                <option value="active">Aktif</option>
                <option value="inactive">Tidak Aktif</option>
                <option value="suspended">Suspended</option>
              </select>
            </div>
            
            <div class="flex justify-end space-x-3 pt-4">
              <button type="button" @click="closeModal" class="px-4 py-2 text-gray-600 hover:text-gray-800">
                Batal
              </button>
              <button type="submit" class="bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-2 rounded-xl hover:from-rose-600 hover:to-pink-600 transition-all">
                {{ editingUser ? 'Update' : 'Simpan' }}
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import AdminLayout from '@/layouts/AdminLayout.vue'

// State
const showFilters = ref(false)
const showModal = ref(false)
const editingUser = ref(null)
const searchQuery = ref('')
const currentPage = ref(1)
const itemsPerPage = ref(10)

// Filters
const filters = ref({
  role: '',
  status: '',
  joinDate: ''
})

// Form
const userForm = ref({
  name: '',
  email: '',
  password: '',
  password_confirmation: '',
  role: '',
  status: 'active'
})

// Mock data
const users = ref([
  {
    id: 1,
    name: 'Admin Utama',
    email: 'admin@klinikbungas.com',
    role: 'super_admin',
    status: 'active',
    created_at: '2024-01-01',
    last_login: '2024-01-15T10:30:00'
  },
  {
    id: 2,
    name: 'Dr. Bunga Sari',
    email: 'dr.bunga@klinikbungas.com',
    role: 'admin',
    status: 'active',
    created_at: '2024-01-02',
    last_login: '2024-01-15T09:15:00'
  },
  {
    id: 3,
    name: 'Staff Resepsionis',
    email: 'staff@klinikbungas.com',
    role: 'staff',
    status: 'active',
    created_at: '2024-01-03',
    last_login: null
  }
])

// Computed
const filteredUsers = computed(() => {
  let filtered = users.value

  if (searchQuery.value) {
    filtered = filtered.filter(user => 
      user.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
      user.email.toLowerCase().includes(searchQuery.value.toLowerCase())
    )
  }

  if (filters.value.role) {
    filtered = filtered.filter(user => user.role === filters.value.role)
  }

  if (filters.value.status) {
    filtered = filtered.filter(user => user.status === filters.value.status)
  }

  return filtered
})

const totalItems = computed(() => filteredUsers.value.length)
const totalPages = computed(() => Math.ceil(totalItems.value / itemsPerPage.value))

const visiblePages = computed(() => {
  const pages = []
  const start = Math.max(1, currentPage.value - 2)
  const end = Math.min(totalPages.value, currentPage.value + 2)
  
  for (let i = start; i <= end; i++) {
    pages.push(i)
  }
  
  return pages
})

// Methods
const formatDate = (date: string) => {
  return new Date(date).toLocaleDateString('id-ID', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

const formatDateTime = (datetime: string) => {
  return new Date(datetime).toLocaleString('id-ID', {
    year: 'numeric',
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

const getRoleText = (role: string) => {
  const roleMap = {
    super_admin: 'Super Admin',
    admin: 'Admin',
    staff: 'Staff'
  }
  return roleMap[role] || role
}

const getStatusText = (status: string) => {
  const statusMap = {
    active: 'Aktif',
    inactive: 'Tidak Aktif',
    suspended: 'Suspended'
  }
  return statusMap[status] || status
}

const openCreateModal = () => {
  editingUser.value = null
  userForm.value = {
    name: '',
    email: '',
    password: '',
    password_confirmation: '',
    role: '',
    status: 'active'
  }
  showModal.value = true
}

const editUser = (user) => {
  editingUser.value = user
  userForm.value = {
    name: user.name,
    email: user.email,
    password: '',
    password_confirmation: '',
    role: user.role,
    status: user.status
  }
  showModal.value = true
}

const closeModal = () => {
  showModal.value = false
  editingUser.value = null
}

const saveUser = () => {
  if (!editingUser.value && userForm.value.password !== userForm.value.password_confirmation) {
    alert('Password dan konfirmasi password tidak sama!')
    return
  }

  if (editingUser.value) {
    // Update existing user
    const index = users.value.findIndex(u => u.id === editingUser.value.id)
    if (index !== -1) {
      users.value[index] = { 
        ...users.value[index],
        name: userForm.value.name,
        email: userForm.value.email,
        role: userForm.value.role,
        status: userForm.value.status
      }
    }
  } else {
    // Create new user
    const newUser = {
      id: Date.now(),
      name: userForm.value.name,
      email: userForm.value.email,
      role: userForm.value.role,
      status: userForm.value.status,
      created_at: new Date().toISOString().split('T')[0],
      last_login: null
    }
    users.value.unshift(newUser)
  }
  
  closeModal()
}

const toggleUserStatus = (user) => {
  const newStatus = user.status === 'active' ? 'inactive' : 'active'
  const action = newStatus === 'active' ? 'mengaktifkan' : 'menonaktifkan'
  
  if (confirm(`Apakah Anda yakin ingin ${action} pengguna ini?`)) {
    user.status = newStatus
  }
}

const deleteUser = (user) => {
  if (confirm('Apakah Anda yakin ingin menghapus pengguna ini?')) {
    const index = users.value.findIndex(u => u.id === user.id)
    if (index !== -1) {
      users.value.splice(index, 1)
    }
  }
}

const resetFilters = () => {
  filters.value = {
    role: '',
    status: '',
    joinDate: ''
  }
}

const applyFilters = () => {
  showFilters.value = false
}

const previousPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
  }
}

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
  }
}

const goToPage = (page: number) => {
  currentPage.value = page
}
</script>