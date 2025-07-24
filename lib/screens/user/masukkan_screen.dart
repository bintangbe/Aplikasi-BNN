import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'persebaran_screen.dart';
import 'unified_bottom_navigation_user.dart';
import 'ebook_screen.dart';
import 'akun_screen.dart';
import 'beranda_user.dart';
import '../../models/masukkan_model.dart';
import '../../services/masukkan_service.dart';
import '../shared/detail_percakapan_screen.dart';

class MasukkanScreen extends StatefulWidget {
  const MasukkanScreen({super.key});

  @override
  State<MasukkanScreen> createState() => _MasukkanScreenState();
}

class _MasukkanScreenState extends State<MasukkanScreen> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _pesanController = TextEditingController();
  final MasukkanService _masukkanService = MasukkanService();

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
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          labelColor: Color(0xFF063CA8),
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Color(0xFF063CA8),
                          tabs: [
                            Tab(text: 'Buat Masukkan'),
                            Tab(text: 'Riwayat Masukkan'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              SingleChildScrollView(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Masukkan',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    _buildSimpleForm(),
                                  ],
                                ),
                              ),
                              _buildRiwayatMasukkan(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: UnifiedBottomNavigationUser(currentIndex: 2),
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
    bool isSelected = index == 2; // Masukkan is selected
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
            // Already on Masukkan, do nothing
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const EbookScreen()),
            );
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

  Widget _buildSimpleForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input Judul
        TextField(
          controller: _judulController,
          decoration: InputDecoration(
            labelText: 'Judul Masukkan',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: const TextStyle(
              color: Color(0xFF063CA8),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            hintText: 'Judul Masukkan',
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 3, color: Color(0xFF063CA8)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 18,
            ),
          ),
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        // Input Isi Masukkan
        TextField(
          controller: _pesanController,
          maxLines: 8,
          decoration: InputDecoration(
            labelText: 'Isi Masukkan',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: const TextStyle(
              color: Color(0xFF063CA8),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            hintText: 'Tulis isi masukkan...',
            hintStyle: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 3, color: Color(0xFF063CA8)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 17,
              vertical: 18,
            ),
          ),
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32),
        // Tombol Kirim
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: _kirimMasukkan,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Kirim',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _kirimMasukkan() {
    if (_judulController.text.isEmpty || _pesanController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon lengkapi judul dan isi masukkan'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    // Buat masukkan baru menggunakan service
    final masukkanBaru = MasukkanModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nama: 'User', // Nama default untuk sekarang
      email: 'user@example.com', // Email default untuk sekarang
      judul: _judulController.text,
      isi: _pesanController.text,
      tanggal: DateTime.now(),
      status: 'Menunggu Balasan',
      percakapan: [],
    );
    
    _masukkanService.tambahMasukkan(masukkanBaru);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Masukkan berhasil dikirim!'),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 3),
      ),
    );

    // Clear form dan refresh state
    _judulController.clear();
    _pesanController.clear();
    setState(() {});
  }

  Widget _buildRiwayatMasukkan() {
    final daftarMasukkan = _masukkanService.daftarMasukkan;
    
    return daftarMasukkan.isEmpty
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.forum_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'Belum ada masukkan',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Kirim masukkan pertama Anda!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: daftarMasukkan.length,
            itemBuilder: (context, index) {
              final masukkan = daftarMasukkan[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    masukkan.judul,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        masukkan.isi,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTanggal(masukkan.tanggal),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _masukkanService.getStatusDinamis(masukkan) == 'Menunggu Balasan' ||
                                     _masukkanService.getStatusDinamis(masukkan) == 'Menunggu Balasan Admin'
                                  ? Colors.orange[100]
                                  : Colors.green[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _masukkanService.getStatusDinamis(masukkan),
                              style: TextStyle(
                                fontSize: 12,
                                color: _masukkanService.getStatusDinamis(masukkan) == 'Menunggu Balasan' ||
                                       _masukkanService.getStatusDinamis(masukkan) == 'Menunggu Balasan Admin'
                                    ? Colors.orange[800]
                                    : Colors.green[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Indikator pesan baru
                      if (masukkan.percakapan.isNotEmpty && 
                          masukkan.percakapan.last.pengirim == 'admin')
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPercakapanScreen(
                          masukkan: masukkan,
                          isAdmin: false,
                          currentUserName: 'User',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }

  String _formatTanggal(DateTime tanggal) {
    final now = DateTime.now();
    final difference = now.difference(tanggal);
    
    if (difference.inDays == 0) {
      return 'Hari ini';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return '${tanggal.day}/${tanggal.month}/${tanggal.year}';
    }
  }

  @override
  void dispose() {
    _judulController.dispose();
    _pesanController.dispose();
    super.dispose();
  }
}
