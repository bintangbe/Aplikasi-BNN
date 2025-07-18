import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            colors: [
              AppColors.backgroundBlue,
              AppColors.primaryDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                
                // BNN Logo & Title
                Column(
                  children: [
                    // BNN Logo (placeholder circle)
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      child: const Center(
                        child: Text(
                          'BNN',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.logoBlue,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // KOTA SURABAYA
                    const Text(
                      'KOTA\nSURABAYA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textWhite,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Login Card
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Text
                        const Text(
                          'Selamat Datang',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        const Text(
                          'Silakan login untuk melanjutkan',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Login Buttons
                        Expanded(
                          child: Column(
                            children: [
                              _buildLoginButton(
                                'Login Masyarakat',
                                AppColors.buttonMasyarakat,
                                () {
                                  // Navigate to Masyarakat
                                },
                              ),
                              
                              const SizedBox(height: 16),
                              
                              _buildLoginButton(
                                'Login Lembaga',
                                AppColors.buttonLembaga,
                                () {
                                  // Navigate to Lembaga
                                },
                              ),
                              
                              const SizedBox(height: 16),
                              
                              _buildLoginButton(
                                'Login Penyidik',
                                AppColors.buttonPenyidik,
                                () {
                                  // Navigate to Penyidik
                                },
                              ),
                              
                              const SizedBox(height: 16),
                              
                              _buildLoginButton(
                                'Login Admin',
                                AppColors.buttonAdmin,
                                () {
                                  // Navigate to Admin
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildLoginButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: AppColors.textWhite,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}