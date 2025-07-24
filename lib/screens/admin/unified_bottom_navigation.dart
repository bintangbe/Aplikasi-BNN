// lib/screens/admin/unified_bottom_navigation.dart

import 'package:flutter/material.dart';

// Import semua screen yang diperlukan
import 'admin_dashboard_screen.dart';
import 'admin_persebaran.dart';
import 'admin_ajukan_rehab_screen.dart';
import 'admin_riwayat_screen.dart';
import 'profile_screen.dart';
import 'masukkan_screen.dart';

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
          height: 65, // Consistent height
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ), // Consistent padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // Changed to spaceEvenly for better distribution
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

    return Expanded(
      // Use Expanded to ensure equal width distribution
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48, // Fixed height for consistent appearance
          padding: const EdgeInsets.symmetric(
            vertical: 6,
          ), // Consistent vertical padding
          decoration: isActive
              ? BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00AEEF), Color(0xFF063CA8)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : const Color(0xFFB0C4DE),
                size: 20, // Consistent icon size
              ),
              const SizedBox(height: 2), // Consistent spacing
              Text(
                label,
                style: TextStyle(
                  color: isActive ? Colors.white : const Color(0xFFB0C4DE),
                  fontSize: 10, // Consistent font size
                  fontFamily: 'Poppins',
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  height: 1.1, // Consistent line height
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
        targetScreen = const MasukkanScreen();
        break;
      case 3:
        targetScreen = const AdminRiwayatScreen();
        break;
      case 4:
        targetScreen =
            const ProfileScreen(); // Navigate to Profile/Account screen
        break;
      default:
        return;
    }

    // Use pushReplacement to replace current screen
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetScreen,
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Smooth fade transition
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
