import 'package:flutter/material.dart';
import 'detail_lembaga_screen.dart';
import 'daftar_lembaga_screen.dart';

// Contoh penggunaan fitur lembaga lengkap (View, Edit, Add, Delete)
class ExampleUsageScreen extends StatelessWidget {
  const ExampleUsageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Contoh data lembaga yang lengkap
    final Map<String, dynamic> sampleLembagaData = {
      'id': '1',
      'name': 'Yayasan Ashefa Griya Pusaka',
      'alamatLengkap':
          'Jl. Raya Menganti No. 123, Wiyung, Surabaya, Jawa Timur 60213',
      'nomorTelepon': '(031) 7123456',
      'jamOperasional': 'Senin - Jumat: 08:00 - 16:00\nSabtu: 08:00 - 12:00',
      'image': 'assets/images/yayasan_ashefa_griya_pusaka.jpeg',

      // Data kapasitas
      'rawatInapLaki': 3, // Jumlah pasien laki-laki saat ini
      'rawatInapPerempuan': 1, // Jumlah pasien perempuan saat ini
      'rawatJalan': 2, // Jumlah pasien rawat jalan
      'pascaRehab': 2, // Jumlah peserta pasca rehab
      'kapasitasLaki': 17, // Kapasitas maksimal laki-laki
      'kapasitasPerempuan': 5, // Kapasitas maksimal perempuan
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contoh Fitur Lembaga'),
        backgroundColor: const Color(0xFF063CA8),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF063CA8).withOpacity(0.1),
                    const Color(0xFF00AEEF).withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.business,
                size: 64,
                color: Color(0xFF063CA8),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Manajemen Lembaga Rehabilitasi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            const Text(
              'Kelola data lembaga dengan fitur lengkap',
              style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Daftar Lembaga Button
            SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarLembagaScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.list, size: 20),
                label: const Text('Daftar Lembaga'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF063CA8),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Detail Lembaga Button
            SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailLembagaScreen(lembagaData: sampleLembagaData),
                    ),
                  );
                },
                icon: const Icon(Icons.info, size: 20),
                label: const Text('Contoh Detail Lembaga'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00AEEF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Info Features
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Fitur yang Tersedia:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildFeatureItem(Icons.add_circle, 'Tambah Lembaga Baru'),
                  _buildFeatureItem(Icons.edit, 'Edit Informasi & Kapasitas'),
                  _buildFeatureItem(Icons.visibility, 'Lihat Detail Lengkap'),
                  _buildFeatureItem(
                    Icons.analytics,
                    'Monitoring Kapasitas Real-time',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF063CA8)),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
          ),
        ],
      ),
    );
  }
}

// Contoh data untuk berbagai lembaga
class LembagaDataHelper {
  static List<Map<String, dynamic>> getSampleData() {
    return [
      {
        'id': '1',
        'name': 'Yayasan Ashefa Griya Pusaka',
        'alamatLengkap':
            'Jl. Raya Menganti No. 123, Wiyung, Surabaya, Jawa Timur 60213',
        'nomorTelepon': '(031) 7123456',
        'jamOperasional': 'Senin - Jumat: 08:00 - 16:00\nSabtu: 08:00 - 12:00',
        'image': 'assets/images/yayasan_ashefa_griya_pusaka.jpeg',
        'rawatInapLaki': 3,
        'rawatInapPerempuan': 1,
        'rawatJalan': 2,
        'pascaRehab': 2,
        'kapasitasLaki': 17,
        'kapasitasPerempuan': 5,
      },
      {
        'id': '2',
        'name': 'Yayasan Rumah Kita',
        'alamatLengkap':
            'Jl. Ketintang Baru No. 45, Gayungan, Surabaya, Jawa Timur 60231',
        'nomorTelepon': '(031) 8234567',
        'jamOperasional': 'Senin - Sabtu: 07:00 - 17:00',
        'image': 'assets/images/yayasan_rumah_kita.jpeg',
        'rawatInapLaki': 5,
        'rawatInapPerempuan': 3,
        'rawatJalan': 4,
        'pascaRehab': 3,
        'kapasitasLaki': 20,
        'kapasitasPerempuan': 8,
      },
      {
        'id': '3',
        'name': 'Klinik Pratama Semanggi',
        'alamatLengkap':
            'Jl. Semanggi Indah No. 78, Gubeng, Surabaya, Jawa Timur 60285',
        'nomorTelepon': '(031) 5678901',
        'jamOperasional': 'Senin - Minggu: 24 Jam',
        'image': 'assets/images/klinik_pratama.jpeg',
        'rawatInapLaki': 2,
        'rawatInapPerempuan': 1,
        'rawatJalan': 8,
        'pascaRehab': 5,
        'kapasitasLaki': 12,
        'kapasitasPerempuan': 6,
      },
    ];
  }
}
