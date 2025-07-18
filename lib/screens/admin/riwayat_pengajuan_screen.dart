import 'package:flutter/material.dart';

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
      alamat: 'Lidah',
      jenisKelamin: 'Laki-laki',
      lembagaRehab: 'Rumah Sakit Jiwa Menur',
      tanggalMasuk: '7 Agustus 2024',
      tanggalSelesai: '18 Agustus 2024',
    ),
    PengajuanData(
      id: '002',
      status: 'Rawat Jalan',
      statusColor: const Color(0xFF60A5FA),
      alamat: 'Sukolilo',
      jenisKelamin: 'Perempuan',
      lembagaRehab: 'Puskesmas Sukolilo',
      tanggalMasuk: '10 Juli 2024',
      tanggalSelesai: '25 Juli 2024',
    ),
    PengajuanData(
      id: '001',
      status: 'Selesai',
      statusColor: const Color(0xFF22C55E),
      alamat: 'Gubeng',
      jenisKelamin: 'Laki-laki',
      lembagaRehab: 'Rumah Sakit Umum Daerah',
      tanggalMasuk: '5 Juni 2024',
      tanggalSelesai: '20 Juni 2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
          ),
        ),
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Main Content
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Color(0xFFEFEFEF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    // Content Header
                    _buildContentHeader(),
                    
                    // List Pengajuan
                    Expanded(
                      child: _buildPengajuanList(),
                    ),
                  ],
                ),
              ),
            ),
            
            // Bottom Navigation
            _buildBottomNavigation(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button dan Logo
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.location_city,
                  color: Color(0xFF063CA8),
                  size: 30,
                ),
              ),
              const SizedBox(width: 15),
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
            ],
          ),
          
          // Admin Profile
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
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
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xFF063CA8),
                    borderRadius: BorderRadius.circular(100),
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
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFEBEBEB),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.history,
              color: Color(0xFF063CA8),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Riwayat Pengajuan Rehab',
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
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => _showDetailDialog(pengajuan),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border(
              left: BorderSide(
                color: pengajuan.statusColor,
                width: 4,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pengajuan #${pengajuan.id}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: pengajuan.statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
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
              
              // Detail Pengajuan (hanya tampilkan beberapa field utama)
              _buildDetailRow('Alamat', pengajuan.alamat),
              _buildDetailRow('Lembaga Rehab', pengajuan.lembagaRehab),
              _buildDetailRow('Tanggal Masuk', pengajuan.tanggalMasuk),
              
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
                        backgroundColor: const Color(0xFF063CA8),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Detail'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _showUpdateStatusDialog(pengajuan);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF063CA8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Color(0xFF063CA8)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Update Status'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 65,
      color: const Color(0xFF063CA8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem('Beranda', Icons.home, false, () {
            Navigator.pop(context);
          }),
          _buildNavItem('Persebaran', Icons.map, false, () {
            // TODO: Navigate to Persebaran
          }),
          _buildNavItem('Pengajuan', Icons.assignment, false, () {
            // TODO: Navigate to Pengajuan
          }),
          _buildNavItem('Riwayat', Icons.history, true, () {
            // Current page
          }),
          _buildNavItem('Akun', Icons.person, false, () {
            // TODO: Navigate to Akun
          }),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.white : Colors.white70,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailDialog(PengajuanData pengajuan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail Pengajuan #${pengajuan.id}'),
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
              _buildDialogDetailRow('Tanggal Selesai', pengajuan.tanggalSelesai),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
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
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
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
          title: Text('Update Status Pengajuan #${pengajuan.id}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Rawat Inap'),
                value: 'Rawat Inap',
                groupValue: selectedStatus,
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
                activeColor: const Color(0xFF063CA8),
              ),
              RadioListTile<String>(
                title: const Text('Rawat Jalan'),
                value: 'Rawat Jalan',
                groupValue: selectedStatus,
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
                activeColor: const Color(0xFF063CA8),
              ),
              RadioListTile<String>(
                title: const Text('Selesai'),
                value: 'Selesai',
                groupValue: selectedStatus,
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value!;
                  });
                },
                activeColor: const Color(0xFF063CA8),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateStatus(pengajuan, selectedStatus);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Status pengajuan #${pengajuan.id} berhasil diupdate ke: $selectedStatus'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF063CA8),
              ),
              child: const Text('Update'),
            ),
          ],
        ),
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