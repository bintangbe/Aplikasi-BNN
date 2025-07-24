import 'package:flutter/material.dart';
// import 'masukkan_screen.dart';
// import 'admin_forgot_password_screen.dart';
import '../login_screen.dart';
import 'notifikasi_admin_screen.dart';
import 'ubah_password_admin_screen.dart';
import 'unified_bottom_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAdminHeader(),
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
                    child: Column(
                      children: [
                        _buildProfileSection(),
                        _buildMenuSection(),
                        _buildContactSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Footer as in admin_dashboard_screen.dart
      bottomNavigationBar: const UnifiedBottomNavigation(currentIndex: 4),
    );
  }

  Widget _buildAdminHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              final Uri url = Uri.parse('https://surabayakota.bnn.go.id');
              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
            child: Container(
              width: 86,
              height: 86,
              child: Image.asset(
                'assets/images/logo_bnn.png',
                fit: BoxFit.contain,
              ),
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

  Widget _buildProfileSection() {
    const String namaUser = 'Oktavian';
    const String emailUser = 'oktavian@email.com';
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF063CA8),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            namaUser,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            emailUser,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildMenuCard(
            'Notifikasi',
            Icons.notifications_outlined,
            'Pesan dari admin',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotifikasiScreen()),
            ),
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            'Keamanan',
            Icons.security,
            'Ubah password',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UbahPasswordUserScreen(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildMenuCard(
            'Keluar',
            Icons.logout,
            'Keluar dari akun dan kembali ke halaman login',
            () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text(
                    'Konfirmasi Keluar',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  content: const Text(
                    'Apakah Anda yakin ingin keluar dari aplikasi?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Tutup dialog
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Keluar',
                        style: TextStyle(
                          color: Color(0xFFEF4444),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    String title,
    IconData icon,
    String subtitle,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isLogout
                    ? const Color(0xFFEF4444).withOpacity(0.1)
                    : const Color(0xFF3B82F6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isLogout
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF3B82F6),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isLogout ? const Color(0xFFEF4444) : Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kontak BNN Kota Surabaya',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          _buildContactItem(Icons.phone, 'Call Center', '031-5023979'),
          const SizedBox(height: 12),
          _buildContactItem(Icons.chat, 'WhatsApp Center 1', '081234484195'),
          const SizedBox(height: 12),
          _buildContactItem(Icons.chat, 'WhatsApp Center 2', '081288881122'),
          const SizedBox(height: 12),
          _buildContactItem(
            Icons.location_on,
            'Alamat',
            'Jl. Ngagel Madya V No.22, Barata Jaya, Gubeng, Surabaya',
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
