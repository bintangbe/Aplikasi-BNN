import 'package:flutter/material.dart';
import 'detail_lembaga_user_screen.dart';
import '../../services/lembaga_service.dart';

class DaftarLembagaUserScreen extends StatefulWidget {
  const DaftarLembagaUserScreen({super.key});

  @override
  State<DaftarLembagaUserScreen> createState() =>
      _DaftarLembagaUserScreenState();
}

class _DaftarLembagaUserScreenState extends State<DaftarLembagaUserScreen> {
  String selectedFilter = 'Semua';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> allLembaga = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLembagaData();
  }

  Future<void> _loadLembagaData() async {
    try {
      final data = await LembagaService.instance.getAllLembaga();
      setState(() {
        allLembaga = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error if needed
    }
  }

  List<Map<String, dynamic>> get filteredLembaga {
    var filtered = allLembaga.where((lembaga) {
      final name = lembaga['name'] ?? '';
      final location = lembaga['location'] ?? '';
      final type = lembaga['type'] ?? '';

      final matchesFilter = selectedFilter == 'Semua' || type == selectedFilter;
      final matchesSearch =
          name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          location.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesFilter && matchesSearch;
    }).toList();

    // Sort by rating (highest first)
    filtered.sort((a, b) => (b['rating'] ?? 0).compareTo(a['rating'] ?? 0));

    return filtered;
  }

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
                  child: Column(
                    children: [
                      _buildSearchAndFilter(),
                      Expanded(
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFF2563EB),
                                ),
                              )
                            : _buildLembagaList(),
                      ),
                    ],
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
              'Lembaga Rehabilitasi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari lembaga rehabilitasi...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            searchQuery = '';
                          });
                        },
                        icon: Icon(Icons.clear, color: Colors.grey[400]),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLembagaList() {
    if (filteredLembaga.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Tidak ada lembaga ditemukan',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Coba ubah kata kunci pencarian atau filter',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: filteredLembaga.length,
      itemBuilder: (context, index) {
        final lembaga = filteredLembaga[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildLembagaCard(lembaga),
        );
      },
    );
  }

  Widget _buildLembagaCard(Map<String, dynamic> lembaga) {
    final name = lembaga['name'] ?? 'Nama tidak tersedia';
    final location = lembaga['location'] ?? 'Lokasi tidak tersedia';
    final jamOperasional = lembaga['jamOperasional'] ?? 'Jam tidak tersedia';
    final image = lembaga['image'] ?? 'assets/images/placeholder.jpeg';

    // Get integrated capacity information
    final kapasitasLaki = lembaga['kapasitasLaki'] ?? 0;
    final kapasitasPerempuan = lembaga['kapasitasPerempuan'] ?? 0;
    final rawatInapLaki = lembaga['rawatInapLaki'] ?? 0;
    final rawatInapPerempuan = lembaga['rawatInapPerempuan'] ?? 0;

    // Calculate capacity display
    String capacityDisplay;
    if (kapasitasLaki > 0 || kapasitasPerempuan > 0) {
      final totalKapasitas = kapasitasLaki + kapasitasPerempuan;
      final totalTerisi = rawatInapLaki + rawatInapPerempuan;
      final sisaKapasitas = totalKapasitas - totalTerisi;
      capacityDisplay = '$sisaKapasitas / $totalKapasitas tersedia';
    } else {
      // Fallback to old capacity structure
      capacityDisplay = lembaga['capacity'] ?? 'Kapasitas tidak tersedia';
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header with Rating Badge
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.grey[200],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
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
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  Icons.location_on,
                  location,
                  const Color(0xFF059669),
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.people,
                  capacityDisplay,
                  const Color(0xFF2563EB),
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.access_time,
                  jamOperasional,
                  const Color(0xFFF59E0B),
                ),
                const SizedBox(height: 16),
                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetailLembagaUserScreen(lembagaData: lembaga),
                        ),
                      );

                      // Refresh data jika ada perubahan
                      if (result == true) {
                        await _loadLembagaData();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Lihat Detail',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
