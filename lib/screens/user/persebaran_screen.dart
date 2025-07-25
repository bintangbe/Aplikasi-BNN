import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'beranda_user.dart';
import 'masukkan_screen.dart';
import 'ebook_screen.dart';
import 'akun_screen.dart';
import 'unified_bottom_navigation_user.dart';
import '../../services/rehabilitasi_service.dart';
import '../../models/rehabilitasi_model.dart';

class PersebaranScreen extends StatefulWidget {
  const PersebaranScreen({super.key});

  @override
  State<PersebaranScreen> createState() => _PersebaranScreenState();
}

class _PersebaranScreenState extends State<PersebaranScreen> {
  List<RehabilitasiModel> rehabilitasiData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRehabilitasiData();
  }

  Future<void> _loadRehabilitasiData() async {
    try {
      final data = await RehabilitasiService.getAllRehabilitasi();
      setState(() {
        rehabilitasiData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Color _getMarkerColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return Colors.green;
      case 'dalam proses':
      case 'masa rehab':
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  String _getDisplayStatus(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return 'Selesai';
      case 'dalam proses':
      case 'masa rehab':
      case 'pending':
      default:
        return 'Masa Rehab';
    }
  }

  List<Widget> _buildFixedLegend() {
    return [
      _buildLegendItem('Selesai', Colors.green),
      const SizedBox(height: 4),
      _buildLegendItem('Masa Rehab', Colors.orange),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation
      child: Scaffold(
        body: Column(
          children: [
            // Header dengan logo BNN
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF063CA8), Color(0xFF2563EB)],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Logo BNN
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Image.asset(
                            'assets/images/logo_bnn.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Text(
                                  'BNN',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF063CA8),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Title
                      const Text(
                        'Peta Persebaran',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Legend dengan posisi absolut
            Expanded(
              child: Stack(
                children: [
                  // Map
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF063CA8),
                          ),
                        )
                      : FlutterMap(
                          options: MapOptions(
                            center: LatLng(-7.2575, 112.7521), // Surabaya
                            zoom: 12.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.bnn_app',
                            ),
                            MarkerLayer(markers: _buildMarkers()),
                          ],
                        ),
                  // Legend positioned at top right
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Keterangan:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Tampilkan legend tetap sesuai gambar
                          ..._buildFixedLegend(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: UnifiedBottomNavigationUser(currentIndex: 1),
      ),
    );
  }

  List<Marker> _buildMarkers() {
    return rehabilitasiData.map((data) {
      // Parse coordinates
      double? lat, lng;
      try {
        if (data.latitude != null && data.longitude != null) {
          lat = data.latitude;
          lng = data.longitude;
        }
      } catch (e) {
        // Skip invalid coordinates
        return null;
      }

      if (lat == null || lng == null) {
        return null;
      }

      return Marker(
        width: 50.0,
        height: 50.0,
        point: LatLng(lat, lng),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _getMarkerColor(data.status),
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 24,
          ),
        ),
      );
    }).where((marker) => marker != null).cast<Marker>().toList();
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            border: Border.all(color: Colors.white, width: 1),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
