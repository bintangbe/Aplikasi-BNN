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
            // SEMANGGI Logo - Real Asset atau Fallback (diperbesar)
            _buildLogo(),

            const SizedBox(height: 40),

            // SEMANGGI Text
            const Text(
              'Semangat Menggapai Asa untuk Memulai Rehabilitasi',
              style: TextStyle(
                fontSize: 16,
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
    return Center(
      child: SizedBox(
        width: 280, // Diperbesar dari 180 ke 280
        height: 280, // Diperbesar dari 180 ke 280
        child: Image.asset(
          'assets/images/logo_semanggi.png',
          width: 280,
          height: 280,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // Fallback jika asset belum ada (diperbesar proporsional)
            return Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.logoBlue, width: 4),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Background circle
                  Container(
                    width: 240,
                    height: 240,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                    ),
                  ),
                  // Person icon (diperbesar)
                  const Positioned(
                    bottom: 70,
                    child: Icon(
                      Icons.person,
                      color: AppColors.logoBlue,
                      size: 90,
                    ),
                  ),
                  // Clover icon (diperbesar)
                  const Positioned(
                    top: 50,
                    right: 65,
                    child: Icon(
                      Icons.local_florist,
                      color: AppColors.logoGreen,
                      size: 65,
                    ),
                  ),
                  // Green arc (diperbesar)
                  Positioned(
                    bottom: 25,
                    right: 25,
                    child: Container(
                      width: 110,
                      height: 55,
                      decoration: BoxDecoration(
                        color: AppColors.logoGreen,
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}