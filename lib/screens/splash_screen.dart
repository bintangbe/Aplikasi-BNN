import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to login after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SEMANGGI Logo - Real Asset atau Fallback
            _buildLogo(),

            const SizedBox(height: 40),

            // SEMANGGI Text
            const Text(
              'Semangat Menggapai Asa untuk Memulai Rehabilitasi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 60),

            // Welcome Text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Selamat datang di aplikasi Semanggi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Loading indicator
            const CircularProgressIndicator(
              color: AppColors.logoBlue,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 120,
      height: 120,
      child: Image.asset(
        'assets/images/logo_semanggi.png',
        width: 120,
        height: 120,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback jika asset belum ada
          return Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.logoBlue, width: 3),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background circle
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                // Person icon (simplified)
                const Positioned(
                  bottom: 30,
                  child: Icon(
                    Icons.person,
                    color: AppColors.logoBlue,
                    size: 40,
                  ),
                ),
                // Clover icon (using favorite icon as approximation)
                const Positioned(
                  top: 20,
                  right: 25,
                  child: Icon(
                    Icons.local_florist,
                    color: AppColors.logoGreen,
                    size: 30,
                  ),
                ),
                // Green arc (simplified with container)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    width: 50,
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppColors.logoGreen,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
