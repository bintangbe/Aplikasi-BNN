import 'package:flutter/material.dart';
import 'unified_bottom_navigation.dart';
import 'profile_screen.dart';
import 'edit_lembaga_screen.dart';

class DetailLembagaScreen extends StatefulWidget {
  final Map<String, dynamic> lembagaData;

  const DetailLembagaScreen({super.key, required this.lembagaData});

  @override
  State<DetailLembagaScreen> createState() => _DetailLembagaScreenState();
}

class _DetailLembagaScreenState extends State<DetailLembagaScreen> {
  late Map<String, dynamic> currentLembagaData;

  @override
  void initState() {
    super.initState();
    currentLembagaData = Map<String, dynamic>.from(widget.lembagaData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            _buildHeader(context),

            // Main Content
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
                    // Scrollable Content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Content Header with Back Button
                            _buildContentHeader(context),

                            // Lembaga Info Card
                            _buildLembagaInfoCard(),

                            // Detail Kapasitas
                            _buildDetailKapasitasCard(),

                            // Extra space at bottom
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Navigation
                    UnifiedBottomNavigation(
                      currentIndex: -1, // No active item for detail page
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

  Widget _buildHeader(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            // Logo BNN
            Container(
              width: 86,
              height: 86,
              child: Image.asset(
                'assets/images/logo_bnn.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Text(
                        'BNN',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF063CA8),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),

            // Kota Surabaya
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  'KOTA\nSURABAYA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                    height: 1.2,
                  ),
                ),
              ),
            ),

            // Admin Profile
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              child: Container(
                width: 140,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        'Admin',
                        style: TextStyle(
                          color: Color(0xFF0540B0),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24,
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

  Widget _buildContentHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF063CA8),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Title
          const Expanded(
            child: Text(
              'Detail Lembaga Rehabilitasi',
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ),

          // Edit Button
          GestureDetector(
            onTap: () => _navigateToEdit(context),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLembagaInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lembaga Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Yayasan Image
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    currentLembagaData['image'] ??
                        'assets/images/placeholder.jpeg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback icon if image fails to load
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF063CA8).withOpacity(0.1),
                              const Color(0xFF00AEEF).withOpacity(0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.home_work,
                          color: Color(0xFF063CA8),
                          size: 36,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Lembaga Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentLembagaData['name'] ?? 'Nama Lembaga',
                      style: const TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 16,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Color(0xFF666666),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            currentLembagaData['alamatLengkap'] ??
                                'Alamat tidak tersedia',
                            style: const TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 12,
                              fontFamily: 'Mulish',
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone_outlined,
                          size: 16,
                          color: Color(0xFF666666),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          currentLembagaData['nomorTelepon'] ??
                              'Tidak tersedia',
                          style: const TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 12,
                            fontFamily: 'Mulish',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_outlined,
                          size: 16,
                          color: Color(0xFF666666),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            currentLembagaData['jamOperasional'] ??
                                'Jam operasional tidak tersedia',
                            style: const TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 12,
                              fontFamily: 'Mulish',
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

          const SizedBox(height: 20),

          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  const Color(0xFFDFDFDF),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Kapasitas Info with improved styling
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF063CA8).withOpacity(0.05),
                  const Color(0xFF00AEEF).withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kapasitas Total: ${_getKapasitasTotal()}',
                  style: const TextStyle(
                    color: Color(0xFF063CA8),
                    fontSize: 12,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Sisa: ${_getSisaKapasitas()}',
                  style: const TextStyle(
                    color: Color(0xFF00AEEF),
                    fontSize: 12,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailKapasitasCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Detail Kapasitas Rehab',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 16,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Keterangan
          const Text(
            'Keterangan Kapasitas:',
            style: TextStyle(
              color: Color(0xFF666666),
              fontSize: 14,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 16),

          // Kapasitas Details with better styling
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE9ECEF), width: 1),
            ),
            child: Column(
              children: [
                _buildKapasitasRow(
                  'Rawat Inap Laki-laki',
                  '${currentLembagaData['rawatInapLaki'] ?? 3} / ${currentLembagaData['kapasitasLaki'] ?? 17}',
                  true,
                ),
                const SizedBox(height: 12),
                _buildKapasitasRow(
                  'Rawat Inap Perempuan',
                  '${currentLembagaData['rawatInapPerempuan'] ?? 1} / ${currentLembagaData['kapasitasPerempuan'] ?? 5}',
                  true,
                ),
                const SizedBox(height: 12),
                _buildKapasitasRow(
                  'Rawat Jalan',
                  '${currentLembagaData['rawatJalan'] ?? 2}',
                  false,
                ),
                const SizedBox(height: 12),
                _buildKapasitasRow(
                  'Pasca Rehab',
                  '${currentLembagaData['pascaRehab'] ?? 2}',
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKapasitasRow(
    String label,
    String value, [
    bool hasCapacity = false,
  ]) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE9ECEF), width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 13,
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: hasCapacity
                  ? const Color(0xFF063CA8).withOpacity(0.1)
                  : const Color(0xFF00AEEF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: hasCapacity
                    ? const Color(0xFF063CA8)
                    : const Color(0xFF00AEEF),
                fontSize: 13,
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods untuk data
  String _getKapasitasTotal() {
    int kapasitasLaki = currentLembagaData['kapasitasLaki'] ?? 17;
    int kapasitasPerempuan = currentLembagaData['kapasitasPerempuan'] ?? 5;
    return (kapasitasLaki + kapasitasPerempuan).toString();
  }

  String _getSisaKapasitas() {
    int kapasitasLaki = currentLembagaData['kapasitasLaki'] ?? 17;
    int kapasitasPerempuan = currentLembagaData['kapasitasPerempuan'] ?? 5;
    int terisiLaki = currentLembagaData['rawatInapLaki'] ?? 3;
    int terisiPerempuan = currentLembagaData['rawatInapPerempuan'] ?? 1;

    int totalKapasitas = kapasitasLaki + kapasitasPerempuan;
    int totalTerisi = terisiLaki + terisiPerempuan;

    return (totalKapasitas - totalTerisi).toString();
  }

  void _navigateToEdit(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditLembagaScreen(lembagaData: currentLembagaData),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        currentLembagaData = result;
      });
    }
  }
}
