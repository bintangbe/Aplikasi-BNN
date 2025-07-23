import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'balas_screen.dart';
import 'profile_screen.dart';
import 'unified_bottom_navigation.dart';

class MasukkanScreen extends StatelessWidget {
  const MasukkanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Logo and City Name
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse('https://surabayakota.bnn.go.id');
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/images/logo_bnn.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'KOTA\nSURABAYA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Main content container
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button & title
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileScreen(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black12,
                                child: Icon(Icons.arrow_back, size: 16, color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Masukkan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Feedback cards
                      MasukanCard(
                        nama: 'Diana Cantika',
                        email: 'dianacanci123@gmail.com',
                        judul: 'Kurangnya Privasi Saat Konsultasi di Tempat Rehabilitasi',
                        isi: 'Halo BNN, saya mau sampaikan sedikit unek-unek waktu dampingi teman saya konsultasi ke salah satu tempat rehabilitasi. '
                            'Pas sesi konsultasi berlangsung, ruangannya ternyata terbuka dan ada beberapa orang lain yang bisa dengar pembicaraan. '
                            'Padahal menurut saya, untuk hal sensitif kayak gini, privasi itu penting banget.',
                        tanggal: '20 Juli 2025',
                        status: 'Belum Dibalas',
                        balasan: null,
                      ),

                      MasukanCard(
                        nama: 'Budi Santoso',
                        email: 'budisantoso@gmail.com',
                        judul: 'Saran Untuk Program Pencegahan di Sekolah',
                        isi: 'Selamat siang BNN, saya ingin memberikan saran terkait program pencegahan narkoba di sekolah. '
                            'Mungkin bisa ditambahkan sesi interaktif atau games yang lebih menarik agar siswa lebih antusias dalam mengikuti program.',
                        tanggal: '19 Juli 2025',
                        status: 'Sudah Dibalas',
                        balasan: 'Terima kasih atas saran yang sangat berharga, Bapak Budi. Kami sangat mengapresiasi masukan Anda terkait program pencegahan narkoba di sekolah. '
                            'Saran Anda untuk menambahkan sesi interaktif dan games edukatif akan kami sampaikan kepada tim yang bertanggung jawab untuk pengembangan program. '
                            'Kami terus berupaya meningkatkan metode penyampaian agar lebih menarik dan efektif bagi para siswa.',
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Footer Navigasi
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65,
              decoration: const BoxDecoration(
                color: Color(0xFF063CA8),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  FooterItem(icon: Icons.home, label: 'Beranda'),
                  FooterItem(icon: Icons.location_on, label: 'Pesebaran'),
                  FooterItem(icon: Icons.add, label: 'Pengajuan'),
                  FooterItem(icon: Icons.history, label: 'Riwayat'),
                  FooterItem(icon: Icons.person, label: 'Akun', isActive: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MasukanCard extends StatefulWidget {
  final String nama;
  final String email;
  final String judul;
  final String isi;
  final String tanggal;
  final String status;
  final String? balasan;

  const MasukanCard({
    super.key,
    required this.nama,
    required this.email,
    required this.judul,
    required this.isi,
    required this.tanggal,
    required this.status,
    this.balasan,
  });

  @override
  State<MasukanCard> createState() => _MasukanCardState();
}

class _MasukanCardState extends State<MasukanCard> {
  bool showBalasan = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xFFE7E0EC),
                radius: 22,
                child: Icon(Icons.person, color: Colors.black),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.email, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.status == 'Sudah Dibalas' 
                      ? Colors.green.withOpacity(0.2) 
                      : Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.status,
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.status == 'Sudah Dibalas' ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF0062F3)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Judul: ${widget.judul}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Isi Masukan: ',
                  style: TextStyle(
                    color: Color(0xFF0062F3),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: widget.isi),
              ],
            ),
          ),
          
          // Tampilkan balasan jika ada dan showBalasan true
          if (widget.balasan != null && showBalasan) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0062F3).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xFF0062F3).withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFF0062F3),
                        radius: 16,
                        child: Icon(
                          Icons.support_agent,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Admin BNN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0062F3),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.balasan!,
                    style: const TextStyle(
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
          
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.tanggal,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (widget.status == 'Sudah Dibalas' && widget.balasan != null) {
                    setState(() {
                      showBalasan = !showBalasan;
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BalasScreen(
                          nama: widget.nama,
                          email: widget.email,
                          judul: widget.judul,
                          isi: widget.isi,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  widget.status == 'Sudah Dibalas' 
                      ? (showBalasan ? '< Sembunyikan >' : '< Lihat Balasan >') 
                      : '< Balas >',
                  style: const TextStyle(
                    color: Color(0xFF0062F3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FooterItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const FooterItem({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? Colors.white : Colors.white70),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}