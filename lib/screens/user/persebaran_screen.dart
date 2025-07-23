import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'beranda_user.dart';
import 'masukkan_screen.dart';
import 'ebook_screen.dart';
import 'akun_screen.dart';

class PersebaranScreen extends StatelessWidget {
  const PersebaranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Marker> markers = [
      Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(-7.2575, 112.7521), // Surabaya Center
        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
      ),
      Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(-7.2947, 112.7271), // Surabaya Barat
        child: const Icon(Icons.location_pin, color: Colors.blue, size: 40),
      ),
      Marker(
        width: 40.0,
        height: 40.0,
        point: LatLng(-7.2892, 112.7585), // Surabaya Timur
        child: const Icon(Icons.location_pin, color: Colors.green, size: 40),
      ),
    ];

    return PopScope(
      canPop: false, // Prevent back navigation
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Peta Persebaran'),
          backgroundColor: const Color(0xFF063CA8),
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false, // Remove back button
        ),
        body: Column(
          children: [
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(-7.2575, 112.7521), // Surabaya
                  zoom: 12.5,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.bnn_app',
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
            _buildBottomNavigation(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      height: 65,
      decoration: const BoxDecoration(color: Color(0xFF063CA8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, Icons.home, 'Beranda', 0),
          _buildNavItem(context, Icons.map, 'Persebaran', 1),
          _buildNavItem(context, Icons.input, 'Masukkan', 2),
          _buildNavItem(context, Icons.book, 'E-Book', 3),
          _buildNavItem(context, Icons.person, 'Akun', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    bool isSelected = index == 1; // Persebaran is selected
    return GestureDetector(
      onTap: () {
        // Navigate to different screens based on index
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BerandaUserScreen(),
              ),
            );
            break;
          case 1:
            // Already on Persebaran, do nothing
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MasukkanScreen()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const EbookScreen()),
            );
            break;
          case 4:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AkunScreen()),
            );
            break;
        }
      },
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
  }
}
