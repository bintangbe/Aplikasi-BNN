# Fitur Manajemen Lembaga Rehabilitasi (CRUD Lengkap)

## Deskripsi
Fitur lengkap untuk mengelola lembaga rehabilitasi yang mencakup:
- **Create**: Tambah lembaga baru
- **Read**: Lihat daftar dan detail lembaga  
- **Update**: Edit informasi dan kapasitas lembaga
- **Delete**: Hapus lembaga (tersedia di daftar)

## File yang Dibuat/Dimodifikasi

### 1. `detail_lembaga_screen.dart` (Dimodifikasi)
- Diubah dari StatelessWidget menjadi StatefulWidget
- Ditambahkan tombol edit di header
- Data lembaga sekarang dinamis dan dapat diupdate
- Helper methods untuk menghitung kapasitas menggunakan data real-time

### 2. `edit_lembaga_screen.dart` (Baru)
- Form lengkap untuk mengedit informasi lembaga
- Validasi input untuk semua field
- Validasi khusus untuk kapasitas (tidak boleh melebihi maksimal)
- UI yang konsisten dengan design system aplikasi

### 3. `tambah_lembaga_screen.dart` (Baru)
- Form untuk menambah lembaga baru
- Fitur pilih gambar dari galeri preset
- Validasi lengkap untuk semua input
- Generate ID unik untuk lembaga baru

### 4. `daftar_lembaga_screen.dart` (Dimodifikasi)
- Ditambahkan tombol "Tambah Lembaga" di header
- Ditambahkan tombol "Edit" di setiap card lembaga
- Integrasi dengan semua fitur CRUD
- Real-time update setelah add/edit

### 5. `example_usage_lembaga.dart` (Dimodifikasi)
- Update untuk mendemonstrasikan semua fitur
- Tombol akses ke daftar lembaga dan detail lembaga
- Daftar fitur yang tersedia

## Struktur Data Lembaga

```dart
Map<String, dynamic> lembagaData = {
  'id': 'string',                    // ID unik lembaga
  'name': 'string',                  // Nama lembaga
  'alamatLengkap': 'string',         // Alamat lengkap
  'nomorTelepon': 'string',          // Nomor telepon
  'jamOperasional': 'string',        // Jam operasional
  'image': 'string',                 // Path gambar lembaga
  
  // Data kapasitas
  'rawatInapLaki': int,              // Jumlah pasien laki-laki saat ini
  'rawatInapPerempuan': int,         // Jumlah pasien perempuan saat ini
  'rawatJalan': int,                 // Jumlah pasien rawat jalan
  'pascaRehab': int,                 // Jumlah peserta pasca rehab
  'kapasitasLaki': int,              // Kapasitas maksimal laki-laki
  'kapasitasPerempuan': int,         // Kapasitas maksimal perempuan
};
```

## Fitur Utama

### 1. Daftar Lembaga (`daftar_lembaga_screen.dart`)
- Menampilkan semua lembaga dalam format card
- Tombol "Tambah Lembaga" di header
- Tombol "Edit" dan "Detail" di setiap card
- Search dan filter lembaga
- Konfirmasi hapus lembaga

### 2. Tambah Lembaga Baru (`tambah_lembaga_screen.dart`)
- Form lengkap untuk input data lembaga
- Pilihan gambar dari galeri preset
- Validasi input komprehensif
- Auto-generate ID unik

### 3. Halaman Detail Lembaga (`detail_lembaga_screen.dart`)
- Menampilkan informasi lengkap lembaga
- Menampilkan kapasitas real-time dengan perhitungan otomatis
- Tombol edit untuk mengakses form edit
- Data diupdate secara dinamis setelah edit

### 4. Halaman Edit Lembaga (`edit_lembaga_screen.dart`)
- Form lengkap untuk semua informasi lembaga
- Validasi input untuk memastikan data valid
- Validasi kapasitas untuk mencegah overbooking
- Konfirmasi sukses setelah save

