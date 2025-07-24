import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailLembagaUserScreen extends StatelessWidget {
  final Map<String, dynamic> lembagaData;

  const DetailLembagaUserScreen({super.key, required this.lembagaData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF063CA8), Color(0xFF2563EB)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildImageSection(),
                        _buildDetailContent(),
                        _buildActionButtons(context),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Detail Lembaga',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                // TODO: Add to favorites
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Ditambahkan ke favorit'),
                    backgroundColor: Color(0xFF059669),
                  ),
                );
              },
              icon: const Icon(Icons.favorite_border, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    final image = lembagaData['image'] ?? 'assets/images/placeholder.jpeg';

    return Container(
      margin: const EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) =>
                      const Icon(Icons.broken_image),
                ),
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailContent() {
    final name = lembagaData['name'] ?? 'Nama tidak tersedia';
    final location = lembagaData['location'] ?? 'Lokasi tidak tersedia';
    final alamatLengkap =
        lembagaData['alamatLengkap'] ?? 'Alamat tidak tersedia';
    final capacity = lembagaData['capacity'] ?? 'Kapasitas tidak tersedia';
    final jamOperasional =
        lembagaData['jamOperasional'] ?? 'Jam tidak tersedia';
    final nomorTelepon = lembagaData['nomorTelepon'] ?? 'Nomor tidak tersedia';
    final email = lembagaData['email'] ?? 'Email tidak tersedia';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            location,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),

          // Details Section
          _buildDetailCard('Informasi Umum', [
            _buildDetailRow(
              Icons.location_on_outlined,
              'Alamat Lengkap',
              alamatLengkap,
              const Color(0xFF059669),
            ),
            _buildDetailRow(
              Icons.people_outline,
              'Kapasitas',
              capacity,
              const Color(0xFF2563EB),
            ),
            _buildDetailRow(
              Icons.access_time_outlined,
              'Jam Operasional',
              jamOperasional,
              const Color(0xFFF59E0B),
            ),
          ]),

          const SizedBox(height: 16),

          _buildDetailCard('Kontak', [
            _buildDetailRow(
              Icons.phone_outlined,
              'Nomor Telepon',
              nomorTelepon,
              const Color(0xFF059669),
            ),
            _buildDetailRow(
              Icons.email_outlined,
              'Email',
              email,
              const Color(0xFF2563EB),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final nomorTelepon = lembagaData['nomorTelepon'] ?? '';
    final alamatLengkap = lembagaData['alamatLengkap'] ?? '';

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Call Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                if (nomorTelepon.isNotEmpty &&
                    nomorTelepon != 'Nomor tidak tersedia') {
                  final Uri phoneUri = Uri(scheme: 'tel', path: nomorTelepon);
                  if (await canLaunchUrl(phoneUri)) {
                    await launchUrl(phoneUri);
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tidak dapat membuka aplikasi telepon'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nomor telepon tidak tersedia'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.phone),
              label: const Text(
                'Hubungi Sekarang',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 2,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Maps Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () async {
                if (alamatLengkap.isNotEmpty &&
                    alamatLengkap != 'Alamat tidak tersedia') {
                  final Uri mapsUri = Uri(
                    scheme: 'https',
                    host: 'www.google.com',
                    path: '/maps/search/',
                    query: alamatLengkap,
                  );
                  if (await canLaunchUrl(mapsUri)) {
                    await launchUrl(
                      mapsUri,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tidak dapat membuka Google Maps'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Alamat tidak tersedia'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              icon: const Icon(Icons.location_on),
              label: const Text(
                'Buka di Maps',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF2563EB),
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: const BorderSide(color: Color(0xFF2563EB), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
