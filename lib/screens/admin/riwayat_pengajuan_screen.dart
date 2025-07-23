import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'unified_bottom_navigation.dart';

class RiwayatPengajuanScreen extends StatefulWidget {
  const RiwayatPengajuanScreen({super.key});

  @override
  State<RiwayatPengajuanScreen> createState() => _RiwayatPengajuanScreenState();
}

class _RiwayatPengajuanScreenState extends State<RiwayatPengajuanScreen> {
  // Sample data untuk pengajuan sesuai format yang diminta
  final List<PengajuanData> pengajuanList = [
    PengajuanData(
      id: '003',
      status: 'Rawat Inap',
      statusColor: const Color(0xFFFACC15),
      alamat: 'Lidah Kulon, Surabaya',
      jenisKelamin: 'Laki-laki',
      lembagaRehab: 'Yayasan Rumah Kita Surabaya',
      tanggalMasuk: '7 Agustus 2024',
      tanggalSelesai: '18 Agustus 2024',
    ),
    PengajuanData(
      id: '002',
      status: 'Rawat Jalan',
      statusColor: const Color(0xFF60A5FA),
      alamat: 'Sukolilo Baru, Surabaya',
      jenisKelamin: 'Perempuan',
      lembagaRehab: 'Yayasan Orbit Surabaya',
      tanggalMasuk: '10 Juli 2024',
      tanggalSelesai: '25 Juli 2024',
    ),
    PengajuanData(
      id: '001',
      status: 'Selesai',
      statusColor: const Color(0xFF22C55E),
      alamat: 'Gubeng Kertajaya, Surabaya',
      jenisKelamin: 'Laki-laki',
      lembagaRehab: 'Yayasan Plato Surabaya',
      tanggalMasuk: '5 Juni 2024',
      tanggalSelesai: '20 Juni 2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                          _buildContentHeader(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 100),
                              child: _buildPengajuanList(),
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
              child: UnifiedBottomNavigation(currentIndex: 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
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

          // Logo Section
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
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KOTA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'SURABAYA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),

          // Admin Profile - Fixed without police line
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Admin',
                    style: TextStyle(
                      color: Color(0xFF0540B0),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF063CA8),
                      borderRadius: BorderRadius.circular(16),
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

  Widget _buildContentHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.edit_document,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Update Pengajuan Rehab',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPengajuanList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: pengajuanList.length,
      itemBuilder: (context, index) {
        final pengajuan = pengajuanList[index];
        return _buildPengajuanCard(pengajuan);
      },
    );
  }

  Widget _buildPengajuanCard(PengajuanData pengajuan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Pengajuan #${pengajuan.id}',
                    style: const TextStyle(
                      color: Color(0xFF1D4ED8),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: pengajuan.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    pengajuan.status,
                    style: TextStyle(
                      color: pengajuan.statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Detail Pengajuan dengan ikon
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pengajuan.alamat,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.local_hospital, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pengajuan.lembagaRehab,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pengajuan.tanggalMasuk,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showDetailDialog(pengajuan);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Lihat Detail',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _showUpdateStatusDialog(pengajuan);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3B82F6),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      side: const BorderSide(color: Color(0xFF3B82F6)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Update Status',
                      style: TextStyle(
                        fontSize: 12,
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
    );
  }

  void _showDetailDialog(PengajuanData pengajuan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Detail Pengajuan #${pengajuan.id}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1D4ED8),
                ),
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDialogDetailRow('Status', pengajuan.status),
              _buildDialogDetailRow('Alamat', pengajuan.alamat),
              _buildDialogDetailRow('Jenis Kelamin', pengajuan.jenisKelamin),
              _buildDialogDetailRow('Lembaga Rehab', pengajuan.lembagaRehab),
              _buildDialogDetailRow('Tanggal Masuk', pengajuan.tanggalMasuk),
              _buildDialogDetailRow(
                'Tanggal Selesai',
                pengajuan.tanggalSelesai,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF6B7280),
            ),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF063CA8),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  void _showUpdateStatusDialog(PengajuanData pengajuan) {
    String selectedStatus = pengajuan.status;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Update Status #${pengajuan.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1D4ED8),
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildRadioOption(
                'Rawat Inap',
                selectedStatus,
                const Color(0xFFFACC15),
                Icons.hotel,
                (value) => setState(() => selectedStatus = value!),
              ),
              _buildRadioOption(
                'Rawat Jalan',
                selectedStatus,
                const Color(0xFF60A5FA),
                Icons.directions_walk,
                (value) => setState(() => selectedStatus = value!),
              ),
              _buildRadioOption(
                'Selesai',
                selectedStatus,
                const Color(0xFF22C55E),
                Icons.check_circle,
                (value) => setState(() => selectedStatus = value!),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF6B7280),
              ),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateStatus(pengajuan, selectedStatus);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Status pengajuan #${pengajuan.id} berhasil diupdate ke: $selectedStatus',
                    ),
                    backgroundColor: const Color(0xFF22C55E),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(
    String title,
    String selectedValue,
    Color color,
    IconData icon,
    Function(String?) onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: selectedValue == title ? color : Colors.grey.shade300,
          width: selectedValue == title ? 2 : 1,
        ),
      ),
      child: RadioListTile<String>(
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: selectedValue == title
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: selectedValue == title ? color : Colors.black87,
              ),
            ),
          ],
        ),
        value: title,
        groupValue: selectedValue,
        onChanged: onChanged,
        activeColor: color,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  void _updateStatus(PengajuanData pengajuan, String newStatus) {
    setState(() {
      pengajuan.status = newStatus;
      // Update warna berdasarkan status
      switch (newStatus) {
        case 'Rawat Inap':
          pengajuan.statusColor = const Color(0xFFFACC15);
          break;
        case 'Rawat Jalan':
          pengajuan.statusColor = const Color(0xFF60A5FA);
          break;
        case 'Selesai':
          pengajuan.statusColor = const Color(0xFF22C55E);
          break;
      }
    });
  }
}

class PengajuanData {
  String id;
  String status;
  Color statusColor;
  String alamat;
  String jenisKelamin;
  String lembagaRehab;
  String tanggalMasuk;
  String tanggalSelesai;

  PengajuanData({
    required this.id,
    required this.status,
    required this.statusColor,
    required this.alamat,
    required this.jenisKelamin,
    required this.lembagaRehab,
    required this.tanggalMasuk,
    required this.tanggalSelesai,
  });
}