### 5. Validasi
- **Informasi Lembaga**: Semua field wajib diisi
- **Kapasitas**: 
  - Harus berupa angka
  - Kapasitas maksimal harus > 0
  - Jumlah terisi tidak boleh melebihi kapasitas maksimal
- **Gambar**: Pilihan dari preset atau upload custom

## Cara Penggunaan

### 1. Akses Daftar Lembaga
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const DaftarLembagaScreen(),
  ),
);
```

### 2. Tambah Lembaga Baru
- Di halaman daftar lembaga, klik tombol "+" di header
- Isi semua field yang diperlukan (yang bertanda *)
- Pilih gambar untuk lembaga
- Klik "Tambah Lembaga"
- Data akan otomatis ditambahkan ke daftar

### 3. Edit Lembaga Existing
- Di halaman daftar, klik tombol "Edit" pada card lembaga
- Atau di halaman detail, klik tombol edit (ikon pensil) di header
- Modifikasi data yang diinginkan
- Klik "Simpan Perubahan"
- Data akan terupdate dan kembali ke halaman sebelumnya

### 4. Lihat Detail Lembaga
- Di halaman daftar, klik tombol "Detail" pada card lembaga
- Kapasitas total dan sisa dihitung otomatis
- Data yang ditampilkan selalu real-time
- Dapat mengakses fitur edit dari halaman ini

## UI/UX Features

### 1. Design Consistency
- Menggunakan color scheme aplikasi (Biru gradient)
- Typography yang konsisten
- Shadow dan border radius seragam

### 2. User Experience
- Form validation dengan pesan error yang jelas
- Loading states dan feedback visual
- Konfirmasi dialog setelah save
- Smooth navigation antar screen

### 3. Responsive Design
- Layout yang adaptive
- Proper spacing dan padding
- Mobile-friendly design

## Testing Data
Gunakan `LembagaDataHelper.getSampleData()` untuk mendapatkan data sample yang sudah terstruktur dengan baik untuk testing fitur ini.

## Flow Diagram Fitur

```
Daftar Lembaga Screen
├── Tambah Lembaga (+) → Form Tambah → Simpan → Kembali ke Daftar
├── Edit Lembaga (Edit) → Form Edit → Simpan → Kembali ke Daftar  
├── Detail Lembaga (Detail) → Detail Screen
│   └── Edit dari Detail → Form Edit → Simpan → Kembali ke Detail
└── Hapus Lembaga (Delete) → Konfirmasi → Hapus → Update Daftar
```

## Struktur Navigasi

1. **Entry Point**: `DaftarLembagaScreen` - Halaman utama
2. **Add Flow**: Daftar → Tambah → Daftar (updated)
3. **Edit Flow**: Daftar → Edit → Daftar (updated)
4. **Detail Flow**: Daftar → Detail → (optional) Edit → Detail (updated)

## Integrasi dengan Backend
Semua fitur siap untuk diintegrasikan dengan backend API. Cukup ganti logika save/update/delete di method-method berikut:

### Tambah Lembaga
```dart
// Di _saveLembaga() method pada TambahLembagaScreen
try {
  final response = await ApiService.createLembaga(newLembagaData);
  if (response.success) {
    Navigator.pop(context, response.data);
  }
} catch (e) {
  // Handle error
}
```

### Edit Lembaga  
```dart
// Di _saveChanges() method pada EditLembagaScreen
try {
  final response = await ApiService.updateLembaga(updatedData);
  if (response.success) {
    Navigator.pop(context, updatedData);
  }
} catch (e) {
  // Handle error
}
```

### Hapus Lembaga
```dart
// Di _showDeleteConfirmation() method pada DaftarLembagaScreen
try {
  final response = await ApiService.deleteLembaga(lembaga['id']);
  if (response.success) {
    setState(() {
      _lembagaList.removeAt(index);
    });
  }
} catch (e) {
  // Handle error
}
```
