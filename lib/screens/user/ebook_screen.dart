import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'beranda_user.dart';
import 'persebaran_screen.dart';
import 'masukkan_screen.dart';
import 'akun_screen.dart';

class EbookScreen extends StatefulWidget {
  const EbookScreen({super.key});

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  String _selectedCategory = 'Semua';

  final List<String> _categories = [
    'Semua',
    'Edukasi',
    'Rehabilitasi',
    'Pencegahan',
    'Hukum',
  ];

  final List<Map<String, dynamic>> _ebooks = [
    {
      'title': 'Pedoman Pelaksanaan Reformasi Birokrasi',
      'author': 'BNN Republik Indonesia',
      'category': 'Pencegahan',
      'pages': 45,
      'downloadCount': 1250,
      'image': 'assets/images/BK0338.jpg',
      'description':
          'Pedoman Pelaksanaan Reformasi Birokrasi.',
      'url': 'https://perpustakaan.bnn.go.id/id/pedoman-pelaksanaan-reformasi-birokrasi',
    },
    {
      'title': 'Modul Rehabilitasi Narkoba',
      'author': 'Direktorat Rehabilitasi BNN',
      'category': 'Rehabilitasi',
      'pages': 78,
      'downloadCount': 890,
      'image': 'https://via.placeholder.com/120x160?text=Rehabilitasi',
      'description':
          'Modul komprehensif tentang proses rehabilitasi dan pemulihan dari ketergantungan narkoba.',
      'url': 'https://bnn.go.id/modul-rehabilitasi',
    },
    {
      'title': 'Undang-Undang Narkotika Terbaru',
      'author': 'Kementerian Hukum dan HAM',
      'category': 'Hukum',
      'pages': 156,
      'downloadCount': 2100,
      'image': 'https://via.placeholder.com/120x160?text=UU+Narkotika',
      'description':
          'Kompilasi lengkap peraturan perundang-undangan terkait narkotika dan psikotropika.',
      'url': 'https://jdih.kemenkumham.go.id/peraturan-narkotika',
    },
    {
      'title': 'Edukasi Bahaya Narkoba',
      'author': 'Tim Edukasi BNN',
      'category': 'Edukasi',
      'pages': 32,
      'downloadCount': 1780,
      'image': 'https://via.placeholder.com/120x160?text=Edukasi',
      'description':
          'Materi edukasi tentang jenis-jenis narkoba dan dampaknya bagi kesehatan.',
      'url': 'https://bnn.go.id/edukasi-bahaya-narkoba',
    },
    {
      'title': 'Modul Pembelajaran Rehabilitasi dan Konseling Dasar bagi Pecandu dan Korban Penyalahgunaan Narkotika Pada Layanan Rawat Jalan',
      'author': 'BNN Kota Surabaya',
      'category': 'Pencegahan',
      'pages': 28,
      'downloadCount': 945,
      'image': 'assets/images/Cover_2.jpg',
      'description':
          'Modul Pembelajaran Rehabilitasi dan Konseling Dasar bagi Pecandu dan Korban Penyalahgunaan Narkotika Pada Layanan Rawat Jalan.',
      'url': 'https://perpustakaan.bnn.go.id/id/modul-pembelajaran-rehabilitasi-dan-konseling-dasar-bagi-pecandu-dan-korban',
    },
    {
      'title': 'Deteksi Dini Penyalahgunaan Narkoba',
      'author': 'Pusat Penelitian BNN',
      'category': 'Edukasi',
      'pages': 52,
      'downloadCount': 1340,
      'image': 'https://via.placeholder.com/120x160?text=Deteksi+Dini',
      'description':
          'Panduan mengenali tanda-tanda awal penyalahgunaan narkoba dan langkah-langkah yang harus diambil.',
      'url': 'https://bnn.go.id/deteksi-dini-narkoba',
    },
  ];

  List<Map<String, dynamic>> get _filteredEbooks {
    if (_selectedCategory == 'Semua') {
      return _ebooks;
    }
    return _ebooks
        .where((ebook) => ebook['category'] == _selectedCategory)
        .toList();
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
                  child: Column(
                    children: [
                      _buildCategoryFilter(),
                      Expanded(child: _buildEbookList()),
                    ],
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
    bool isSelected = index == 3; // E-Book is selected
    return GestureDetector(
      onTap: () {
        // Navigate to different screens based on index
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BerandaUserScreen(),
              ),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PersebaranScreen()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MasukkanScreen()),
            );
            break;
          case 3:
            // Already on E-Book, do nothing
            break;
          case 4:
            Navigator.pushReplacement(
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'E-Book Edukasi\nAnti Narkoba',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.library_books, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${_ebooks.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: 'Inter',
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

  Widget _buildCategoryFilter() {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = category;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2563EB) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF2563EB)
                      : Colors.grey[500]!,
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  category,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                    letterSpacing: 0.5,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEbookList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _filteredEbooks.length,
      itemBuilder: (context, index) {
        final ebook = _filteredEbooks[index];
        return _buildEbookCard(ebook);
      },
    );
  }

  Widget _buildEbookCard(Map<String, dynamic> ebook) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                ebook['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.book,
                      size: 40,
                      color: Colors.grey,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ebook['title'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  ebook['author'],
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        ebook['category'],
                        style: const TextStyle(
                          color: Color(0xFF3B82F6),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(ebook['url']);
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch ${ebook['url']}');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        minimumSize: const Size(80, 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Baca',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Inter',
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

}
