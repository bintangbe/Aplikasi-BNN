# Update Peta Persebaran BNN - Perubahan Lokasi dan Data

## 🏢 **Perubahan Lokasi BNN**

### Sebelum:
- **Nama**: Pusat BNN  
- **Lokasi**: Surabaya Center (-7.2575, 112.7521)
- **Marker**: Pin merah sederhana

### Sesudah:
- **Nama**: BNN Kota Surabaya
- **Alamat Lengkap**: Jl. Ngagel Madya V No.22, Baratajaya, Kec. Gubeng, Kota SBY, Jawa Timur 60284
- **Koordinat**: (-7.2947, 112.7271) - Area Gubeng/Ngagel Madya
- **Marker**: Ikon gedung dengan info detail

## 📍 **Detail Informasi BNN Kota Surabaya**

Ketika marker BNN diklik, akan menampilkan:
- **Alamat**: Jl. Ngagel Madya V No.22, Baratajaya
- **Kelurahan**: Baratajaya, Kec. Gubeng  
- **Kota**: Kota Surabaya, Jawa Timur
- **Kode Pos**: 60284
- **Instansi**: Badan Narkotika Nasional Kota Surabaya

## 👥 **Data Rehabilitasi yang Tersedia**

### 1. Waishabilla Rahadian F ✅
- **NIK**: 35020783942961
- **Status**: Rawat Inap → **Selesai**
- **Alamat**: Lidah (-7.3121, 112.6875)
- **Lembaga**: Yayasan Rumah Kita
- **Periode**: 7 Agustus - 18 Agustus 2024

### 2. Oktavian Ismarudin 🔄
- **NIK**: 35020783942962  
- **Status**: Rawat Jalan → **Masa Rehab**
- **Alamat**: Jalan Simokerto (-7.2299, 112.7298) ← *Koordinat diperbaiki*
- **Lembaga**: Yayasan Orbit
- **Periode**: 10 Agustus - 20 Agustus 2024

### 3. Bintang Azis Satrio Wibowo ✅
- **NIK**: 35020783942963
- **Status**: Rawat Jalan → **Selesai**  
- **Alamat**: Jalan Kertajaya (-7.2965, 112.7521)
- **Lembaga**: Yayasan Plato
- **Periode**: 15 Agustus - 25 Agustus 2024

## 🗺️ **Fitur Peta yang Diperbarui**

### Legend Baru:
- 🟢 **Hijau**: Status "Selesai" 
- 🟠 **Orange**: Status "Masa Rehab"
- 🔴 **Merah**: "BNN Kota Surabaya" ← *Nama diperbarui*

### Marker Interaktif:
- **BNN Marker**: Ikon gedung (account_balance) dengan popup info lengkap
- **Pasien Markers**: Ikon person dengan warna sesuai status
- **Map Center**: Difokuskan ke lokasi BNN Kota Surabaya

## 🔧 **Perubahan Teknis**

### File yang Dimodifikasi:

#### 1. `lib/services/rehabilitasi_service.dart`
```dart
// Menambahkan geocoding untuk alamat BNN
'ngagel madya v': {'latitude': -7.2947, 'longitude': 112.7271},
'baratajaya': {'latitude': -7.2947, 'longitude': 112.7271},

// Memperbaiki koordinat Oktavian Ismarudin
latitude: -7.2299, // Simokerto coordinates  
longitude: 112.7298,
```

#### 2. `lib/screens/admin/admin_persebaran.dart`
```dart
// Mengubah marker BNN dengan lokasi dan info baru
point: LatLng(-7.2947, 112.7271), // BNN Kota Surabaya
child: GestureDetector(onTap: () => _showBNNInfo()),

// Menambahkan method _showBNNInfo() dengan detail lengkap
// Mengubah map center ke lokasi BNN baru
center: LatLng(-7.2947, 112.7271),
```

## ✨ **Hasil Akhir**

1. **Peta terpusat** di lokasi BNN Kota Surabaya yang sebenarnya
2. **Marker BNN** menampilkan alamat lengkap dan detail instansi
3. **Data Waishabilla** sudah tersedia dan terlihat di peta (marker hijau)
4. **Koordinat yang akurat** untuk semua lokasi rehabilitasi
5. **Legend yang jelas** dengan nama BNN yang tepat

### Cara Menggunakan:
1. Buka **Admin Dashboard** → **Persebaran**
2. Klik **marker merah** untuk melihat info BNN Kota Surabaya  
3. Klik **marker berwarna** untuk melihat data pasien rehabilitasi
4. Gunakan **tombol refresh** untuk memperbarui data

Semua perubahan telah diterapkan dan dapat langsung digunakan! 🎉
