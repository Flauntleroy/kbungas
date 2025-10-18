/**
 * NIK (Nomor Induk Kependudukan) Service
 * Service untuk integrasi dengan API BPJS VClaim
 */

export interface NikData {
  nik: string
  nama?: string
  jenis_kelamin?: string
  tanggal_lahir?: string
  usia?: string
  provinsi?: string
  kota_kabupaten?: string
  kecamatan?: string
  kelurahan?: string
  kodepos?: string
  noKartu?: string
  statusPeserta?: string
  hakKelas?: string
  jenisPeserta?: string
}

export interface BpjsApiResponse {
  metaData: {
    code: string
    message: string
  }
  response?: {
    peserta?: {
      nik: string
      noKartu: string
      nama: string
      pisa: string
      sex: string
      tglLahir: string
      tglCetakKartu: string
      tglTAT: string
      tglTMT: string
      umur: {
        umurSekarang: string
        umurSaatPelayanan: string
      }
      statusPeserta: {
        keterangan: string
        kode: string
      }
      hakKelas: {
        keterangan: string
        kode: string
      }
      jenisPeserta: {
        keterangan: string
        kode: string
      }
      provUmum: {
        kdProvider: string
        nmProvider: string
      }
    }
  }
}

export class NikService {
  private static readonly API_BASE_URL = '/api/bpjs'

  /**
   * Validate NIK format
   * NIK must be exactly 16 digits
   */
  static validateNik(nik: string): boolean {
    const nikRegex = /^[0-9]{16}$/
    return nikRegex.test(nik)
  }

  /**
   * Clean NIK input by removing non-digit characters
   */
  static cleanNik(nik: string): string {
    return nik.replace(/\D/g, '')
  }

  /**
   * Fetch NIK data from BPJS VClaim API
   */
  static async fetchNikData(nik: string): Promise<NikData | null> {
    if (!this.validateNik(nik)) {
      throw new Error('Format NIK tidak valid. NIK harus terdiri dari 16 digit angka.')
    }

    try {
      const response = await fetch(`${this.API_BASE_URL}/check-nik`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
        },
        body: JSON.stringify({
          nik: nik,
          tgl_sep: new Date().toISOString().split('T')[0] // Format: YYYY-MM-DD
        })
      })

      if (!response.ok) {
        if (response.status === 401) {
          throw new Error('Tidak memiliki akses untuk menggunakan layanan ini')
        } else if (response.status === 429) {
          throw new Error('Terlalu banyak permintaan. Silakan coba lagi nanti.')
        } else if (response.status >= 500) {
          throw new Error('Server sedang bermasalah. Silakan coba lagi nanti.')
        }
        throw new Error(`HTTP Error: ${response.status}`)
      }

      const data: BpjsApiResponse = await response.json()
      
      if (data.metaData.code === '200') {
        const parsedData = this.parseBpjsResponse(data)
        if (!parsedData) {
          throw new Error('NIK valid tetapi tidak terdaftar sebagai peserta BPJS aktif')
        }
        return parsedData
      } else if (data.metaData.code === '201') {
        throw new Error('Data peserta BPJS tidak ditemukan untuk NIK tersebut')
      } else {
        throw new Error(data.metaData.message || 'Gagal mengambil data dari BPJS')
      }

    } catch (error) {
      if (error instanceof TypeError && error.message.includes('fetch')) {
        throw new Error('Tidak dapat terhubung ke server. Periksa koneksi internet Anda.')
      }
      throw error
    }
  }

  /**
   * Parse BPJS API response and extract relevant data
   */
  private static parseBpjsResponse(response: BpjsApiResponse): NikData | null {
    if (!response.response?.peserta) {
      return null
    }

    const peserta = response.response.peserta
    const nikData: NikData = {
      nik: peserta.nik,
      nama: peserta.nama,
      jenis_kelamin: peserta.sex === 'L' ? 'Laki-laki' : 'Perempuan',
      tanggal_lahir: peserta.tglLahir,
      usia: peserta.umur.umurSekarang,
      noKartu: peserta.noKartu,
      statusPeserta: peserta.statusPeserta.keterangan,
      hakKelas: peserta.hakKelas.keterangan,
      jenisPeserta: peserta.jenisPeserta.keterangan,
      provinsi: peserta.provUmum.nmProvider
    }

    // Return null if no name found
    if (!nikData.nama) {
      return null
    }

    return nikData
  }

  /**
   * Format NIK for display (add separators)
   */
  static formatNikForDisplay(nik: string): string {
    if (!nik || nik.length !== 16) return nik
    
    // Format: XX.XXXX.XXXXXX.XXXX
    return `${nik.slice(0, 2)}.${nik.slice(2, 6)}.${nik.slice(6, 12)}.${nik.slice(12, 16)}`
  }

  /**
   * Get province name from NIK code
   */
  static getProvinceFromNik(nik: string): string | null {
    if (!this.validateNik(nik)) return null
    
    const provinceCode = nik.slice(0, 2)
    const provinceMap: Record<string, string> = {
      '11': 'ACEH',
      '12': 'SUMATERA UTARA',
      '13': 'SUMATERA BARAT',
      '14': 'RIAU',
      '15': 'JAMBI',
      '16': 'SUMATERA SELATAN',
      '17': 'BENGKULU',
      '18': 'LAMPUNG',
      '19': 'KEPULAUAN BANGKA BELITUNG',
      '21': 'KEPULAUAN RIAU',
      '31': 'DKI JAKARTA',
      '32': 'JAWA BARAT',
      '33': 'JAWA TENGAH',
      '34': 'DI YOGYAKARTA',
      '35': 'JAWA TIMUR',
      '36': 'BANTEN',
      '51': 'BALI',
      '52': 'NUSA TENGGARA BARAT',
      '53': 'NUSA TENGGARA TIMUR',
      '61': 'KALIMANTAN BARAT',
      '62': 'KALIMANTAN TENGAH',
      '63': 'KALIMANTAN SELATAN',
      '64': 'KALIMANTAN TIMUR',
      '65': 'KALIMANTAN UTARA',
      '71': 'SULAWESI UTARA',
      '72': 'SULAWESI TENGAH',
      '73': 'SULAWESI SELATAN',
      '74': 'SULAWESI TENGGARA',
      '75': 'GORONTALO',
      '76': 'SULAWESI BARAT',
      '81': 'MALUKU',
      '82': 'MALUKU UTARA',
      '91': 'PAPUA BARAT',
      '94': 'PAPUA'
    }
    
    return provinceMap[provinceCode] || null
  }
}