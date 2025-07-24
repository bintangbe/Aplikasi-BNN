import 'package:flutter/material.dart';
import 'detail_lembaga_user_screen.dart';

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

  // Data lembaga rehabilitasi (sama dengan admin dashboard)
  final List<Map<String, dynamic>> allLembaga = [
    {
      'name': 'Klinik Pratama BNN Kota Surabaya',
      'location': 'Surabaya Selatan',
      'capacity': '17 orang',
      'alamatLengkap': 'Jl. Ngagel Madya V no. 22 Surabaya',
      'nomorTelepon': '081231878822',
      'jamOperasional': '09.00 - 17.00 WIB',
      'image': 'assets/images/klinik_pratama.jpeg',
      'email': 'rehab.bnnksby@gmail.com',
      'rating': 4.5,
      'type': 'Rawat Jalan',
    },
    {
      'name': 'Yayasan Rumah Kita Surabaya',
      'location': 'Surabaya Timur',
      'type': 'Rawat Inap',
      'capacity': '17 orang',
      'alamatLengkap': 'Jl. Ngagel Madya II / 9 Surabaya',
      'nomorTelepon': '081230724211',
      'jamOperasional': '24 Jam',
      'image': 'assets/images/yayasan_rumah_kita.jpeg',
      'email': 'rumahkitasby86@gmail.com',
      'rating': 4.8,
    },
    {
      'name': 'Yayasan Orbit Surabaya',
      'location': 'Surabaya Timur',
      'capacity': '24 orang',
      'alamatLengkap':
          'Jl. BarataJaya XII A No.6, RT.001/RW.004, Baratajaya, Kec. Gubeng, Surabaya',
      'nomorTelepon': '082245948605',
      'jamOperasional': '09.00 - 17.00 WIB',
      'image': 'assets/images/yayasan_orbit.jpeg',
      'email': 'orbit.foundation@yahoo.com',
      'rating': 4.6,
      'type': 'Rawat Jalan',
    },
    {
      'name': 'Yayasan Plato Surabaya',
      'location': 'Surabaya Timur',
      'capacity': '24 orang',
      'alamatLengkap':
          'Jl. Cipta Mananggal v No. 16, RT 011 RW 005, Kelurahan Menanggal, Kecamatan Gayungan',
      'nomorTelepon': '081330351599',
      'jamOperasional': '08.00 - 16.00 WIB',
      'image': 'assets/images/yayasan_plato_surabaya.jpeg',
      'email': 'plato.found@gmail.com',
      'rating': 4.7,
      'type': 'Rawat Inap',
    },
    {
      'name': 'Yayasan LRPPN-BI Surabaya',
      'location': 'Surabaya Selatan',
      'capacity': '20 orang',
      'alamatLengkap':
          'Jl. Khairil Anwar No.23, Darmo, Kec. Wonokromo, Surabaya',
      'nomorTelepon': '08123263524',
      'jamOperasional': '08.00 - 20.00 WIB',
      'image': 'assets/images/yayasan_lrppn.jpeg',
      'email': 'pantilrppnsurabaya@gmail.com',
      'rating': 4.4,
      'type': 'Rawat Jalan',
    },
    {
      'name': 'Yayasan Rumah Merah Putih Surabaya',
      'location': 'Waru',
      'capacity': '25 orang',
      'alamatLengkap': 'Jl. Blimbing I No.18, Ngipa, Wadungasri, Kec. Waru',
      'nomorTelepon': '085853125026',
      'jamOperasional': '09.00 - 15.00 WIB',
      'image': 'assets/images/yayasan_rumah_merah_putih.jpeg',
      'email': 'Mako2rungkut@gmail.com',
      'rating': 4.3,
      'type': 'Rawat Inap',
    },
    {
      'name': 'Yayasan Griya Ashefa Pusaka Surabaya',
      'location': 'Surabaya',
      'capacity': '20 orang',
      'alamatLengkap': 'Jl Kutisari XIA no 1 RT 08 RW 05 Surabaya',
      'nomorTelepon': '085959591822',
      'jamOperasional': '09.00 - 17.00 WIB',
      'image': 'assets/images/yayasan_ashefa_griya_pusaka.jpeg',
      'email': 'fpratiwisuryaningrums@gmail.com',
      'rating': 4.2,
      'type': 'Rawat Jalan',
    },
    {
      'name': 'RS Menur Surabaya',
      'location': 'Surabaya Pusat',
      'capacity': '42 orang',
      'alamatLengkap': 'Jl. Raya Menur No. 120 Surabaya',
      'nomorTelepon': '081330305585',
      'jamOperasional': 'Buka 24 jam',
      'image': 'assets/images/rs_menur.jpeg',
      'email': 'rsj.menur@gmail.com',
      'rating': 4.9,
      'type': 'Rawat Inap',
    },
  ];

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
                      _buildStatistics(),
                      Expanded(child: _buildLembagaList()),
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
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border, color: Colors.white),
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
          const SizedBox(height: 16),
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Semua', 'Rawat Inap', 'Rawat Jalan']
                  .map(
                    (filter) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        selected: selectedFilter == filter,
                        label: Text(filter),
                        onSelected: (selected) {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        selectedColor: const Color(0xFF2563EB).withOpacity(0.2),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: selectedFilter == filter
                              ? const Color(0xFF2563EB)
                              : Colors.grey[600],
                          fontWeight: selectedFilter == filter
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: selectedFilter == filter
                                ? const Color(0xFF2563EB)
                                : Colors.grey[300]!,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    final filteredCount = filteredLembaga.length;
    final totalCount = allLembaga.length;
    final rawatInapCount = allLembaga
        .where((l) => (l['type'] ?? '').contains('Rawat Inap'))
        .length;
    final rawatJalanCount = allLembaga
        .where((l) => (l['type'] ?? '').contains('Rawat Jalan'))
        .length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2563EB).withOpacity(0.1),
            const Color(0xFF063CA8).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF2563EB).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            'Total',
            totalCount.toString(),
            Icons.business,
            const Color(0xFF2563EB),
          ),
          _buildStatItem(
            'Rawat Inap',
            rawatInapCount.toString(),
            Icons.local_hospital,
            const Color(0xFF059669),
          ),
          _buildStatItem(
            'Rawat Jalan',
            rawatJalanCount.toString(),
            Icons.medical_services,
            const Color(0xFFDC2626),
          ),
          _buildStatItem(
            'Ditemukan',
            filteredCount.toString(),
            Icons.search,
            const Color(0xFFF59E0B),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
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
    final capacity = lembaga['capacity'] ?? 'Kapasitas tidak tersedia';
    final jamOperasional = lembaga['jamOperasional'] ?? 'Jam tidak tersedia';
    final image = lembaga['image'] ?? 'assets/images/placeholder.jpeg';

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
                _buildInfoRow(Icons.people, capacity, const Color(0xFF2563EB)),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DetailLembagaUserScreen(lembagaData: lembaga),
                        ),
                      );
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
