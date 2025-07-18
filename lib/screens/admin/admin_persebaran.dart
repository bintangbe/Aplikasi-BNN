import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Persebaran'),
        backgroundColor: const Color(0xFF063CA8),
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
                MarkerLayer(
                  markers: markers,
                ),
              ],
            ),
          ),
          Container(
            height: 65,
            color: const Color(0xFF063CA8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _FooterItem(icon: Icons.home, label: 'Beranda'),
                _FooterItem(icon: Icons.map, label: 'Pesebaran', isActive: true),
                _FooterItem(icon: Icons.add, label: 'Pengajuan'),
                _FooterItem(icon: Icons.history, label: 'Riwayat'),
                _FooterItem(icon: Icons.person, label: 'Akun'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _FooterItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? Colors.white : Colors.white70),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
