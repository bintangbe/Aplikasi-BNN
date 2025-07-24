import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'unified_bottom_navigation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/responsive_wrapper.dart';
import '../../services/rehabilitasi_service.dart';
import '../../models/rehabilitasi_model.dart';

class AdminPersebaranScreen extends StatefulWidget {
  const AdminPersebaranScreen({super.key});

  @override
  State<AdminPersebaranScreen> createState() => _AdminPersebaranScreenState();
}

class _AdminPersebaranScreenState extends State<AdminPersebaranScreen> {
  List<Marker> _markers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    setState(() => _isLoading = true);
    try {
      final rehabilitasiData = await RehabilitasiService.getAllRehabilitasi();
      final List<Marker> markers = [];

      // Add rehabilitation data markers
      for (RehabilitasiModel data in rehabilitasiData) {
        if (data.latitude != null && data.longitude != null) {
          markers.add(
            Marker(
              width: 50.0,
              height: 50.0,
              point: LatLng(data.latitude!, data.longitude!),
              child: GestureDetector(
                onTap: () => _showMarkerInfo(data),
                child: Container(
                  decoration: BoxDecoration(
                    color: _getMarkerColor(data.statusProgress),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          );
        }
      }

      setState(() {
        _markers = markers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error memuat data: $e')),
        );
      }
    }
  }

  Color _getMarkerColor(String status) {
    switch (status) {
      case 'Selesai':
        return const Color(0xFF22C55E); // Green
      case 'Masa Rehab':
        return const Color(0xFFF59E0B); // Orange
      default:
        return const Color(0xFF3B82F6); // Blue
    }
  }

  void _showMarkerInfo(RehabilitasiModel data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _getMarkerColor(data.statusProgress),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                data.nama,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('NIK', data.nik, Icons.badge),
            _buildInfoRow('Alamat', data.alamat, Icons.location_on),
            _buildInfoRow('Status', data.statusProgress, Icons.info),
            _buildInfoRow('Lembaga', data.lembagaRehab, Icons.business),
            _buildInfoRow('Tanggal Masuk', data.tanggalMasuk, Icons.calendar_today),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: const Color(0xFF6B7280)),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF063CA8)),
                        ),
                      )
                    : Stack(
                        children: [
                          FlutterMap(
                            options: MapOptions(
                              center: LatLng(-7.2575, 112.7521), // Pusat Kota Surabaya
                              zoom: 12.0, // Zoom untuk melihat area Surabaya
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.bnn_app',
                              ),
                              MarkerLayer(markers: _markers),
                            ],
                          ),
                          // Legend
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Keterangan:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  _buildLegendItem('Selesai', const Color(0xFF22C55E)),
                                  _buildLegendItem('Masa Rehab', const Color(0xFFF59E0B)),
                                ],
                              ),
                            ),
                          ),
                          // Refresh button
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: FloatingActionButton(
                              mini: true,
                              backgroundColor: const Color(0xFF063CA8),
                              onPressed: _loadMarkers,
                              child: const Icon(Icons.refresh, color: Colors.white),
                            ),
                          ),
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

  Widget _buildLegendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}
