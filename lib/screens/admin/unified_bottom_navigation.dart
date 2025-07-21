// lib/screens/admin/unified_bottom_navigation.dart

import 'package:flutter/material.dart';

// Import semua screen yang diperlukan
import 'admin_dashboard_screen.dart';
import 'admin_persebaran.dart';
import 'admin_ajukan_rehab_screen.dart';
import 'admin_riwayat_screen.dart';
import 'profile_screen.dart';

class UnifiedBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const UnifiedBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF063CA8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 60, // Further reduced from 65 to 60
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 4,
          ), // Reduced vertical from 6 to 4
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                'Beranda',
                Icons.home_outlined,
                0,
                () => _navigateToScreen(context, 0),
              ),
              _buildNavItem(
                context,
                'Pesebaran',
                Icons.map_outlined,
                1,
                () => _navigateToScreen(context, 1),
              ),
              _buildNavItem(
                context,
                'Pengajuan',
                Icons.assignment_outlined,
                2,
                () => _navigateToScreen(context, 2),
              ),
              _buildNavItem(
                context,
                'Riwayat',
                Icons.history,
                3,
                () => _navigateToScreen(context, 3),
              ),
              _buildNavItem(
                context,
                'Akun',
                Icons.person_outline,
                4,
                () => _navigateToScreen(context, 4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String label,
    IconData icon,
    int index,
    VoidCallback onTap,
  ) {
    final bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ), // Further reduced from 6 to 4
        decoration: isActive
            ? BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00AEEF), Color(0xFF063CA8)],
                ),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: ClipRect(
          // Added ClipRect to prevent overflow
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : const Color(0xFFB0C4DE),
                size: 18, // Further reduced from 20 to 18
              ),
              const SizedBox(height: 1), // Further reduced from 2 to 1
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : const Color(0xFFB0C4DE),
                  fontSize: 9, // Further reduced from 10 to 9
                  fontFamily: 'Poppins',
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  height: 1.0, // Further reduced from 1.1 to 1.0
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, int index) {
    // Jika sudah di screen yang sama, tidak perlu navigasi
    if (currentIndex == index) return;

    Widget targetScreen;

    switch (index) {
      case 0:
        targetScreen = const AdminDashboardScreen();
        break;
      case 1:
        targetScreen = const AdminPersebaranScreen();
        break;
      case 2:
        targetScreen = const AdminAjukanRehabScreen();
        break;
      case 3:
        targetScreen = const AdminRiwayatScreen();
        break;
      case 4:
        targetScreen = const ProfileScreen();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => targetScreen),
    );
  }
}
