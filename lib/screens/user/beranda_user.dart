import 'package:flutter/material.dart';
import 'persebaran_screen.dart';
import 'masukkan_screen.dart';
import 'ebook_screen.dart';
import 'akun_screen.dart';
import 'daftar_lembaga_user_screen.dart';
import 'detail_lembaga_user_screen.dart';
import 'unified_bottom_navigation_user.dart';
import '../../services/lembaga_service.dart';

class BerandaUserScreen extends StatefulWidget {
  const BerandaUserScreen({super.key});

  @override
  State<BerandaUserScreen> createState() => _BerandaUserScreenState();
}

class _BerandaUserScreenState extends State<BerandaUserScreen> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> topLembaga = [];

  @override
  void initState() {
    super.initState();
    _loadTopLembaga();
  }

  Future<void> _loadTopLembaga() async {
    try {
      final allLembaga = await LembagaService.instance.getAllLembaga();
      // Ambil 3 lembaga pertama sebagai top lembaga
      setState(() {
        topLembaga = allLembaga.take(3).toList();
      });
    } catch (e) {
      // Handle error if needed
    }
  }

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
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                      bottom: 120,
                    ), // Add bottom padding for navigation
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
      bottomNavigationBar: UnifiedBottomNavigationUser(
        currentIndex: _selectedIndex,
      ),
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
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
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
          // Image Section
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
          // Content Section
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
              const Flexible(
                child: Text(
                  'Berita Terbaru',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                _buildNewsCard(
                  'BNN Kota Surabaya Gencarkan Edukasi Bahaya Narkoba dan Deklarasi Pelajar Anti Narkoba di SMA Khadijah',
                  'assets/images/news1.jpg',
                  'https://surabayakota.bnn.go.id/bnn-kota-surabaya-gencarkan-edukasi-bahaya-narkoba-dan-deklarasi-pelajar-anti-narkoba-di-sma-khadijah/',
                ),
                _buildNewsCard(
                  'Fenomena Ibu Rumah Tangga Terlibat Narkoba, Kepala BNN Surabaya Tampil di Podcast Memorandum',
                  'assets/images/news2.jpg',
                  'https://surabayakota.bnn.go.id/bnn-surabaya-di-podcast-memorandum-rumah-tangga-jadi-target-baru-peredaran-narkoba/',
                ),
                _buildNewsCard(
                  'BNN Kota Surabaya Perkuat Ketahanan Remaja Lewat Sosialisasi Napza dan Rokok',
                  'assets/images/news3.jpg',
                  'https://surabayakota.bnn.go.id/bnn-kota-surabaya-gencarkan-sosialisasi-bahaya-narkoba-di-sejumlah-sekolah-saat-mpls/',
                ),
                _buildNewsCard(
                  'BNN Kota Surabaya Berikan Sosialisasi P4GN dan Pembinaan kepada Peserta Abdi Yasa Dishub',
                  'assets/images/news4.jpg',
                  'https://surabayakota.bnn.go.id/bnn-kota-surabaya-gencarkan-sosialisasi-bahaya-narkoba-di-sejumlah-sekolah-saat-mpls/',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ), // Reduced since we added padding to SingleChildScrollView
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
              content: Text('Membuka: ${title.length > 30 ? title.substring(0, 30) : title}...'),
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
            Flexible(
              child: Padding(
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
            ),
          ],
        ),
      ),
    );
  }
}
