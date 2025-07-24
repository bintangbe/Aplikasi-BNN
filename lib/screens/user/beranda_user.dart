import 'package:flutter/material.dart';
import 'persebaran_screen.dart';
import 'masukkan_screen.dart';
import 'ebook_screen.dart';
import 'akun_screen.dart';
import 'daftar_lembaga_user_screen.dart';
import 'detail_lembaga_user_screen.dart';

class BerandaUserScreen extends StatefulWidget {
  const BerandaUserScreen({super.key});

  @override
  State<BerandaUserScreen> createState() => _BerandaUserScreenState();
}

class _BerandaUserScreenState extends State<BerandaUserScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
              _buildHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildQuickSearchSection(),
                        _buildRehabSection(),
                        _buildNewsSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          // Logo BNN
          GestureDetector(
            onTap: () {
              // Open BNN website
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Membuka website BNN Surabaya...'),
                  backgroundColor: Color(0xFF2563EB),
                  duration: Duration(seconds: 2),
                ),
              );
              // TODO: Add url_launcher package and implement: launch('https://surabayakota.bnn.go.id/');
            },
            child: Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.9),
              ),
              child: Image.asset(
                'assets/images/logo_bnn.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'BNN',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF063CA8),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Kota Surabaya
          const Expanded(
            child: Text(
              'KOTA\nSURABAYA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ),
          // User Profile
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AkunScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'User',
                    style: TextStyle(
                      color: Color(0xFF063CA8),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: Color(0xFF063CA8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSearchSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cari Lembaga Rehabilitasi',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
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
              onTap: () {
                // Navigate to search screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DaftarLembagaUserScreen(),
                  ),
                );
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Cari berdasarkan nama atau lokasi...',
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Container(
                  padding: const EdgeInsets.all(12),
                  child: Icon(Icons.search, color: Colors.grey[400]),
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.tune, color: Colors.white, size: 16),
                ),
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

  // Data lembaga rehabilitasi (integrated with admin data)
  final List<Map<String, dynamic>> topLembaga = [
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
  ];

  Widget _buildRehabSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daftar Lembaga Rehabilitasi',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(
            topLembaga.length,
            (index) => _buildRehabCard(topLembaga[index]),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF063CA8)],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DaftarLembagaUserScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.list_alt, color: Colors.white),
                label: const Text(
                  'Lihat Semua Lembaga',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRehabCard(Map<String, dynamic> lembaga) {
    final name = lembaga['name'] ?? 'Nama tidak tersedia';
    final location = lembaga['location'] ?? 'Lokasi tidak tersedia';
    final image = lembaga['image'] ?? 'assets/images/placeholder.jpeg';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Image Section
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Colors.grey[200],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
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
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
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
          // Content Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Color(0xFF1D4ED8),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.local_hospital,
                        color: Color(0xFF2563EB),
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailLembagaUserScreen(lembagaData: lembaga),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Lihat Detail',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Inter',
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

  Widget _buildNewsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Berita Terbaru',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildNewsCard(
                  'BNN Kota Surabaya Gencarkan Edukasi Bahaya Narkoba dan Deklarasi Pelajar Anti Narkoba di SMA Khadijah',
                  'assets/images/BK0338.jpg',
                  'https://surabayakota.bnn.go.id/bnn-kota-surabaya-gencarkan-edukasi-bahaya-narkoba-dan-deklarasi-pelajar-anti-narkoba-di-sma-khadijah/',
                ),
                _buildNewsCard(
                  'Fenomena Ibu Rumah Tangga Terlibat Narkoba, Kepala BNN Surabaya Tampil di Podcast Memorandum',
                  'https://via.placeholder.com/258x130?text=Podcast+BNN',
                  'https://surabayakota.bnn.go.id/bnn-surabaya-di-podcast-memorandum-rumah-tangga-jadi-target-baru-peredaran-narkoba/',
                ),
                _buildNewsCard(
                  'BNN Kota Surabaya Perkuat Ketahanan Remaja Lewat Sosialisasi Napza dan Rokok',
                  'https://via.placeholder.com/258x130?text=Sosialisasi+Remaja',
                  'https://surabayakota.bnn.go.id/bnn-kota-surabaya-perkuat-ketahanan-remaja-lewat-sosialisasi-napza-dan-rokok/',
                ),
                _buildNewsCard(
                  'BNN Kota Surabaya Gencarkan Sosialisasi Bahaya Narkoba di Sejumlah Sekolah Saat MPLS',
                  'https://via.placeholder.com/258x130?text=MPLS+Sekolah',
                  'https://surabayakota.bnn.go.id/bnn-kota-surabaya-gencarkan-sosialisasi-bahaya-narkoba-di-sejumlah-sekolah-saat-mpls/',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildNewsCard(String title, String imageUrl, [String? newsUrl]) {
    final bool isAssetImage = imageUrl.startsWith('assets/');

    return GestureDetector(
      onTap: () {
        if (newsUrl != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Membuka: ${title.substring(0, 30)}...'),
              duration: const Duration(seconds: 2),
              backgroundColor: const Color(0xFF2563EB),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 280,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Colors.grey[200],
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: isAssetImage
                              ? AssetImage(imageUrl) as ImageProvider
                              : NetworkImage(imageUrl),
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
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
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
                  // News badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2563EB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'BERITA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 65,
      decoration: const BoxDecoration(color: Color(0xFF063CA8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home, 'Beranda', 0),
          _buildNavItem(Icons.map, 'Persebaran', 1),
          _buildNavItem(Icons.input, 'Masukkan', 2),
          _buildNavItem(Icons.book, 'E-Book', 3),
          _buildNavItem(Icons.person, 'Akun', 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });

        // Navigate to different screens based on index
        switch (index) {
          case 0:
            // Already on Beranda, do nothing
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PersebaranScreen()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MasukkanScreen()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EbookScreen()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AkunScreen()),
            );
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF062766) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
