import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'admin_ajukan_rehab_screen.dart';
import 'riwayat_pengajuan_screen.dart';
import 'detail_lembaga_screen.dart';
import 'profile_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
@override
Widget build(BuildContext context) {
  return Scaffold(
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
              _buildHeader(),
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
                        left: 24, right: 24, top: 24, bottom: 100),
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
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildBottomNavigation(context),
        ),
      ],
    ),
  );
}

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.9),
            ),
            child: Image.asset(
              'assets/images/logo_bnn.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text(
                    'BNN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF063CA8),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'KOTA\nSURABAYA',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
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
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ],
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const AdminAjukanRehabScreen()));
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const RiwayatPengajuanScreen()));
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
                bottom: -8, // posisi strip agar tidak memicu overflow
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
      },
      {
        'name': 'Rumah Sakit Jiwa Menur',
        'location': 'Surabaya Timur',
        'type': 'Rawat Inap',
        'capacity': '50 tempat tidur',
        'alamatLengkap': 'Jl. Tentara Genie Pelajar No.1, Menur Pumpungan',
        'nomorTelepon': '(031) 5928587',
        'jamOperasional': '24 Jam',
        'fasilitas': 'Ruang rawat inap, ruang terapi, laboratorium, apotek',
      },
      {
        'name': 'Puskesmas Sukolilo',
        'location': 'Surabaya Timur',
        'type': 'Rawat Jalan',
        'capacity': '100 pasien/hari',
        'alamatLengkap': 'Jl. Raya Sukolilo No.100, Sukolilo Baru',
        'nomorTelepon': '(031) 5947890',
        'jamOperasional': '08.00 - 16.00 WIB',
        'fasilitas': 'Poliklinik umum, ruang konseling, farmasi',
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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            TextButton(
              onPressed: () {},
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
        ...lembagaList.map((lembaga) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildLembagaItem(context, lembaga),
            )),
      ],
    );
  }

  Widget _buildLembagaItem(BuildContext context, Map<String, String> lembaga) {
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
                Text(
                  lembaga['name']!,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1D4ED8),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                Text(
                  lembaga['location']!,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.people, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  lembaga['capacity']!,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
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
                      builder: (_) =>
                          DetailLembagaScreen(lembagaData: lembaga),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                ),
                child: const Text('Lihat Detail'),
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

  Widget _buildBottomNavigation(BuildContext context) {
  return Container(
    height: 65,
    decoration: const BoxDecoration(
      color: Color(0xFF063CA8),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, -2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildNavItem('Beranda', true, Icons.home, () {}),
        _buildNavItem('Pesebaran', false, Icons.map, () {
          // TODO: Navigasi ke halaman pesebaran
        }),
        _buildNavItem('Pengajuan', false, Icons.assignment, () {
          // TODO: Navigasi ke halaman pengajuan
        }),
        _buildNavItem('Riwayat', false, Icons.history, () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RiwayatPengajuanScreen()),
          );
        }),
        _buildNavItem('Akun', false, Icons.person, () {
          // ✅ Ini bagian yang perlu kamu tambahkan
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        }),
      ],
    ),
  );
}

 Widget _buildNavItem(String label, bool isActive, IconData icon, VoidCallback onTap) {
  return Expanded(
    child: InkWell(
      onTap: onTap, // ← Pastikan ini ada!
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? Colors.white : Colors.white70, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white70,
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}

