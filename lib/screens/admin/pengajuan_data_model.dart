import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import 'admin_ajukan_rehab_screen.dart';
import 'riwayat_pengajuan_screen.dart'; // Import file riwayat pengajuan

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
          ),
        ),
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
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildActionButtons(context),
                            const SizedBox(height: 24),
                            _buildLembagaSection(),
                          ],
                        ),
                      ),
                    ),
                    _buildBottomNavigation(context),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                height: 1.2,
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
                    fontFamily: 'Poppins',
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
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminAjukanRehabScreen(),
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
                  builder: (context) => const RiwayatPengajuanScreen(),
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
      child: Container(
        height: 88,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0x19000000),
              blurRadius: 2,
              offset: const Offset(0, 1),
              spreadRadius: -1,
            ),
            BoxShadow(
              color: const Color(0x19000000),
              blurRadius: 3,
              offset: const Offset(0, 1),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLembagaSection() {
    final lembagaList = [
      {
        'name': 'Rumah Sakit Jiwa Menur',
        'location': 'Surabaya Timur',
        'type': 'Rawat Inap',
        'capacity': '50 tempat tidur',
      },
      {
        'name': 'Puskesmas Sukolilo',
        'location': 'Surabaya Timur',
        'type': 'Rawat Jalan',
        'capacity': '100 pasien/hari',
      },
      {
        'name': 'RS Umum Daerah Dr. Soetomo',
        'location': 'Surabaya Pusat',
        'type': 'Rawat Inap & Jalan',
        'capacity': '200 tempat tidur',
      },
      {
        'name': 'Klinik Rehabilitasi Gubeng',
        'location': 'Surabaya Pusat',
        'type': 'Rawat Jalan',
        'capacity': '75 pasien/hari',
      },
      {
        'name': 'RS Jiwa Dr. Radjiman Wediodiningrat',
        'location': 'Surabaya Barat',
        'type': 'Rawat Inap',
        'capacity': '150 tempat tidur',
      },
      {
        'name': 'Puskesmas Tambaksari',
        'location': 'Surabaya Pusat',
        'type': 'Rawat Jalan',
        'capacity': '80 pasien/hari',
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
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.59,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to all lembaga
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
            child: _buildLembagaItem(lembaga),
          ),
        ),
      ],
    );
  }

  Widget _buildLembagaItem(Map<String, String> lembaga) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 6,
            offset: const Offset(0, 4),
            spreadRadius: -1,
          ),
        ],
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
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.52,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                lembaga['location']!,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(width: 16),
              Icon(Icons.people, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                lembaga['capacity']!,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  _showLembagaDetail(lembaga);
                },
                child: const Text(
                  'Lihat Detail',
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 1.52,
                  ),
                ),
              ),
            ],
          ),
        ],
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

  void _showLembagaDetail(Map<String, String> lembaga) {
    // TODO: Implement lembaga detail dialog or navigate to detail page
    print('Show detail for: ${lembaga['name']}');
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      decoration: const BoxDecoration(color: Color(0xFF063CA8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('Beranda', true, Icons.home, () {
            // Current page
          }),
          _buildNavItem('Pesebaran', false, Icons.map, () {
            // TODO: Navigate to Pesebaran
          }),
          _buildNavItem('Pengajuan', false, Icons.assignment, () {
            // TODO: Navigate to Pengajuan
          }),
          _buildNavItem('Riwayat', false, Icons.history, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RiwayatPengajuanScreen(),
              ),
            );
          }),
          _buildNavItem('Akun', false, Icons.person, () {
            // TODO: Navigate to Akun
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    String label,
    bool isActive,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 65,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: const Color(0xFF062766),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFFEBEDF0),
                fontSize: 12,
                fontFamily: 'Segoe UI Symbol',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
