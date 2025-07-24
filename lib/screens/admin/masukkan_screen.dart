import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'profile_screen.dart';
import '../../services/masukkan_service.dart';
import '../../models/masukkan_model.dart';
import '../shared/detail_percakapan_screen.dart';

class MasukkanScreen extends StatefulWidget {
  const MasukkanScreen({super.key});

  @override
  State<MasukkanScreen> createState() => _MasukkanScreenState();
}

class _MasukkanScreenState extends State<MasukkanScreen> {
  final MasukkanService _masukkanService = MasukkanService();

  @override
  Widget build(BuildContext context) {
    final daftarMasukkan = _masukkanService.daftarMasukkan;
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

                      // Feedback cards from service
                      ...daftarMasukkan.map((masukkan) => MasukanCard(
                        masukkanModel: masukkan,
                        onUpdate: () {
                          setState(() {}); // Refresh UI when chat is updated
                        },
                      )),

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
  final MasukkanModel masukkanModel;
  final VoidCallback onUpdate;

  const MasukanCard({
    super.key,
    required this.masukkanModel,
    required this.onUpdate,
  });

  @override
  State<MasukanCard> createState() => _MasukanCardState();
}

class _MasukanCardState extends State<MasukanCard> {
  bool showPercakapan = false;
  final MasukkanService _masukkanService = MasukkanService();

  String _formatDate(DateTime date) {
    final months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

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
                    Text(widget.masukkanModel.nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(widget.masukkanModel.email, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              Row(
                children: [
                  // Indikator pesan baru dari user
                  if (widget.masukkanModel.percakapan.isNotEmpty && 
                      widget.masukkanModel.percakapan.last.pengirim == 'user')
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _masukkanService.getStatusDinamis(widget.masukkanModel) == 'Menunggu Balasan' ||
                             _masukkanService.getStatusDinamis(widget.masukkanModel) == 'Menunggu Balasan Admin'
                          ? Colors.orange.withOpacity(0.2) 
                          : Colors.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _masukkanService.getStatusDinamis(widget.masukkanModel),
                      style: TextStyle(
                        fontSize: 12,
                        color: _masukkanService.getStatusDinamis(widget.masukkanModel) == 'Menunggu Balasan' ||
                               _masukkanService.getStatusDinamis(widget.masukkanModel) == 'Menunggu Balasan Admin'
                            ? Colors.orange 
                            : Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
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
              'Judul: ${widget.masukkanModel.judul}',
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
                TextSpan(text: widget.masukkanModel.isi),
              ],
            ),
          ),
          
          // Tampilkan percakapan jika ada dan showPercakapan true
          if (widget.masukkanModel.percakapan.isNotEmpty && showPercakapan) ...[
            const SizedBox(height: 12),
            ...widget.masukkanModel.percakapan.map((message) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.pengirim == 'admin' 
                    ? const Color(0xFF0062F3).withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: message.pengirim == 'admin' 
                      ? const Color(0xFF0062F3).withOpacity(0.3)
                      : Colors.grey.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: message.pengirim == 'admin' 
                            ? const Color(0xFF0062F3)
                            : Colors.grey,
                        radius: 16,
                        child: Icon(
                          message.pengirim == 'admin' ? Icons.support_agent : Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        message.namaPengirim,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: message.pengirim == 'admin' 
                              ? const Color(0xFF0062F3)
                              : Colors.grey[700],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(message.waktu),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message.pesan,
                    style: const TextStyle(
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
          
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(widget.masukkanModel.tanggal),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (widget.masukkanModel.percakapan.isNotEmpty) {
                    setState(() {
                      showPercakapan = !showPercakapan;
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPercakapanScreen(
                          masukkan: widget.masukkanModel,
                          isAdmin: true,
                          currentUserName: 'Admin BNN',
                        ),
                      ),
                    ).then((_) => widget.onUpdate());
                  }
                },
                child: Text(
                  widget.masukkanModel.percakapan.isNotEmpty 
                      ? (showPercakapan ? '< Sembunyikan >' : '< Lihat Percakapan >') 
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