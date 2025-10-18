# Dokumentasi Penggunaan API BPJS untuk Mengambil Data NIK
## Project SIMANDAI

### Daftar Isi
1. [Gambaran Umum](#gambaran-umum)
2. [Konfigurasi API](#konfigurasi-api)
3. [Endpoint yang Tersedia](#endpoint-yang-tersedia)
4. [Header API yang Diperlukan](#header-api-yang-diperlukan)
5. [Cara Penggunaan](#cara-penggunaan)
6. [Contoh Response](#contoh-response)
7. [Error Handling](#error-handling)
8. [Troubleshooting](#troubleshooting)

---

## Gambaran Umum

Project SIMANDAI mengintegrasikan API BPJS VClaim untuk mengambil data peserta berdasarkan NIK (Nomor Induk Kependudukan). Sistem ini memungkinkan verifikasi data pasien dan pengambilan informasi rujukan BPJS secara otomatis.

### Fitur Utama:
- ✅ Cek data peserta BPJS berdasarkan NIK
- ✅ Cek data peserta berdasarkan nomor kartu BPJS
- ✅ Ambil data rujukan aktif
- ✅ Verifikasi status kepesertaan
- ✅ Cek denda administrasi
- ✅ Manajemen surat kontrol (SPRI)

---

## Konfigurasi API

### File Konfigurasi
Konfigurasi API BPJS terdapat di file: `application/models/Bpjs_model.php`

```php
private $api_url = 'https://apijkn.bpjs-kesehatan.go.id/vclaim-rest/';
private $consid = '17432';
private $secretkey = '3nK53BBE23';
private $userkey = '1823bb1d8015aee02180ee12d2af2b2c';
```

### Persyaratan Sistem:
- PHP 7.4+
- CodeIgniter 3.x
- Library LZString untuk dekompresi response
- SSL/TLS support untuk HTTPS
- Database MySQL untuk logging

---

## Endpoint yang Tersedia

### 1. Cek Data Peserta berdasarkan NIK
**Endpoint Internal:** `POST /bpjs/check_nik`
**API BPJS:** `GET /Peserta/nik/{nik}/tglSEP/{tanggal}`

### 2. Cek Data Peserta berdasarkan Nomor Kartu
**Endpoint Internal:** `POST /bpjs/check_kartu`
**API BPJS:** `GET /Peserta/nokartu/{nomor_kartu}/tglSEP/{tanggal}`

### 3. Cek Rujukan BPJS
**Endpoint Internal:** `POST /bpjs/check_rujukan`
**API BPJS:** `GET /Rujukan/List/Peserta/{nomor_kartu}`

### 4. Cek Denda Administrasi
**Endpoint Internal:** `POST /bpjs/check_denda`
**API BPJS:** `GET /monitoring/HistoriPelayanan/NoKartu/{nomor_kartu}/tglAwal/{tgl_awal}/tglAkhir/{tgl_akhir}`

---

## Header API yang Diperlukan

Setiap request ke API BPJS memerlukan header berikut:

```php
$headers = [
    'X-cons-id: 17432',                    // Consumer ID
    'X-timestamp: ' . $timestamp,          // Unix timestamp
    'X-signature: ' . $signature,          // HMAC SHA256 signature
    'user_key: 1823bb1d8015aee02180ee12d2af2b2c',  // User key
    'Accept: application/json',
    'Content-Type: application/x-www-form-urlencoded'
];
```

### Cara Generate Signature:
```php
private function _generate_signature($timestamp) {
    $key = $this->consid . '&' . $timestamp;
    $signature = base64_encode(hash_hmac('sha256', $key, $this->secretkey, true));
    return $signature;
}
```

### Cara Generate Timestamp:
```php
private function _generate_timestamp() {
    date_default_timezone_set('UTC');
    $timestamp = strval(time() - strtotime("1970-01-01 00:00:00"));
    return $timestamp;
}
```

---

## Cara Penggunaan

### 1. Menggunakan Endpoint Check NIK

#### Frontend (JavaScript/AJAX):
```javascript
$.ajax({
    url: '<?= site_url('bpjs/check_nik') ?>',
    type: 'POST',
    data: {
        nik: '3271234567890001',
        tgl_sep: '2024-01-15'
    },
    success: function(response) {
        if (response.metaData.code === '200') {
            console.log('Data peserta:', response.response.peserta);
        }
    },
    error: function(xhr, status, error) {
        console.error('Error:', error);
    }
});
```

#### Backend (PHP Controller):
```php
public function check_nik() {
    try {
        $nik = $this->input->post('nik');
        $tglSEP = $this->input->post('tgl_sep');

        if (empty($nik)) {
            throw new Exception('NIK tidak boleh kosong');
        }

        if (empty($tglSEP)) {
            throw new Exception('Tanggal SEP tidak boleh kosong');
        }

        $response = $this->Bpjs_model->check_peserta_by_nik($nik, $tglSEP);
        
        $this->output
            ->set_content_type('application/json')
            ->set_output(json_encode($response));

    } catch (Exception $e) {
        $this->output
            ->set_status_header(500)
            ->set_content_type('application/json')
            ->set_output(json_encode([
                'metaData' => [
                    'code' => '500',
                    'message' => $e->getMessage()
                ]
            ]));
    }
}
```

### 2. Menggunakan Endpoint Check Kartu BPJS

```javascript
$.ajax({
    url: '<?= site_url('bpjs/check_kartu') ?>',
    type: 'POST',
    data: {
        nomor_kartu: '0001234567890',
        tgl_sep: '2024-01-15'
    },
    success: function(response) {
        if (response.metaData.code === '200') {
            console.log('Data peserta:', response.response.peserta);
        }
    }
});
```

### 3. Menggunakan Endpoint Check Rujukan

```javascript
$.ajax({
    url: '<?= site_url('bpjs/check_rujukan') ?>',
    type: 'POST',
    data: {
        nomor_kartu: '0001234567890'
    },
    success: function(response) {
        if (response.status === true) {
            console.log('Data rujukan:', response.data.rujukan);
        }
    }
});
```

---

## Contoh Response

### Response Sukses - Check NIK:
```json
{
    "metaData": {
        "code": "200",
        "message": "OK"
    },
    "response": {
        "peserta": {
            "nik": "3271234567890001",
            "noKartu": "0001234567890",
            "nama": "JOHN DOE",
            "pisa": "1",
            "sex": "L",
            "tglLahir": "1990-01-01",
            "tglCetakKartu": "2020-01-01",
            "tglTAT": "2025-01-01",
            "tglTMT": "2020-01-01",
            "umur": {
                "umurSekarang": "34 tahun, 0 bulan, 14 hari",
                "umurSaatPelayanan": "34 tahun, 0 bulan, 14 hari"
            },
            "statusPeserta": {
                "keterangan": "AKTIF",
                "kode": "0"
            },
            "hakKelas": {
                "keterangan": "KELAS III",
                "kode": "3"
            },
            "jenisPeserta": {
                "keterangan": "PBI",
                "kode": "1"
            },
            "provUmum": {
                "kdProvider": "0301R001",
                "nmProvider": "RSUD H. ABDUL AZIZ MARABAHAN"
            }
        }
    }
}
```

### Response Sukses - Check Rujukan:
```json
{
    "status": true,
    "message": "Data rujukan berhasil ditemukan",
    "data": {
        "rujukan": [
            {
                "noKunjungan": "030108240115000001",
                "noRujukan": "0301R0010124U0000001",
                "tglKunjungan": "2024-01-15",
                "pelayanan": {
                    "kode": "2",
                    "nama": "Rawat Jalan"
                },
                "peserta": {
                    "noKartu": "0001234567890",
                    "nama": "JOHN DOE",
                    "nik": "3271234567890001"
                },
                "poliRujukan": {
                    "kode": "INT",
                    "nama": "POLI PENYAKIT DALAM"
                },
                "provPerujuk": {
                    "kode": "0301R001",
                    "nama": "RSUD H. ABDUL AZIZ MARABAHAN"
                },
                "diagnosa": {
                    "kode": "Z711",
                    "nama": "Person with feared complaint in whom no diagnosis is made"
                },
                "tglKeluhan": "2024-01-15",
                "keluhan": "Kontrol rutin"
            }
        ]
    }
}
```

### Response Error:
```json
{
    "metaData": {
        "code": "201",
        "message": "Data tidak ditemukan"
    }
}
```

---

## Error Handling

### Kode Error Umum:
- **200**: Sukses
- **201**: Data tidak ditemukan
- **400**: Bad Request (parameter tidak valid)
- **401**: Unauthorized (signature tidak valid)
- **500**: Internal Server Error

### Contoh Error Handling di Frontend:
```javascript
$.ajax({
    url: '<?= site_url('bpjs/check_nik') ?>',
    type: 'POST',
    data: { nik: nik, tgl_sep: tgl_sep },
    success: function(response) {
        if (response.metaData.code === '200') {
            // Sukses - tampilkan data
            displayPatientData(response.response.peserta);
        } else if (response.metaData.code === '201') {
            // Data tidak ditemukan
            Swal.fire('Info', 'Data peserta tidak ditemukan', 'info');
        } else {
            // Error lainnya
            Swal.fire('Error', response.metaData.message, 'error');
        }
    },
    error: function(xhr, status, error) {
        Swal.fire('Error', 'Terjadi kesalahan sistem', 'error');
    }
});
```

---

## Troubleshooting

### 1. Error "Signature tidak valid"
**Penyebab:** Timestamp atau signature generation salah
**Solusi:** 
- Pastikan timezone UTC
- Periksa format timestamp
- Pastikan secret key benar

### 2. Error "Data tidak ditemukan"
**Penyebab:** NIK/Nomor kartu tidak terdaftar atau tidak aktif
**Solusi:**
- Verifikasi NIK/nomor kartu
- Cek status kepesertaan BPJS
- Pastikan format input benar (NIK: 16 digit, Kartu: 13 digit)

### 3. Error "Timeout"
**Penyebab:** Koneksi ke server BPJS lambat
**Solusi:**
- Tingkatkan timeout CURL
- Coba request ulang
- Periksa koneksi internet

### 4. Response Encrypted/Tidak Terbaca
**Penyebab:** Response dari BPJS terenkripsi
**Solusi:**
- Pastikan library LZString tersedia
- Periksa fungsi decrypt
- Gunakan timestamp yang sama untuk decrypt

### 5. Error Database
**Penyebab:** Gagal menyimpan log API
**Solusi:**
- Periksa koneksi database
- Pastikan tabel `bpjs_api_logs` ada
- Periksa permission database

---

## Catatan Penting

1. **Rate Limiting**: API BPJS memiliki batasan request per menit
2. **Security**: Jangan expose credential di frontend
3. **Logging**: Semua request API dicatat untuk audit
4. **Backup**: Gunakan endpoint lama sebagai fallback
5. **Validation**: Selalu validasi input sebelum request ke API

---

## Kontak Support

Untuk pertanyaan teknis atau masalah integrasi:
- **Developer**: Tim IT RSUD H. Abdul Aziz Marabahan
- **Email**: it@rsudmarabahan.go.id
- **Dokumentasi BPJS**: https://dvlp.bpjs-kesehatan.go.id/

---

*Dokumentasi ini dibuat untuk memudahkan penggunaan dan maintenance sistem BPJS di Project SIMANDAI*