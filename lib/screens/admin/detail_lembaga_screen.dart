import 'package:flutter/material.dart';

class DetailLembagaScreen extends StatelessWidget {
  final Map<String, String> lembagaData;
  
  const DetailLembagaScreen({
    super.key,
    required this.lembagaData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF063CA8),
              Color(0xFF00AEEF),
            ],
          ),
        ),
        child: Column(
          children: [
            // Status Bar
            SafeArea(
              bottom: false,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '20.11',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Icon(Icons.signal_cellular_4_bar, size: 16),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD9D9D9),
                          ),
                          child: const Icon(Icons.battery_full, size: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Header
            _buildHeader(),
            
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
                    // Content Header with Back Button
                    _buildContentHeader(context),
                    
                    // Lembaga Info Card
                    _buildLembagaInfoCard(),
                    
                    // Detail Kapasitas
                    _buildDetailKapasitasCard(),
                    
                    // Spacer
                    const Spacer(),
                    
                    // Bottom Navigation
                    _buildBottomNavigation(context),
                  ],
                ),
              ),
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
          // Logo BNN
          Container(
            width: 86,
            height: 86,
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
          ),
          const SizedBox(width: 16),
          
          // Kota Surabaya
          const Expanded(
            child: Text(
              'KOTA\nSURABAYA',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          
          // Admin Profile
          Container(
            width: 132,
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12),
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
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
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
        ],
      ),
    );
  }

  Widget _buildContentHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFEBEBEB),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios,
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
                color: Colors.black,
                fontSize: 23.44,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.37,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLembagaInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0x19181320),
            blurRadius: 35.32,
            offset: const Offset(0, 35.32),
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
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF063CA8).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.home_work,
                  color: Color(0xFF063CA8),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              
              // Lembaga Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lembagaData['name'] ?? 'Yayasan Rumah Kita',
                      style: const TextStyle(
                        color: Color(0xFF211A2C),
                        fontSize: 14,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lembagaData['alamatLengkap'] ?? 'Jl. Ngagel Madya II / 9 Surabaya',
                      style: const TextStyle(
                        color: Color(0xFF28293F),
                        fontSize: 10,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lembagaData['nomorTelepon'] ?? '088102367299',
                      style: const TextStyle(
                        color: Color(0xFF28293F),
                        fontSize: 10,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Divider
          Container(
            height: 1,
            color: const Color(0xFFDFDFDF),
          ),
          
          const SizedBox(height: 16),
          
          // Kapasitas Info
          Text(
            'Kapasitas : ${_getKapasitasTotal()}     | Sisa : ${_getSisaKapasitas()}',
            style: const TextStyle(
              color: Color(0xFF28293F),
              fontSize: 10,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailKapasitasCard() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Center(
            child: Text(
              'Detail Kapasitas Rehab',
              style: TextStyle(
                color: Color(0xFF211A2C),
                fontSize: 14,
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Keterangan
          const Text(
            'Keterangan :',
            style: TextStyle(
              color: Color(0xFF211A2C),
              fontSize: 12,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w700,
            ),
          ),
          
          const SizedBox(height: 15),
          
          // Kapasitas Details
          Column(
            children: [
              _buildKapasitasRow('Rawat Inap Laki-laki', '3 / 17'),
              const SizedBox(height: 8),
              _buildKapasitasRow('Rawat Inap Perempuan', '1 / 5'),
              const SizedBox(height: 8),
              _buildKapasitasRow('Rawat Jalan', '2'),
              const SizedBox(height: 8),
              _buildKapasitasRow('Pasca Rehab', '2'),
              const SizedBox(height: 8),
              _buildKapasitasRow('SKSR', '2'),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Divider
          Container(
            height: 1,
            color: const Color(0xFFDFDFDF),
          ),
        ],
      ),
    );
  }

  Widget _buildKapasitasRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF211A2C),
            fontSize: 12,
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF211A2C),
            fontSize: 12,
            fontFamily: 'Mulish',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      decoration: const BoxDecoration(
        color: Color(0xFF063CA8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('Beranda', Icons.home, false, () {
            Navigator.popUntil(context, (route) => route.isFirst);
          }),
          _buildNavItem('Pesebaran', Icons.map, false, () {
            // TODO: Navigate to Pesebaran
          }),
          _buildNavItem('Pengajuan', Icons.assignment, false, () {
            // TODO: Navigate to Pengajuan
          }),
          _buildNavItem('Riwayat', Icons.history, false, () {
            // TODO: Navigate to Riwayat
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
      child: Container(
        width: 65,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: const Color(0xFF062766),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : const Color(0xFFEBEDF0),
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFFEBEDF0),
                fontSize: 12,
                fontFamily: 'Segoe UI Symbol',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods untuk data
  String _getKapasitasTotal() {
    return '22'; // 17 + 5 dari rawat inap
  }

  String _getSisaKapasitas() {
    return '18'; // 22 - 4 (3+1 yang terisi)
  }
}