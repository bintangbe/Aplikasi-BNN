# Integrasi Peta Persebaran dengan Data Rehabilitasi

## Fitur yang Telah Diimplementasi

### 1. Model Data Rehabilitasi (`lib/models/rehabilitasi_model.dart`)
- Model komprehensif untuk data rehabilitasi
- Menyimpan informasi: nama, NIK, alamat, status, lembaga rehab, tanggal, koordinat
- Dukungan serialisasi untuk penyimpanan lokal

### 2. Service Rehabilitasi (`lib/services/rehabilitasi_service.dart`)
- Manajemen data rehabilitasi dengan SharedPreferences
- Geocoding otomatis berdasarkan alamat (mapping area Surabaya)
- CRUD operations: Create, Read, Update, Delete
- Pencarian dan filter data
- 35+ lokasi area Surabaya yang telah dipetakan

### 3. Peta Persebaran Terintegrasi (`lib/screens/admin/admin_persebaran.dart`)
- **Markers Dinamis**: Titik lokasi otomatis berdasarkan data rehabilitasi
- **Color Coding**: 
  - 🟢 Hijau = Status "Selesai"
  - 🟠 Orange = Status "Masa Rehab" 
  - 🔴 Merah = Pusat BNN
- **Info Popup**: Klik marker untuk melihat detail data pasien
- **Legend**: Keterangan warna marker
- **Refresh Button**: Memuat ulang data terbaru
- **Loading State**: Indikator loading saat memuat data

### 4. Manajemen Data Rehabilitasi (`lib/screens/admin/admin_riwayat_screen.dart`)
- **List View**: Tampilan data rehabilitasi dengan search
- **Update Status**: Admin dapat mengubah status progress
- **Loading State**: Indikator loading dan empty state
- **Add Button**: Floating Action Button untuk tambah data baru

### 5. Form Tambah Data (`lib/screens/admin/tambah_rehabilitasi_screen.dart`)
- **Form Validation**: Validasi input lengkap
- **Dropdown Options**: Pilihan lembaga, status, jenis kelamin
- **Auto Geocoding**: Koordinat otomatis berdasarkan alamat
- **User Feedback**: Loading state dan notifikasi sukses/error

## Cara Kerja Sistem

### 1. Geocoding Otomatis
Ketika admin mendaftarkan pasien baru:
```dart
// Input alamat: "Lidah"
// Output koordinat: {latitude: -7.3121, longitude: 112.6875}
final coordinates = _geocodeAddress(rehabilitasi.alamat);
```

### 2. Sinkronisasi Data
- Data disimpan di SharedPreferences (persisten)
- Auto-refresh pada peta saat data berubah
- Real-time update status rehabilitasi

### 3. Visualisasi Peta
- Markers muncul otomatis di lokasi berdasarkan alamat
- Warna marker berubah sesuai status progress
- Info detail tersedia dengan tap marker

## Area Surabaya yang Didukung

Sistem mendukung geocoding untuk 35+ area di Surabaya:
- **Pusat**: Genteng, Tegalsari, Gubeng, Sawahan
- **Utara**: Semampir, Pabean Cantikan, Krembangan, Kenjeran, Bulak
- **Timur**: Tambaksari, Mulyorejo, Sukolilo, Rungkut, Tenggilis Mejoyo, Gunung Anyar
- **Selatan**: Wonocolo, Wiyung, Karang Pilang, Jambangan, Gayungan
- **Barat**: Lakarsantri, Benowo, Pakal, Asemrowo, Sukomanunggal, Tandes
- **Area Spesifik**: Lidah, Kertajaya, Ngagel Madya, dll.

## Penggunaan

### Admin Dashboard:
1. **Lihat Peta**: Navigasi → Persebaran → Lihat markers rehabilitasi
2. **Tambah Data**: Riwayat → + Button → Isi form → Submit
3. **Update Status**: Riwayat → Pilih item → Update Status
4. **Monitoring**: Markers di peta otomatis update sesuai status

### Fitur Teknis:
- **Persistent Storage**: Data tersimpan permanen
- **Error Handling**: Validasi input dan error management
- **Responsive UI**: Adaptif untuk berbagai ukuran layar
- **Performance**: Lazy loading dan efficient data management

## Keunggulan Sistem

1. **Real-time Visualization**: Peta selalu update dengan data terbaru
2. **User-friendly**: Interface intuitif untuk admin
3. **Comprehensive Data**: Informasi lengkap pasien rehabilitasi
4. **Geographic Intelligence**: Mapping otomatis alamat ke koordinat
5. **Status Tracking**: Monitoring progress rehabilitasi
6. **Scalable**: Mudah ditambah area dan fitur baru

## Pengembangan Selanjutnya

- Integrasi dengan API geocoding eksternal (Google Maps/OpenStreetMap)
- Export data ke format laporan
- Notifikasi otomatis perubahan status
- Analytics dan statistik rehabilitasi
- Filter berdasarkan tanggal, lembaga, status
