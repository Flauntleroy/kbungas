import Swal from 'sweetalert2'

export const useSweetAlert = () => {
  // Base configuration for consistent styling
  const baseConfig = {
    customClass: {
      popup: 'rounded-2xl shadow-2xl',
      title: 'text-gray-900 font-semibold text-lg',
      content: 'text-gray-600 text-sm',
      confirmButton: 'bg-gradient-to-r from-rose-500 to-pink-500 text-white px-6 py-2 rounded-xl hover:from-rose-600 hover:to-pink-600 transition-all font-medium',
      cancelButton: 'bg-gray-100 text-gray-700 px-6 py-2 rounded-xl hover:bg-gray-200 transition-all font-medium mr-3',
      denyButton: 'bg-red-100 text-red-700 px-6 py-2 rounded-xl hover:bg-red-200 transition-all font-medium mr-3'
    },
    buttonsStyling: false,
    showClass: {
      popup: 'animate__animated animate__fadeInDown animate__faster'
    },
    hideClass: {
      popup: 'animate__animated animate__fadeOutUp animate__faster'
    }
  }

  // Success alert
  const showSuccess = (title: string, text?: string) => {
    return Swal.fire({
      ...baseConfig,
      icon: 'success',
      title,
      text,
      iconColor: '#10b981',
      timer: 3000,
      timerProgressBar: true,
      showConfirmButton: false
    })
  }

  // Error alert
  const showError = (title: string, text?: string) => {
    return Swal.fire({
      ...baseConfig,
      icon: 'error',
      title,
      text,
      iconColor: '#ef4444',
      confirmButtonText: 'Tutup'
    })
  }

  // Warning alert
  const showWarning = (title: string, text?: string) => {
    return Swal.fire({
      ...baseConfig,
      icon: 'warning',
      title,
      text,
      iconColor: '#f59e0b',
      confirmButtonText: 'OK'
    })
  }

  // Info alert
  const showInfo = (title: string, text?: string) => {
    return Swal.fire({
      ...baseConfig,
      icon: 'info',
      title,
      text,
      iconColor: '#3b82f6',
      confirmButtonText: 'OK'
    })
  }

  // Confirmation dialog
  const showConfirmation = (title: string, text?: string, confirmText = 'Ya, Lanjutkan', cancelText = 'Batal') => {
    return Swal.fire({
      ...baseConfig,
      icon: 'question',
      title,
      text,
      iconColor: '#6366f1',
      showCancelButton: true,
      confirmButtonText: confirmText,
      cancelButtonText: cancelText,
      reverseButtons: true
    })
  }

  // Delete confirmation (special case with red styling)
  const showDeleteConfirmation = (title: string, text?: string) => {
    return Swal.fire({
      ...baseConfig,
      icon: 'warning',
      title,
      text,
      iconColor: '#ef4444',
      showCancelButton: true,
      confirmButtonText: 'Ya, Hapus',
      cancelButtonText: 'Batal',
      reverseButtons: true,
      customClass: {
        ...baseConfig.customClass,
        confirmButton: 'bg-gradient-to-r from-red-500 to-red-600 text-white px-6 py-2 rounded-xl hover:from-red-600 hover:to-red-700 transition-all font-medium'
      }
    })
  }

  // Loading alert
  const showLoading = (title: string, text?: string) => {
    return Swal.fire({
      ...baseConfig,
      title,
      text,
      allowOutsideClick: false,
      allowEscapeKey: false,
      showConfirmButton: false,
      didOpen: () => {
        Swal.showLoading()
      }
    })
  }

  // Close any open alert
  const close = () => {
    Swal.close()
  }

  // Toast notification (for quick feedback)
  const showToast = (title: string, icon: 'success' | 'error' | 'warning' | 'info' = 'success') => {
    const Toast = Swal.mixin({
      toast: true,
      position: 'top-end',
      showConfirmButton: false,
      timer: 3000,
      timerProgressBar: true,
      customClass: {
        popup: 'rounded-xl shadow-lg',
        title: 'text-sm font-medium'
      },
      didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer)
        toast.addEventListener('mouseleave', Swal.resumeTimer)
      }
    })

    return Toast.fire({
      icon,
      title,
      iconColor: {
        success: '#10b981',
        error: '#ef4444',
        warning: '#f59e0b',
        info: '#3b82f6'
      }[icon]
    })
  }

  return {
    showSuccess,
    showError,
    showWarning,
    showInfo,
    showConfirmation,
    showDeleteConfirmation,
    showLoading,
    showToast,
    close
  }
}