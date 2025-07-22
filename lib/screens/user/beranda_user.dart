import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/colors.dart';
import 'persebaran_screen.dart';
import 'masukkan_screen.dart';
import 'ebook_screen.dart';
import 'akun_screen.dart';

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
                      children: [_buildRehabSection(), _buildNewsSection()],
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
            onTap: () async {
              // Open BNN website
              final Uri url = Uri.parse('https://surabayakota.bnn.go.id/');
              try {
                if (!await launchUrl(url)) {
                  throw Exception('Could not launch https://surabayakota.bnn.go.id/');
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tidak dapat membuka website BNN Surabaya'),
                    backgroundColor: Color(0xFFEF4444),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Container(
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.9),
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

  Widget _buildRehabSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daftar Lembaga Rehab',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(4, (index) => _buildRehabCard(index)),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Navigate to full rehab list
              },
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: Color(0xFF3B82F6),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRehabCard(int index) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 6,
            offset: const Offset(0, 4),
            spreadRadius: -1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Lembaga Rehabilitasi ${String.fromCharCode(65 + index)}',
            style: const TextStyle(
              color: Color(0xFF1D4ED8),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Navigate to detail
            },
            child: const Text(
              'Lihat Detail',
              style: TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
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
              TextButton(
                onPressed: () {
                  // TODO: Navigate to all news
                },
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(
                    color: Color(0xFF3B82F6),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
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
              children: [
                _buildNewsCard(
                  'BNN Kota Surabaya Gencarkan Edukasi Bahaya Narkoba dan Deklarasi Pelajar Anti Narkoba di SMA Khadijah',
                  'https://via.placeholder.com/258x130?text=BNN+Edukasi',
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
    return GestureDetector(
      onTap: () async {
        if (newsUrl != null) {
          final Uri url = Uri.parse(newsUrl);
          try {
            if (!await launchUrl(url)) {
              throw Exception('Could not launch $newsUrl');
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tidak dapat membuka link berita'),
                backgroundColor: Color(0xFFEF4444),
                duration: Duration(seconds: 2),
              ),
            );
          }
        }
      },
      child: Container(
        width: 258,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 258,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
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
