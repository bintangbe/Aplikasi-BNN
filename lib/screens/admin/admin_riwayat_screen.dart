import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'unified_bottom_navigation.dart';
import 'profile_screen.dart';
import '../../widgets/responsive_wrapper.dart';
import '../../services/rehabilitasi_service.dart';
import '../../models/rehabilitasi_model.dart';
import 'tambah_rehabilitasi_screen.dart';

class AdminRiwayatScreen extends StatefulWidget {
  const AdminRiwayatScreen({super.key});

  @override
  State<AdminRiwayatScreen> createState() => _AdminRiwayatScreenState();
}

class _AdminRiwayatScreenState extends State<AdminRiwayatScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<RehabilitasiModel> _riwayatData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final data = await RehabilitasiService.getAllRehabilitasi();
      setState(() {
        _riwayatData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error memuat data: $e')),
        );
      }
    }
  }

  List<RehabilitasiModel> get _filteredData {
    if (_searchQuery.isEmpty) return _riwayatData;
    return _riwayatData.where((data) {
      return data.nama.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          data.nik.contains(_searchQuery) ||
          data.alamat.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: ResponsiveWrapper(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
              ),
            ),
            child: Column(
              children: [
                _buildHeader(context),
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
                          child: _isLoading 
                            ? const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF063CA8)),
                                ),
                              )
                            : _filteredData.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 64,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        _searchQuery.isEmpty 
                                          ? 'Belum ada data rehabilitasi'
                                          : 'Tidak ada data yang sesuai dengan pencarian',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SingleChildScrollView(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                                  child: Column(
                                    children: _filteredData
                                        .map((data) => _buildRiwayatItem(data))
                                        .toList(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: UnifiedBottomNavigation(currentIndex: 3),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF063CA8),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TambahRehabilitasiScreen(),
              ),
            );
            if (result == true) {
              await _loadData(); // Refresh data after adding new item
            }
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
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
      ),
    );
  }

  Widget _buildContentHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Riwayat Rehabilitasi',
            style: TextStyle(
              color: Color(0xFF1A1A1A),
              fontSize: 22,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 16),

          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari berdasarkan nama, NIK, atau alamat...',
                hintStyle: const TextStyle(
                  color: Color(0xFFA2A2A2),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFF063CA8),
                  size: 20,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Color(0xFF666666),
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiwayatItem(RehabilitasiModel data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Name and Status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF063CA8).withOpacity(0.1),
                      const Color(0xFF00AEEF).withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.person,
                  color: Color(0xFF063CA8),
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // Name and NIK
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.nama,
                      style: const TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'NIK: ${data.nik}',
                      style: const TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(
                    data.statusProgress,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data.statusProgress,
                  style: TextStyle(
                    color: _getStatusColor(data.statusProgress),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFFE0E0E0),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Details
          _buildDetailRow(
            'Status Rehab',
            data.status,
            Icons.medical_services,
          ),
          _buildDetailRow('Alamat', data.alamat, Icons.location_on),
          _buildDetailRow(
            'Jenis Kelamin',
            data.jenisKelamin,
            Icons.person_outline,
          ),
          _buildDetailRow(
            'Lembaga Rehab',
            data.lembagaRehab,
            Icons.business,
          ),
          _buildDetailRow(
            'Tanggal Masuk',
            data.tanggalMasuk,
            Icons.calendar_today,
          ),
          _buildDetailRow(
            'Tanggal Selesai',
            data.tanggalSelesai,
            Icons.event_available,
          ),

          const SizedBox(height: 16),

          // Update Status Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showUpdateStatusDialog(data),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Update Status',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF063CA8).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: const Color(0xFF063CA8)),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF063CA8),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 12,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Selesai':
        return const Color(0xFF22C55E);
      case 'Masa Rehab':
        return const Color(0xFFF59E0B);
      case 'Dalam Proses': // Keep for backward compatibility with existing data
        return const Color(0xFFF59E0B);
      case 'Menunggu': // Keep for backward compatibility with existing data
        return const Color(0xFF6B7280);
      default:
        return const Color(0xFF6B7280);
    }
  }

  void _showUpdateStatusDialog(RehabilitasiModel data) {
    String selectedStatus = data.statusProgress;

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
                  'Update Status',
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
                'Masa Rehab',
                selectedStatus,
                const Color(0xFFF59E0B),
                Icons.medical_services,
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
                _updateStatus(data, selectedStatus);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Status untuk ${data.nama} berhasil diupdate ke: $selectedStatus',
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

  void _updateStatus(RehabilitasiModel data, String newStatus) async {
    try {
      final updatedData = data.copyWith(statusProgress: newStatus);
      await RehabilitasiService.updateRehabilitasi(updatedData);
      await _loadData(); // Reload data to reflect changes
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating status: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
