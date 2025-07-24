import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'beranda_user.dart';
import 'masukkan_screen.dart';
import 'ebook_screen.dart';
import 'akun_screen.dart';
import 'unified_bottom_navigation_user.dart';

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
          ],
        ),
        bottomNavigationBar: UnifiedBottomNavigationUser(currentIndex: 1),
      ),
    );
  }

  // ...existing code...
}
