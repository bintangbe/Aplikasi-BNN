import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'unified_bottom_navigation.dart';
import 'profile_screen.dart';

class AdminAjukanRehabScreen extends StatefulWidget {
  const AdminAjukanRehabScreen({super.key});

  @override
  State<AdminAjukanRehabScreen> createState() => _AdminAjukanRehabScreenState();
}

class _AdminAjukanRehabScreenState extends State<AdminAjukanRehabScreen> {
  final _namaController = TextEditingController();
  final _nomorIdentitasController = TextEditingController();
  final _alamatController = TextEditingController();
  String? _selectedLembaga;
  String? _selectedKecamatan;
  bool _isLoading = false;

  final List<String> _lembagaOptions = [
    'Yayasan Rumah Kita Surabaya',
    'Yayasan Orbit Surabaya',
    'Yayasan Plato Surabaya',
    'Yayasan LRPPN-Surabaya',
    'Yayasan Rumah Merah Putih Surabaya',
    'RS Menur Surabaya',
    'Omah Sehat Bersinar',
  ];

  final List<String> _kecamatanOptions = [
    'Asemrowo',
    'Benowo',
    'Bubutan',
    'Bulak',
    'Dukuh Pakis',
    'Gayungan',
    'Genteng',
    'Gubeng',
    'Gunung Anyar',
    'Jambangan',
    'Karang Pilang',
    'Kenjeran',
    'Krembangan',
    'Lakarsantri',
    'Mulyorejo',
    'Pabean Cantian',
    'Pakal',
    'Rungkut',
    'Sambikerep',
    'Sawahan',
    'Semampir',
    'Simokerto',
    'Sukolilo',
    'Sukomanunggal',
    'Tambaksari',
    'Tandes',
    'Tegalsari',
    'Tenggilis Mejoyo',
    'Wiyung',
    'Wonocolo',
    'Wonokromo',
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF063CA8), // Exact from Figma
                Color(0xFF00AEEF), // Exact from Figma
              ],
            ),
          ),
          child: Column(
            children: [
              // Header Section
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
                      // Form Content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            left: 24,
                            right: 24,
                            top: 24,
                            bottom: 100, // Space for bottom navigation
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              const Text(
                                'Formulir Pengajuan Rehab',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 1.34,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Form Fields
                              _buildTextField(
                                label: 'Nama Lengkap',
                                controller: _namaController,
                                hintText: 'Masukkan nama lengkap',
                              ),

                              const SizedBox(height: 16),

                              _buildTextField(
                                label: 'Nomor Identitas',
                                controller: _nomorIdentitasController,
                                hintText: 'Masukkan nomor KTP/NIK',
                                keyboardType: TextInputType.number,
                              ),

                              const SizedBox(height: 16),

                              // Dropdown Kecamatan
                              _buildKecamatanDropdownField(),

                              const SizedBox(height: 16),

                              _buildTextField(
                                label: 'Alamat Detail',
                                controller: _alamatController,
                                hintText:
                                    'Masukkan alamat detail (jalan, RT/RW, dll)',
                                maxLines: 2,
                              ),

                              const SizedBox(height: 16),

                              // Dropdown Lembaga
                              _buildDropdownField(),

                              const SizedBox(height: 32),

                              // Submit Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _handleSubmit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2563EB),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        )
                                      : const Text(
                                          'Kirim Pengajuan',
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
                          ),
                        ),
                      ),

                      // Bottom Navigation
                      UnifiedBottomNavigation(
                        currentIndex: 2, // Pengajuan
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 1.57,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0x3F000000),
                blurRadius: 4,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFE5E7EB),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xFFE5E7EB),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xFF2563EB),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lembaga Tujuan',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color(0x19000000),
                blurRadius: 14,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedLembaga,
            decoration: InputDecoration(
              hintText: 'Pilih lembaga',
              hintStyle: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: _lembagaOptions.map((String lembaga) {
              return DropdownMenuItem<String>(
                value: lembaga,
                child: Text(
                  lembaga,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedLembaga = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildKecamatanDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kecamatan',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: const Color(0x19000000),
                blurRadius: 14,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedKecamatan,
            decoration: InputDecoration(
              hintText: 'Pilih kecamatan di Surabaya',
              hintStyle: const TextStyle(
                color: Color(0xFF333333),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: _kecamatanOptions.map((String kecamatan) {
              return DropdownMenuItem<String>(
                value: kecamatan,
                child: Text(
                  kecamatan,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 15,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedKecamatan = newValue;
              });
            },
          ),
        ),
      ],
    );
  }

  void _handleSubmit() async {
    // Validation
    if (_namaController.text.isEmpty) {
      _showErrorSnackBar('Nama lengkap tidak boleh kosong');
      return;
    }

    if (_nomorIdentitasController.text.isEmpty) {
      _showErrorSnackBar('Nomor identitas tidak boleh kosong');
      return;
    }

    if (_selectedKecamatan == null) {
      _showErrorSnackBar('Silakan pilih kecamatan');
      return;
    }

    if (_alamatController.text.isEmpty) {
      _showErrorSnackBar('Alamat detail tidak boleh kosong');
      return;
    }

    if (_selectedLembaga == null) {
      _showErrorSnackBar('Silakan pilih lembaga tujuan');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Show success dialog
    _showSuccessDialog();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 16),
              const Text(
                'Pengajuan Berhasil!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pengajuan rehabilitasi untuk ${_namaController.text} telah berhasil dikirim ke $_selectedLembaga.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                    Navigator.of(context).pop(); // Back to dashboard
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Kembali ke Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nomorIdentitasController.dispose();
    _alamatController.dispose();
    super.dispose();
  }
}
