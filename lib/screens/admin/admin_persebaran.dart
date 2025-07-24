import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'unified_bottom_navigation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/responsive_wrapper.dart';

class AdminPersebaranScreen extends StatelessWidget {
  const AdminPersebaranScreen({super.key});

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
        backgroundColor: const Color(0xFF063CA8),
        body: ResponsiveWrapper(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final Uri url = Uri.parse('https://surabayakota.bnn.go.id');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/logo_bnn.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Peta Persebaran',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
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
              ),
              UnifiedBottomNavigation(
                currentIndex: 1, // Pesebaran
              ),
            ],
          ),
        ),
      ),
    );
  }
}
