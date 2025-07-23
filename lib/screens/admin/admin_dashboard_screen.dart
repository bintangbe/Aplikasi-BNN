import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'admin_ajukan_rehab_screen.dart';
import 'riwayat_pengajuan_screen.dart';
import 'detail_lembaga_screen.dart';
import 'daftar_lembaga_screen.dart';
import 'profile_screen.dart';
import 'unified_bottom_navigation.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFEFEF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 24,
                          bottom: 100,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildActionButtons(context),
                            const SizedBox(height: 24),
                            _buildLembagaSection(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Navigation
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: UnifiedBottomNavigation(currentIndex: 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Updated Logo Section
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse('https://surabayakota.bnn.go.id');
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
            child: Container(
              width: 100,
              height: 100,
              child: Image.asset(
                'assets/images/logo_bnn.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KOTA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'SURABAYA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Admin',
                    style: TextStyle(
                      color: Color(0xFF0540B0),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF063CA8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            title: 'Ajukan\nRehab',
            color: const Color(0xFF0050FF),
            icon: Icons.medical_services,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminAjukanRehabScreen(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            title: 'Riwayat\nPengajuan',
            color: const Color(0xFF22C55E),
            icon: Icons.history,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RiwayatPengajuanScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -8,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: SizedBox(
                    height: 8,
                    child: Row(
                      children: List.generate(
                        20,
                        (index) => Expanded(
                          child: Container(
                            color: index.isEven ? Colors.yellow : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.white, size: 30),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLembagaSection(BuildContext context) {
    final lembagaList = [
      {
        'name': 'Yayasan Rumah Kita Surabaya',
        'location': 'Surabaya Timur',
        'type': 'Rawat Inap',
        'capacity': '22 tempat tidur',
        'alamatLengkap': 'Jl. Ngagel Madya II / 9 Surabaya',
        'nomorTelepon': '088102367299',
        'jamOperasional': '24 Jam',
        'fasilitas': 'Ruang rawat inap, ruang terapi, konseling',
        'image': 'assets/images/yayasan_rumah_kita.jpeg',
        'deskripsi':
            'Yayasan Rumah Kita adalah salah satu lembaga rehabilitasi narkoba terbaik di Surabaya yang telah berpengalaman dalam membantu para korban narkoba untuk sembuh total.',
        'layanan': [
          'Rehabilitasi Rawat Inap',
          'Terapi Kelompok',
          'Konseling Individual',
          'Program Reintegrasi Sosial',
          'Pendampingan Keluarga',
        ],
        'email': 'info@rumahkita.org',
      },
      {
        'name': 'Yayasan Orbit Surabaya',
        'location': 'Surabaya Timur',
        'type': 'Rawat Inap',
        'capacity': '50 tempat tidur',
        'alamatLengkap':
            'Jl. BarataJaya XII A No.6, RT.001/RW.004, Baratajaya, Kec. Gubeng, Surabaya',
        'nomorTelepon': '(031) 5928587',
        'jamOperasional': '24 Jam',
        'fasilitas': 'Ruang rawat inap, ruang terapi, laboratorium, apotek',
        'image': 'assets/images/yayasan_orbit_surabaya.jpeg',
        'deskripsi':
            'Yayasan Orbit Surabaya berkomitmen memberikan layanan rehabilitasi narkoba yang komprehensif dengan fasilitas modern dan tenaga profesional berpengalaman.',
        'layanan': [
          'Rehabilitasi Rawat Inap',
          'Detoksifikasi Medis',
          'Terapi Kelompok',
          'Konseling Psikologi',
          'Program Vocational Training',
        ],
        'email': 'info@orbitsurabaya.org',
      },
      {
        'name': 'Yayasan Plato Surabaya',
        'location': 'Surabaya Timur',
        'type': 'Rawat Jalan',
        'capacity': '25 tempat tidur',
        'alamatLengkap':
            'Jl. Cipta Mananggal v No. 16, RT 011 RW 005, Kelurahan Menanggal, Kecamatan Gayungan',
        'nomorTelepon': '(031) 5947890',
        'jamOperasional': '08.00 - 16.00 WIB',
        'fasilitas': 'Poliklinik umum, ruang konseling, farmasi',
        'image': 'assets/images/yayasan_plato_surabaya.jpeg',
        'deskripsi':
            'Yayasan Plato Surabaya mengkhususkan diri dalam layanan rawat jalan dengan pendekatan terapi yang inovatif dan personal untuk setiap pasien.',
        'layanan': [
          'Rehabilitasi Rawat Jalan',
          'Konseling Individual dan Keluarga',
          'Terapi Kelompok',
          'Program Relapse Prevention',
          'Konsultasi Medis',
        ],
        'email': 'contact@platosurabaya.org',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Daftar Lembaga Rehabilitasi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DaftarLembagaScreen(),
                  ),
                );
              },
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: Color(0xFF0050FF),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...lembagaList.map(
          (lembaga) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildLembagaItem(context, lembaga),
          ),
        ),
      ],
    );
  }

  Widget _buildLembagaItem(BuildContext context, Map<String, dynamic> lembaga) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    lembaga['name']!,
                    style: const TextStyle(
                      color: Color(0xFF1D4ED8),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getTypeColor(lembaga['type']!).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    lembaga['type']!,
                    style: TextStyle(
                      color: _getTypeColor(lembaga['type']!),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    lembaga['location']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.people, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    lembaga['capacity']!,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailLembagaScreen(lembagaData: lembaga),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Lihat Detail',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Rawat Inap':
        return const Color(0xFFFACC15);
      case 'Rawat Jalan':
        return const Color(0xFF60A5FA);
      case 'Rawat Inap & Jalan':
        return const Color(0xFF22C55E);
      default:
        return const Color(0xFF6B7280);
    }
  }
}
