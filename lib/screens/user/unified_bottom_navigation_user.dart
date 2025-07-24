import 'package:flutter/material.dart';
import 'beranda_user.dart';
import 'persebaran_screen.dart';
import 'masukkan_screen.dart';
import 'ebook_screen.dart';
import 'akun_screen.dart';

class UnifiedBottomNavigationUser extends StatelessWidget {
  final int currentIndex;
  const UnifiedBottomNavigationUser({super.key, required this.currentIndex});

  void _navigateToScreen(BuildContext context, int index) {
    // Jika sudah di screen yang sama, tidak perlu navigasi
    if (currentIndex == index) return;

    Widget targetScreen;

    switch (index) {
      case 0:
        targetScreen = const BerandaUserScreen();
        break;
      case 1:
        targetScreen = const PersebaranScreen();
        break;
      case 2:
        targetScreen = const MasukkanScreen();
        break;
      case 3:
        targetScreen = const EbookScreen();
        break;
      case 4:
        targetScreen = const AkunScreen();
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
                'Persebaran',
                Icons.map_outlined,
                1,
                () => _navigateToScreen(context, 1),
              ),
              _buildNavItem(
                context,
                'Masukkan',
                Icons.input,
                2,
                () => _navigateToScreen(context, 2),
              ),
              _buildNavItem(
                context,
                'E-Book',
                Icons.book_outlined,
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
}