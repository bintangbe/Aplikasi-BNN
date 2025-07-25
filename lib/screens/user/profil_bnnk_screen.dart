import 'package:flutter/material.dart';

class ProfilBNNKScreen extends StatelessWidget {
  const ProfilBNNKScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil BNNK Surabaya'),
        backgroundColor: const Color(0xFF063CA8),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/bnn.png',
                  width: 300,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('BNNK Surabaya', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Alamat: Jl. Ngagel Madya V No.22, Barata Jaya, Gubeng, Surabaya'),
            const SizedBox(height: 8),
            const Text('Telepon: 031-5023979'),
            const SizedBox(height: 8),
            const Text('Email: info@bnnksurabaya.go.id'),
            const SizedBox(height: 16),
            const Text('Sosial Media:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Instagram: @bnnksurabaya'),
            const Text('Twitter: @bnnksurabaya'),
            const Text('Facebook: BNNK Surabaya'),
            const Text('TikTok: @bnnksurabaya'),
            const Text('YouTube: BNNK Surabaya'),
          ],
        ),
      ),
    );
  }
}
