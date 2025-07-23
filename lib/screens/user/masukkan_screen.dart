import 'package:flutter/material.dart';
import 'persebaran_screen.dart';
import 'ebook_screen.dart';
import 'akun_screen.dart';
import 'beranda_user.dart';

class MasukkanScreen extends StatefulWidget {
  const MasukkanScreen({super.key});

  @override
  State<MasukkanScreen> createState() => _MasukkanScreenState();
}

class _MasukkanScreenState extends State<MasukkanScreen> {
  final _namaController = TextEditingController();
  final _nomorTeleponController = TextEditingController();
  final _alamatController = TextEditingController();
  final _keteranganController = TextEditingController();
  String _selectedKategori = 'Laporan Kejadian';
  String _selectedUrgency = 'Normal';

  final List<String> _kategoriOptions = [
    'Laporan Kejadian',
    'Permintaan Rehabilitasi',
    'Konsultasi',
    'Informasi Umum',
  ];

  final List<String> _urgencyOptions = [
    'Normal',
    'Mendesak',
    'Sangat Mendesak',
  ];

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
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoCard(),
                        const SizedBox(height: 24),
                        _buildFormSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
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
              'Form Pengaduan &\nPermintaan Bantuan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Informasi Penting',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '• Semua laporan akan ditindaklanjuti sesuai prosedur\n• Data pribadi Anda akan dijaga kerahasiaannya\n• Untuk kasus darurat, hubungi: 031-5023979\n• WhatsApp: 081234484195',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Form Pengaduan',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: 'Nama Lengkap',
          controller: _namaController,
          hintText: 'Masukkan nama lengkap Anda',
          icon: Icons.person,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Nomor Telepon',
          controller: _nomorTeleponController,
          hintText: 'Contoh: 08123456789',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Alamat',
          controller: _alamatController,
          hintText: 'Alamat lengkap Anda',
          icon: Icons.location_on,
          maxLines: 3,
        ),
        const SizedBox(height: 16),
        _buildDropdownField(
          label: 'Kategori Pengaduan',
          value: _selectedKategori,
          options: _kategoriOptions,
          icon: Icons.category,
          onChanged: (value) {
            setState(() {
              _selectedKategori = value!;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildDropdownField(
          label: 'Tingkat Urgensi',
          value: _selectedUrgency,
          options: _urgencyOptions,
          icon: Icons.priority_high,
          onChanged: (value) {
            setState(() {
              _selectedUrgency = value!;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Keterangan Detail',
          controller: _keteranganController,
          hintText:
              'Jelaskan secara detail mengenai pengaduan atau permintaan bantuan Anda',
          icon: Icons.description,
          maxLines: 5,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _handleSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Kirim Pengaduan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Dengan mengirim form ini, Anda menyetujui\nbahwa data akan diproses sesuai kebijakan privasi',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
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
            prefixIcon: Icon(icon, color: const Color(0xFF6B7280), size: 20),
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
              borderSide: const BorderSide(width: 2, color: Color(0xFF2563EB)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> options,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: const Color(0xFF6B7280), size: 20),
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
              borderSide: const BorderSide(width: 2, color: Color(0xFF2563EB)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _handleSubmit() {
    if (_namaController.text.isEmpty ||
        _nomorTeleponController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _keteranganController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon lengkapi semua field yang diperlukan'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    // TODO: Implement actual submission logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Pengaduan berhasil dikirim! Tim kami akan menindaklanjuti.',
        ),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 3),
      ),
    );

    // Clear form
    _namaController.clear();
    _nomorTeleponController.clear();
    _alamatController.clear();
    _keteranganController.clear();
    setState(() {
      _selectedKategori = 'Laporan Kejadian';
      _selectedUrgency = 'Normal';
    });
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nomorTeleponController.dispose();
    _alamatController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }
}
