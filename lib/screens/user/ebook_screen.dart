import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'beranda_user.dart';
import 'persebaran_screen.dart';
import 'masukkan_screen.dart';
import 'akun_screen.dart';
import 'unified_bottom_navigation_user.dart';

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
      'image': 'assets/images/BK0338.jpg',
      'url': 'https://ekatalogperpustakaan.bnn.go.id/flipbooks/BK0338_2022_Pedoman_Pelaksanaan_Reformasi_Birokrasi/index.html',
      'pdfUrl': 'https://perpustakaan.bnn.go.id/sites/default/files/Buku_Digital_2023-08/BK0338_2022_Pedoman_Pelaksanaan_Reformasi_Birokrasi.pdf',
      'description':
          'Pedoman Pelaksanaan Reformasi Birokrasi.',
    },
    {
      'title': 'Layanan Telerehabilitasi Narkoba Di Lingkungan Badan Narkotika Nasional Republik Indonesia',
      'author': 'Tim Penyusun BNN',
      'category': 'Rehabilitasi',
      'image': 'assets/images/Cover.jpg',
      'url': 'https://ekatalogperpustakaan.bnn.go.id/flipbooks/BK0339_2022_Petunjuk_Teknis_Layanan_Telerehabilitasi_Narkoba_di_Lingkungan_BNN/index.html',
      'pdfUrl': 'https://perpustakaan.bnn.go.id/sites/default/files/Buku_Digital_2023-08/BK0339_2022_Petunjuk_Teknis_Layanan_Telerehabilitasi_Narkoba_di_Lingkungan_BNN.pdf',
      'description':
          'Petunjuk Teknis ini memuat berbagai informasi yang rinci mengenai pelaksanaan layanan TREN yang akan diselenggarakan di klinik BNNP/K dan Unit Pelaksana Teknis Rehabilitasi milik BNN RI. Secara umum, buku ini tersusun dari 6 (enam) bab, meliputi pendahuluan, pelaksanaan pelayanan TREN, pengembangan pelayanan TREN, pemanfaatan teknologi dalam layanan TREN, monitoring dan evaluasi pelayanan TREN, dan penutup.',
    },
    {
      'title': 'Himpunan Peraturan Perundang-undangan Tindak Pidana Narkotika',
      'author': 'Kementerian Hukum dan HAM',
      'category': 'Hukum',
      'image': 'assets/images/Himpunan.jpg',
      'url': 'https://ekatalogperpustakaan.bnn.go.id/flipbooks/BK0248_2018_Himpunan_Peraturan_Perundang_undangan_Tindak_Pidana_Narkotik/index.html',
      'pdfUrl': 'https://perpustakaan.bnn.go.id/sites/default/files/Buku_Digital_2021-10/BK0248_2018_Himpunan_Peraturan_Perundang_undangan_Tindak_Pidana_Narkotika.pdf',
      'description':
          'Kompilasi lengkap peraturan perundang-undangan terkait narkotika dan psikotropika.',
    },
    {
      'title': 'Edukasi Bahaya Narkoba',
      'author': 'Tim Edukasi BNN',
      'category': 'Edukasi',
      'pages': 32,
      'downloadCount': 1780,
      'image': 'https://via.placeholder.com/120x160?text=Edukasi',
      'url': 'https://bnn.go.id/edukasi-bahaya-narkoba',
      'pdfUrl': 'https://bnn.go.id/download/edukasi-bahaya-narkoba.pdf',
      'description':
          'Materi edukasi tentang jenis-jenis narkoba dan dampaknya bagi kesehatan.',
    },
    {
      'title': 'Modul Pembelajaran Rehabilitasi dan Konseling Dasar bagi Pecandu dan Korban Penyalahgunaan Narkotika Pada Layanan Rawat Jalan',
      'author': 'BNN Kota Surabaya',
      'category': 'Pencegahan',
      'pages': 28,
      'downloadCount': 945,
      'image': 'assets/images/Cover_2.jpg',
      'url': 'https://bnn.go.id/modul-konseling-surabaya',
      'pdfUrl': 'https://bnn.go.id/download/modul-konseling-surabaya.pdf',
      'description':
          'Modul Pembelajaran Rehabilitasi dan Konseling Dasar bagi Pecandu dan Korban Penyalahgunaan Narkotika Pada Layanan Rawat Jalan.',
    },
    {
      'title': 'Deteksi Dini Penyalahgunaan Narkoba',
      'author': 'Pusat Penelitian BNN',
      'category': 'Edukasi',
      'pages': 52,
      'downloadCount': 1340,
      'image': 'https://via.placeholder.com/120x160?text=Deteksi+Dini',
      'url': 'https://bnn.go.id/deteksi-dini-narkoba',
      'pdfUrl': 'https://bnn.go.id/download/deteksi-dini-narkoba.pdf',
      'description':
          'Panduan mengenali tanda-tanda awal penyalahgunaan narkoba dan langkah-langkah yang harus diambil.',
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

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // Show error message if URL cannot be launched
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak dapat membuka link'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
      bottomNavigationBar: UnifiedBottomNavigationUser(currentIndex: 3),
    );
  }

  // ...existing code...

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
                color: Colors.white.withValues(alpha: 0.2),
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
              color: Colors.white.withValues(alpha: 0.2),
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
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2563EB) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF2563EB)
                      : Colors.grey[300]!,
                ),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
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
    return GestureDetector(
      onTap: () => _showEbookDetail(ebook),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
        children: [
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(ebook['image']),
                fit: BoxFit.cover,
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
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
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
                      onPressed: () => _launchURL(ebook['url']),
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
    ),
    );
  }

  void _showEbookDetail(Map<String, dynamic> ebook) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(ebook['image']),
                              fit: BoxFit.cover,
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
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                ebook['author'],
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF3B82F6,
                                      ).withValues(alpha: 0.1),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Deskripsi',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ebook['description'],
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _launchURL(ebook['pdfUrl']);
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF2563EB)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Unduh PDF',
                              style: TextStyle(
                                color: Color(0xFF2563EB),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _launchURL(ebook['url']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text(
                              'Baca Online',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
