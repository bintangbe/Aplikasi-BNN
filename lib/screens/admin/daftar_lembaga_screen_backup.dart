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

  final List<Map<String, String>> allLembaga = [
    {
      'name': 'Yayasan Rumah Kita Surabaya',
      'location': 'Surabaya Timur',
      'type': 'Rawat Inap',
      'capacity': '22 tempat tidur',
      'alamatLengkap': 'Jl. Ngagel Madya II / 9 Surabaya',
      'nomorTelepon': '0821-3122-2775',
      'jamOperasional': '08.00 - 20.00 WIB',
      'fasilitas': 'Ruang rawat inap, ruang terapi, konseling',
      'image': 'assets/images/yayasan_rumah_kita.jpeg',
    },
    {
      'name': 'Yayasan Orbit Surabaya',
      'location': 'Surabaya Timur',
      'type': 'Rawat Inap',
      'capacity': '20 tempat tidur',
      'alamatLengkap':
          'Jl. BarataJaya XII A No.6, RT.001/RW.004, Baratajaya, Kec. Gubeng, Surabaya',
      'nomorTelepon': '0812-3356-3815',
      'jamOperasional': '09.00 - 17.00 WIB',
      'fasilitas': 'Ruang rawat inap, ruang terapi, laboratorium, apotek',
      'image': 'assets/images/yayasan_orbit_surabaya.jpeg',
    },
    {
      'name': 'Yayasan Plato Surabaya',
      'location': 'Surabaya Selatan',
      'type': 'Rawat Jalan',
      'capacity': '25 tempat tidur',
      'alamatLengkap':
          'Jl. Cipta Mananggal v No. 16, RT 011 RW 005, Kelurahan Menanggal, Kecamatan Gayungan',
      'nomorTelepon': '0813-3035-1599',
      'jamOperasional': '09.00 - 17.00 WIB',
      'fasilitas': 'Poliklinik umum, ruang konseling, farmasi',
      'image': 'assets/images/yayasan_plato_surabaya.jpeg',
    },
    {
      'name': 'Yayasan LRPPN-BI Surabaya',
      'location': 'Surabaya Selatan',
      'type': 'Rawat Inap & Jalan',
      'capacity': '35 tempat tidur',
      'alamatLengkap':
          'Jl. Khairil Anwar No.23, Darmo, Kec. Wonokromo, Surabaya',
      'nomorTelepon': '0889-8900-7635',
      'jamOperasional': '09.00 - 17.00 WIB',
      'fasilitas':
          'Ruang rawat inap, poliklinik, terapi kelompok, konseling individu',
      'image': 'assets/images/yayasan_lrppn_surabaya.jpeg',
    },
    {
      'name': 'Yayasan Rumah Merah Putih Surabaya',
      'location': 'Sidoarjo',
      'type': 'Rawat Jalan',
      'capacity': '15 tempat tidur',
      'alamatLengkap': 'Jl. Blimbing I No.18, Ngipa, Wadungasri, Kec. Waru',
      'nomorTelepon': 'Tidak tersedia',
      'jamOperasional': '09.00 - 15.00 WIB',
      'fasilitas': 'Konseling, terapi kelompok, program rehabilitasi sosial',
      'image': 'assets/images/yayasan_rumah_merah_putih.jpeg',
    },
    {
      'name': 'Yayasan Griya Ashefa Pusaka Surabaya',
      'location': 'Surabaya',
      'type': 'Rawat Inap',
      'capacity': 'Coming Soon',
      'alamatLengkap': 'Coming Soon',
      'nomorTelepon': 'Coming Soon',
      'jamOperasional': 'Coming Soon',
      'fasilitas': 'Coming Soon',
      'image': 'assets/images/placeholder.jpeg',
    },
    {
      'name': 'RS Menur Surabaya',
      'location': 'Surabaya Pusat',
      'type': 'Rawat Jalan',
      'capacity': '20 tempat tidur',
      'alamatLengkap':
          'Jl.Raya Menur No.120, Kelurahan Kertajaya, Kecamatan Airlagga, Kota Surabaya',
      'nomorTelepon': '0811-3633-120',
      'jamOperasional': 'Buka 24 jam',
      'fasilitas': 'Konseling, terapi seni, program rehabilitasi keluarga',
      'image': 'assets/images/rs_menur_surabaya.jpeg',
    },
    {
      'name': 'Omah Sehat Bersinar',
      'location': 'Surabaya Pusat',
      'type': 'Rawat Inap',
      'capacity': '30 tempat tidur',
      'alamatLengkap': 'Jl. Jemur Andayani No.50 Surabaya',
      'nomorTelepon': 'Tidak tersedia',
      'jamOperasional': '08.00 - 17.00 WIB',
      'fasilitas': 'Ruang rawat inap, ruang terapi, konseling keluarga',
      'image': 'assets/images/yayasan_omah_sehat_bersinar.jpeg',
    },
  ];

  List<Map<String, String>> get filteredLembaga {
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
    return Scaffold(
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
                        _buildStatistics(),
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
          // Bottom Navigation
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: UnifiedBottomNavigation(currentIndex: 1), // Index 1 for Daftar Lembaga
          ),
        ],
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
            const Color(0xFF0050FF).withOpacity(0.1),
            const Color(0xFF00AEEF).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF0050FF).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total', totalCount.toString(), Icons.business),
          _buildStatItem(
            'Rawat Inap',
            rawatInapCount.toString(),
            Icons.local_hospital,
          ),
          _buildStatItem(
            'Rawat Jalan',
            rawatJalanCount.toString(),
            Icons.medical_services,
          ),
          _buildStatItem('Ditemukan', filteredCount.toString(), Icons.search),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF0050FF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF0050FF), size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0050FF),
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

  Widget _buildLembagaCard(Map<String, String> lembaga) {
    // Null safety untuk semua field
    final name = lembaga['name'] ?? 'Nama tidak tersedia';
    final location = lembaga['location'] ?? 'Lokasi tidak tersedia';
    final type = lembaga['type'] ?? 'Tipe tidak tersedia';
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
                  // Type badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getTypeColor(type),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.phone,
                            size: 16,
                            color: Color(0xFF22C55E),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.location_on,
                            size: 16,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                      ],
                    ),
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

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Rawat Inap':
        return const Color(0xFFF59E0B);
      case 'Rawat Jalan':
        return const Color(0xFF3B82F6);
      case 'Rawat Inap & Jalan':
        return const Color(0xFF22C55E);
      default:
        return const Color(0xFF6B7280);
    }
  }

  @override
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/beranda-user');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_outlined, color: Colors.grey[400], size: 24),
                const SizedBox(height: 4),
                Text(
                  'Beranda',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/persebaran');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map_outlined, color: Colors.grey[400], size: 24),
                const SizedBox(height: 4),
                Text(
                  'Persebaran',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/masukkan');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.report_outlined, color: Colors.grey[400], size: 24),
                const SizedBox(height: 4),
                Text(
                  'Masukkan',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/ebook');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.book_outlined, color: Colors.grey[400], size: 24),
                const SizedBox(height: 4),
                Text(
                  'E-Book',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/akun');
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Akun',
                  style: TextStyle(
                    color: Color(0xFF063CA8),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
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
