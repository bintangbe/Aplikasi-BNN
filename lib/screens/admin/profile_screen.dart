import 'package:flutter/material.dart';
import 'masukkan_screen.dart';
import 'unified_bottom_navigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation
      child: Scaffold(
        body: Stack(
          children: [
            // Background biru gradien
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            // Konten di atas background
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  // Logo dan tulisan KOTA SURABAYA di tengah
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/logo_bnn.png',
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Text(
                                  'BNN',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF063CA8),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'KOTA\nSURABAYA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Kontainer isi profil
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEFEFEF),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Profil Pengguna',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Profil Card
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.black12,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 16),
                              Text(
                                'Admin',
                                style: TextStyle(
                                  color: Color(0xFF063CA8),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Instansi
                        Container(
                          padding: const EdgeInsets.all(14),
                          margin: const EdgeInsets.only(bottom: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Badan Narkotika Surabaya',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        // Email
                        Container(
                          padding: const EdgeInsets.all(14),
                          margin: const EdgeInsets.only(bottom: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'bnnksurabaya@gmail.com',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        // Tombol Logout
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _showLogoutDialog(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Tombol Kotak Masuk
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MasukkanScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Kotak Masuk',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 100,
                        ), // Space for bottom navigation
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Footer - Positioned at bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: UnifiedBottomNavigation(
                currentIndex: 4, // Akun
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Navigate to login screen - adjust this path as needed
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login', // Use named route
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
