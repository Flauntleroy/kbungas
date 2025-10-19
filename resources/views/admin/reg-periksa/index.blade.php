@extends('layouts.admin')

@section('title', 'Registrasi Periksa')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Data Registrasi Periksa</h3>
                    <div class="card-tools">
                        <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#transferModal">
                            <i class="fas fa-exchange-alt"></i> Transfer dari Booking
                        </button>
                        <button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#addModal">
                            <i class="fas fa-plus"></i> Tambah Registrasi
                        </button>
                    </div>
                </div>
                
                <div class="card-body">
                    <!-- Filter Form -->
                    <form method="GET" class="mb-3">
                        <div class="row">
                            <div class="col-md-3">
                                <input type="date" name="tanggal" class="form-control" value="{{ request('tanggal') }}" placeholder="Tanggal">
                            </div>
                            <div class="col-md-3">
                                <select name="kd_poli" class="form-control">
                                    <option value="">Semua Poliklinik</option>
                                    @foreach($polikliniks as $poli)
                                        <option value="{{ $poli->kd_poli }}" {{ request('kd_poli') == $poli->kd_poli ? 'selected' : '' }}>
                                            {{ $poli->nm_poli }}
                                        </option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select name="status" class="form-control">
                                    <option value="">Semua Status</option>
                                    <option value="Belum" {{ request('status') == 'Belum' ? 'selected' : '' }}>Belum</option>
                                    <option value="Sudah" {{ request('status') == 'Sudah' ? 'selected' : '' }}>Sudah</option>
                                    <option value="Batal" {{ request('status') == 'Batal' ? 'selected' : '' }}>Batal</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-info">
                                    <i class="fas fa-search"></i> Filter
                                </button>
                                <a href="{{ route('admin.reg-periksa.index') }}" class="btn btn-secondary">
                                    <i class="fas fa-undo"></i> Reset
                                </a>
                            </div>
                        </div>
                    </form>

                    <!-- Data Table -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>No. Rawat</th>
                                    <th>No. Reg</th>
                                    <th>Tanggal</th>
                                    <th>Jam</th>
                                    <th>No. RM</th>
                                    <th>Nama Pasien</th>
                                    <th>Poliklinik</th>
                                    <th>Dokter</th>
                                    <th>Status</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($registrations as $reg)
                                <tr>
                                    <td>{{ $reg->no_rawat }}</td>
                                    <td>{{ $reg->no_reg }}</td>
                                    <td>{{ $reg->tgl_registrasi ? \Carbon\Carbon::parse($reg->tgl_registrasi)->format('d/m/Y') : '-' }}</td>
                                    <td>{{ $reg->jam_reg }}</td>
                                    <td>{{ $reg->no_rkm_medis }}</td>
                                    <td>{{ $reg->pasien->nm_pasien ?? '-' }}</td>
                                    <td>{{ $reg->poliklinik->nm_poli ?? '-' }}</td>
                                    <td>{{ $reg->dokter->nm_dokter ?? '-' }}</td>
                                    <td>
                                        <span class="badge badge-{{ $reg->stts == 'Sudah' ? 'success' : ($reg->stts == 'Batal' ? 'danger' : 'warning') }}">
                                            {{ $reg->stts }}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-info btn-sm" onclick="viewRegistration('{{ $reg->no_rawat }}')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <button type="button" class="btn btn-warning btn-sm" onclick="editRegistration('{{ $reg->no_rawat }}')">
                                                <i class="fas fa-edit"></i>
                                            </button>
                                            <button type="button" class="btn btn-danger btn-sm" onclick="deleteRegistration('{{ $reg->no_rawat }}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                @empty
                                <tr>
                                    <td colspan="10" class="text-center">Tidak ada data registrasi</td>
                                </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    {{ $registrations->links() }}
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Transfer Modal -->
<div class="modal fade" id="transferModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Transfer Booking ke Registrasi Periksa</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form id="transferForm">
                    <div class="form-group">
                        <label>Pilih Booking untuk Transfer:</label>
                        <select name="booking_ids[]" class="form-control select2" multiple required>
                            @foreach($availableBookings as $booking)
                                <option value="{{ $booking->no_booking }}">
                                    {{ $booking->no_booking }} - {{ $booking->nama }} ({{ $booking->tanggal }})
                                </option>
                            @endforeach
                        </select>
                    </div>
                    <div class="form-group">
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="validateOnly" name="validate_only">
                            <label class="custom-control-label" for="validateOnly">
                                Validasi saja (tidak melakukan transfer)
                            </label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Batal</button>
                <button type="button" class="btn btn-primary" onclick="processTransfer()">
                    <i class="fas fa-exchange-alt"></i> Proses Transfer
                </button>
            </div>
        </div>
    </div>
</div>

@endsection

@push('scripts')
<script>
function processTransfer() {
    const form = document.getElementById('transferForm');
    const formData = new FormData(form);
    const bookingIds = Array.from(form.querySelectorAll('select[name="booking_ids[]"] option:checked')).map(option => option.value);
    const validateOnly = form.querySelector('#validateOnly').checked;

    if (bookingIds.length === 0) {
        alert('Pilih minimal satu booking untuk ditransfer');
        return;
    }

    // Show loading
    const btn = event.target;
    const originalText = btn.innerHTML;
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Memproses...';
    btn.disabled = true;

    fetch('/api/reg-periksa/transfer-multiple', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({
            booking_ids: bookingIds,
            validate_only: validateOnly
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert(`Transfer berhasil! ${data.transferred_count} booking berhasil ditransfer.`);
            location.reload();
        } else {
            alert(`Transfer gagal: ${data.message}`);
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Terjadi kesalahan saat memproses transfer');
    })
    .finally(() => {
        btn.innerHTML = originalText;
        btn.disabled = false;
    });
}

function viewRegistration(noRawat) {
    // Implementation for viewing registration details
    window.open(`/admin/reg-periksa/${noRawat}`, '_blank');
}

function editRegistration(noRawat) {
    // Implementation for editing registration
    window.location.href = `/admin/reg-periksa/${noRawat}/edit`;
}

function deleteRegistration(noRawat) {
    if (confirm('Apakah Anda yakin ingin menghapus registrasi ini?')) {
        fetch(`/api/reg-periksa/${noRawat}`, {
            method: 'DELETE',
            headers: {
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
            }
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Registrasi berhasil dihapus');
                location.reload();
            } else {
                alert(`Gagal menghapus: ${data.message}`);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Terjadi kesalahan saat menghapus registrasi');
        });
    }
}

// Initialize Select2
$(document).ready(function() {
    $('.select2').select2({
        placeholder: 'Pilih booking...',
        allowClear: true
    });
});
</script>
@endpush