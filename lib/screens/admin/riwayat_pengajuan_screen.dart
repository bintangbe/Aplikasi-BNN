import 'package:flutter/material.dart';
import 'admin_riwayat_screen.dart';

class RiwayatPengajuanScreen extends StatelessWidget {
  const RiwayatPengajuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Redirect immediately to AdminRiwayatScreen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminRiwayatScreen()),
      );
    });

    // Return a simple loading screen while redirecting
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
