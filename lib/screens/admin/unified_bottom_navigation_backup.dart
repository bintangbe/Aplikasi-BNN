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
      height: 65,
      decoration: const BoxDecoration(color: Color(0xFF063CA8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, 'Beranda', Icons.home, 0),
          _buildNavItem(context, 'Persebaran', Icons.map, 1),
          _buildNavItem(context, 'Pengajuan', Icons.assignment, 2),
          _buildNavItem(context, 'Riwayat', Icons.history, 3),
          _buildNavItem(context, 'Akun', Icons.person, 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String label,
    IconData icon,
    int index,
  ) {
    final bool isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () => _navigateToScreen(context, index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF062766) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
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
        targetScreen = const AdminAjukanRehabScreen();
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
