# Implementasi Sinkronisasi Data Lembaga

## Deskripsi
Implementasi sinkronisasi data lembaga rehabilitasi antara admin dan user menggunakan `LembagaService` dengan penyimpanan lokal `SharedPreferences`.

## Arsitektur Solutsi

### 1. LembagaService (Singleton)
- **File**: `lib/services/lembaga_service.dart`
- **Fungsi**: Mengelola data lembaga secara terpusat
- **Storage**: SharedPreferences untuk persistensi data lokal
- **Pattern**: Singleton untuk memastikan instance tunggal

### 2. Fitur Utama Service

#### Data Management
```dart
// Mengambil semua data lembaga
await LembagaService.instance.getAllLembaga()

// Menambah lembaga baru
await LembagaService.instance.addLembaga(newLembaga)

// Mengupdate lembaga existing
await LembagaService.instance.updateLembaga(updatedLembaga)

// Menghapus lembaga
await LembagaService.instance.deleteLembaga(id)
```

#### Data Structure
Setiap lembaga memiliki struktur:
```dart
{
  'id': 'unique_string',
  'name': 'Nama Lembaga',
  'location': 'Lokasi',
  'capacity': 'Total kapasitas',
  'capacityPria': 'Kapasitas pria',
  'capacityWanita': 'Kapasitas wanita',
  'alamatLengkap': 'Alamat lengkap',
  'nomorTelepon': 'Nomor telepon',
  'jamOperasional': 'Jam operasional',
  'image': 'Path gambar',
  'email': 'Email kontak',
}
```

## Screen yang Tersinkronisasi

### 1. Admin Side
- **DaftarLembagaScreen**: Mengelola CRUD lembaga
- **TambahLembagaScreen**: Form tambah lembaga baru
- **EditLembagaScreen**: Form edit lembaga existing

### 2. User Side  
- **BerandaUserScreen**: Menampilkan top 3 lembaga
- **DaftarLembagaUserScreen**: Menampilkan semua lembaga
- **DetailLembagaUserScreen**: Detail lembaga dengan kapasitas terpisah

## Flow Sinkronisasi

### 1. Admin Menambah Lembaga
```
Admin -> TambahLembagaScreen -> LembagaService.addLembaga() 
-> SharedPreferences -> Update UI Admin -> Data tersedia untuk User
```

### 2. Admin Mengedit Lembaga
```
Admin -> EditLembagaScreen -> LembagaService.updateLembaga() 
-> SharedPreferences -> Update UI Admin -> Data terupdate untuk User
```

### 3. User Melihat Data
```
User -> Screen -> LembagaService.getAllLembaga() 
-> SharedPreferences -> Tampilkan data terbaru
```

## Implementasi Loading State

### Admin
```dart
class _DaftarLembagaScreenState extends State<DaftarLembagaScreen> {
  List<Map<String, dynamic>> allLembaga = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLembagaData();
  }

  Future<void> _loadLembagaData() async {
    final data = await LembagaService.instance.getAllLembaga();
    setState(() {
      allLembaga = data;
      isLoading = false;
    });
  }
}
```

### User
```dart
class _DaftarLembagaUserScreenState extends State<DaftarLembagaUserScreen> {
  List<Map<String, dynamic>> allLembaga = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLembagaData();
  }

  Future<void> _loadLembagaData() async {
    final data = await LembagaService.instance.getAllLembaga();
    setState(() {
      allLembaga = data;
      isLoading = false;
    });
  }
}
```

## Error Handling
- Try-catch pada semua operasi async
- Loading states untuk UX yang baik
- Error messages untuk user feedback
- Fallback ke data default jika terjadi error

## Keunggulan Implementasi

### 1. Data Consistency
- Single source of truth melalui LembagaService
- Semua screen menggunakan data yang sama
- Update di admin langsung tersedia untuk user

### 2. Real-time Sync
- Perubahan kapasitas cowok/perempuan di admin langsung terlihat di user
- Tambah/edit/hapus lembaga tersinkronisasi

### 3. User Experience
- Loading indicators saat memuat data
- Error handling yang proper
- Smooth navigation dan feedback

### 4. Maintainability
- Kode yang bersih dan terorganisir
- Service pattern yang mudah dipahami
- Easy to extend untuk fitur baru

## Dependencies Baru
```yaml
dependencies:
  shared_preferences: ^2.2.2
```

## Testing
1. Admin tambah lembaga → Cek apakah muncul di user
2. Admin edit kapasitas → Cek apakah terupdate di detail user
3. Admin hapus lembaga → Cek apakah hilang dari daftar user
4. Test offline persistence dengan restart app

## Future Enhancements
1. **Database Integration**: Ganti SharedPreferences dengan SQLite/Firebase
2. **Real-time Updates**: WebSocket untuk update real-time
3. **Data Validation**: Server-side validation
4. **Caching Strategy**: Implement proper caching mechanism
5. **Conflict Resolution**: Handle concurrent edits

## Kesimpulan
Implementasi ini berhasil menyelesaikan masalah miskomunikasi data antara admin dan user. Setiap perubahan yang dilakukan admin akan langsung tersedia untuk user, termasuk detail kapasitas cowok dan perempuan yang sudah terpisah dengan baik.
