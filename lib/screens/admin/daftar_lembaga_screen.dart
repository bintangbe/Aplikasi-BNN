import 'package:flutter/material.dart';
import 'detail_lembaga_screen.dart';
import 'unified_bottom_navigation.dart';

class DaftarLembagaScreen extends StatefulWidget {
  const DaftarLembagaScreen({super.key});

  @override
  State<DaftarLembagaScreen> createState() => _DaftarLembagaScreenState();
}

class _DaftarLembagaScreenState extends State<DaftarLembagaScreen> {
  String selectedFilter = 'Semua';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> allLembaga = [
    {
      'name': 'Klinik Pratama BNN Kota Surabaya',
      'location': 'Surabaya Selatan',
      'capacity': '17 orang',
      'alamatLengkap': 'Jl. ngagel Madya V no. 22 Surabaya',
      'nomorTelepon': '081231878822',
      'jamOperasional': '09.00 - 17.00 WIB',
      'image': 'assets/images/klinik_pratama.jpeg',
      'email': 'rehab.bnnksby@gmail.com',
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
    },
    {
      'name': 'Omah Sehat Bersinar',
      'location': 'Surabaya Pusat',
      'capacity': '30 orang',
      'alamatLengkap': 'Jl. Jemur Andayani No.50 Surabaya',
      'nomorTelepon': 'Tidak tersedia',
      'jamOperasional': '08.00 - 17.00 WIB',
      'image': 'assets/images/yayasan_omah_sehat_bersinar.jpeg',
    },
    {
      'name': 'Subdirektorat Mitigasi Crisis Center Unesa',
      'location': 'Surabaya Barat',
      'type': 'Rawat Jalan',
      'capacity': '20 orang',
      'alamatLengkap': 'Kampus Unesa Lidah Wetan, Surabaya',
      'nomorTelepon': '0812-3456-7890',
      'jamOperasional': '09.00 - 16.00 WIB',
      'image': 'assets/images/smcc_unesa.jpeg',
    },
  ];

  List<Map<String, dynamic>> get filteredLembaga {
    var filtered = allLembaga.where((lembaga) {
      // Null safety checks
      final name = lembaga['name'] ?? '';
      final location = lembaga['location'] ?? '';
      final type = lembaga['type'] ?? '';

      final matchesFilter = selectedFilter == 'Semua' || type == selectedFilter;
      final matchesSearch =
          name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          location.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesFilter && matchesSearch;
    }).toList();

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  _buildAppBar(context),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildSearchAndFilter(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 100),
                              child: _buildLembagaList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Unified Bottom Navigation
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: UnifiedBottomNavigation(currentIndex: 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
              'Daftar Lembaga Rehabilitasi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
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
                // Filter action
              },
              icon: const Icon(Icons.tune, color: Colors.white),
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
              children:
                  ['Semua', 'Rawat Inap', 'Rawat Jalan', 'Rawat Inap & Jalan']
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
                            selectedColor: const Color(
                              0xFF0050FF,
                            ).withOpacity(0.2),
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color: selectedFilter == filter
                                  ? const Color(0xFF0050FF)
                                  : Colors.grey[600],
                              fontWeight: selectedFilter == filter
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: selectedFilter == filter
                                    ? const Color(0xFF0050FF)
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
    // Null safety untuk semua field
    final name = lembaga['name'] ?? 'Nama tidak tersedia';
    final location = lembaga['location'] ?? 'Lokasi tidak tersedia';
    final capacity = lembaga['capacity'] ?? 'Kapasitas tidak tersedia';
    final jamOperasional = lembaga['jamOperasional'] ?? 'Jam tidak tersedia';
    final image = lembaga['image'] ?? 'assets/images/placeholder.jpeg';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Colors.grey[200], // Fallback color
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  // Image with error handling
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          debugPrint('Error loading image: $image');
                        },
                      ),
                    ),
                    // Fallback when image fails to load
                    child: image.contains('placeholder') || image.isEmpty
                        ? Container(
                            color: Colors.grey[300],
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 40,
                                color: Colors.grey[500],
                              ),
                            ),
                          )
                        : null,
                  ),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
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
                    color: Color(0xFF1D4ED8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.people, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        capacity,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        jamOperasional,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailLembagaScreen(lembagaData: lembaga),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0050FF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Lihat Detail',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
