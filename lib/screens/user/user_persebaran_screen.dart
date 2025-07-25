import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../services/rehabilitasi_service.dart';

class UserPersebaranScreen extends StatefulWidget {
  const UserPersebaranScreen({super.key});

  @override
  State<UserPersebaranScreen> createState() => _UserPersebaranScreenState();
}

class _UserPersebaranScreenState extends State<UserPersebaranScreen> {
  List<Marker> _markers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  Future<void> _loadMarkers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<Map<String, dynamic>> markersData = 
          await RehabilitasiService.getMapMarkers();

      List<Marker> markers = [];

      for (var data in markersData) {
        markers.add(
          Marker(
            point: LatLng(
              data['latitude'] as double,
              data['longitude'] as double,
            ),
            width: 30,
            height: 30,
            child: Icon(
              Icons.location_pin,
              color: _getMarkerColor(data['status']),
              size: 30,
            ),
          ),
        );
      }

      setState(() {
        _markers = markers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Color _getMarkerColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return Colors.green;
      case 'masa rehab':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Peta Persebaran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2B3A67),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: const LatLng(-7.250445, 112.768845),
                    initialZoom: 12.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(markers: _markers),
                  ],
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Keterangan:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_pin, color: Colors.green, size: 16),
                            SizedBox(width: 4),
                            Text('Selesai', style: TextStyle(fontSize: 10)),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.location_pin, color: Colors.orange, size: 16),
                            SizedBox(width: 4),
                            Text('Masa Rehab', style: TextStyle(fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
