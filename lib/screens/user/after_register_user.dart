import 'package:flutter/material.dart';

class AfterRegisterUserScreen extends StatelessWidget {
  const AfterRegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi Berhasil'),
        backgroundColor: const Color(0xFF2563EB),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle, color: Color(0xFF18C07A), size: 80),
            SizedBox(height: 24),
            Text(
              'Registrasi Berhasil!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2563EB),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Silakan login untuk melanjutkan.',
              style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
