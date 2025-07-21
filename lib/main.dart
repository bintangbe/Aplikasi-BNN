import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'constants/colors.dart';

void main() {
  runApp(const BNNApp());
}

class BNNApp extends StatelessWidget {
  const BNNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BNN Indonesia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Primary color scheme
        primarySwatch: _createMaterialColor(AppColors.primary),
        primaryColor: AppColors.primary,
        
        // App bar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
        ),
        
        // Scaffold background
        scaffoldBackgroundColor: AppColors.background,
        
        // Color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.logoGreen,
          surface: AppColors.surface,
          background: AppColors.background,
          error: AppColors.error,
        ),
        
        // Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        
        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.textLight),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.textLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        
        // Use Material 3
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
  
  // Helper function to create MaterialColor from Color
  MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    
    return MaterialColor(color.value, swatch);
  }
}
