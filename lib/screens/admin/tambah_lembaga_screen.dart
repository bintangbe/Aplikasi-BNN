import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class TambahLembagaScreen extends StatefulWidget {
  const TambahLembagaScreen({super.key});

  @override
  State<TambahLembagaScreen> createState() => _TambahLembagaScreenState();
}

class _TambahLembagaScreenState extends State<TambahLembagaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _alamatController = TextEditingController();
  final _teleponController = TextEditingController();
  final _jamOperasionalController = TextEditingController();
  final _rawatInapLakiController = TextEditingController(text: '0');
  final _rawatInapPerempuanController = TextEditingController(text: '0');
  final _rawatJalanController = TextEditingController(text: '0');
  final _pascaRehabController = TextEditingController(text: '0');
  final _kapasitasLakiController = TextEditingController();
  final _kapasitasPerempuanController = TextEditingController();

  File? _selectedImageFile;
  String? _selectedImagePath;

  @override
  void dispose() {
    _nameController.dispose();
    _alamatController.dispose();
    _teleponController.dispose();
    _jamOperasionalController.dispose();
    _rawatInapLakiController.dispose();
    _rawatInapPerempuanController.dispose();
    _rawatJalanController.dispose();
    _pascaRehabController.dispose();
    _kapasitasLakiController.dispose();
    _kapasitasPerempuanController.dispose();
    super.dispose();
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
                    // Content Header
                    _buildContentHeader(context),

                    // Form Content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Pilih Gambar Card
                                _buildPilihGambarCard(),
                                const SizedBox(height: 16),

                                // Informasi Lembaga Card
                                _buildInformasiLembagaCard(),
                                const SizedBox(height: 16),

                                // Kapasitas Card
                                _buildKapasitasCard(),
                                const SizedBox(height: 24),

                                // Save Button
                                _buildSaveButton(context),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
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
            const Expanded(
              child: Text(
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

            // Admin Profile
            Container(
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
              'Tambah Lembaga Rehabilitasi',
              style: TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPilihGambarCard() {
    return Container(
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
          // Title
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
                  Icons.photo_library,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Pilih Foto Lembaga',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 16,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Image Preview
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _selectedImageFile != null
                  ? Image.file(
                      _selectedImageFile!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : _selectedImagePath != null
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.withOpacity(0.1),
                            Colors.green.withOpacity(0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 48,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Foto Berhasil Dipilih',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF063CA8).withOpacity(0.1),
                            const Color(0xFF00AEEF).withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              color: Color(0xFF063CA8),
                              size: 48,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Pilih Foto dari Gallery',
                              style: TextStyle(
                                color: Color(0xFF063CA8),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 12),

          // Upload Image Button
          Center(
            child: ElevatedButton.icon(
              onPressed: _showImagePicker,
              icon: const Icon(Icons.photo_library, size: 18),
              label: const Text('Pilih dari Gallery'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF063CA8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformasiLembagaCard() {
    return Container(
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
          // Title
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
                  Icons.info_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Informasi Lembaga',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 16,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Form Fields
          _buildTextField(
            controller: _nameController,
            label: 'Nama Lembaga',
            icon: Icons.business,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nama lembaga tidak boleh kosong';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          _buildTextField(
            controller: _alamatController,
            label: 'Alamat Lengkap',
            icon: Icons.location_on,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Alamat tidak boleh kosong';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          _buildTextField(
            controller: _teleponController,
            label: 'Nomor Telepon',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nomor telepon tidak boleh kosong';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          _buildTextField(
            controller: _jamOperasionalController,
            label: 'Jam Operasional',
            icon: Icons.access_time,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Jam operasional tidak boleh kosong';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildKapasitasCard() {
    return Container(
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
          // Title
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
                'Kapasitas Rehabilitasi',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 16,
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Rawat Inap Section
          const Text(
            'Rawat Inap',
            style: TextStyle(
              color: Color(0xFF063CA8),
              fontSize: 14,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          // Rawat Inap Form Fields
          Row(
            children: [
              Expanded(
                child: _buildNumberField(
                  controller: _rawatInapLakiController,
                  label: 'Terisi Laki-laki',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Wajib diisi';
                    }
                    int? intValue = int.tryParse(value);
                    if (intValue == null || intValue < 0) {
                      return 'Harus angka valid';
                    }
                    int kapasitas =
                        int.tryParse(_kapasitasLakiController.text) ?? 0;
                    if (intValue > kapasitas && kapasitas > 0) {
                      return 'Melebihi kapasitas';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildNumberField(
                  controller: _kapasitasLakiController,
                  label: 'Kapasitas Laki-laki',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Wajib diisi';
                    }
                    int? intValue = int.tryParse(value);
                    if (intValue == null || intValue < 0) {
                      return 'Harus >= 0';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildNumberField(
                  controller: _rawatInapPerempuanController,
                  label: 'Terisi Perempuan',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Wajib diisi';
                    }
                    int? intValue = int.tryParse(value);
                    if (intValue == null || intValue < 0) {
                      return 'Harus angka valid';
                    }
                    int kapasitas =
                        int.tryParse(_kapasitasPerempuanController.text) ?? 0;
                    if (intValue > kapasitas && kapasitas > 0) {
                      return 'Melebihi kapasitas';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildNumberField(
                  controller: _kapasitasPerempuanController,
                  label: 'Kapasitas Perempuan',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Wajib diisi';
                    }
                    int? intValue = int.tryParse(value);
                    if (intValue == null || intValue < 0) {
                      return 'Harus >= 0';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Other Services Section
          const Text(
            'Layanan Lainnya',
            style: TextStyle(
              color: Color(0xFF063CA8),
              fontSize: 14,
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _buildNumberField(
                  controller: _rawatJalanController,
                  label: 'Rawat Jalan',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Wajib diisi';
                    }
                    int? intValue = int.tryParse(value);
                    if (intValue == null || intValue < 0) {
                      return 'Harus angka valid';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildNumberField(
                  controller: _pascaRehabController,
                  label: 'Pasca Rehab',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Wajib diisi';
                    }
                    int? intValue = int.tryParse(value);
                    if (intValue == null || intValue < 0) {
                      return 'Harus angka valid';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF063CA8)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF063CA8), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        labelStyle: const TextStyle(
          color: Color(0xFF666666),
          fontSize: 14,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w600,
        ),
      ),
      style: const TextStyle(
        color: Color(0xFF1A1A1A),
        fontSize: 14,
        fontFamily: 'Mulish',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF063CA8), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        labelStyle: const TextStyle(
          color: Color(0xFF666666),
          fontSize: 12,
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w600,
        ),
      ),
      style: const TextStyle(
        color: Color(0xFF1A1A1A),
        fontSize: 14,
        fontFamily: 'Mulish',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () => _saveLembaga(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF063CA8).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Simpan Lembaga',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
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
                      Icons.photo_library,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Pilih Foto dari Gallery',
                    style: TextStyle(
                      color: Color(0xFF1A1A1A),
                      fontSize: 18,
                      fontFamily: 'Mulish',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Gallery Option Only
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00AEEF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF00AEEF).withOpacity(0.3),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.photo_library,
                        color: Color(0xFF00AEEF),
                        size: 48,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Pilih dari Gallery',
                        style: TextStyle(
                          color: Color(0xFF00AEEF),
                          fontSize: 16,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Pilih foto dari galeri perangkat Anda',
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 12,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Simulate gallery image picking
  void _pickImageFromGallery() {
    // In a real app, you would use image_picker package
    // For demo purposes, we'll simulate selecting an image
    setState(() {
      _selectedImagePath =
          'Gallery Photo - ${DateTime.now().millisecondsSinceEpoch}';
      // In real implementation, you would set _selectedImageFile to the actual File
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Foto berhasil dipilih dari gallery'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _saveLembaga(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Generate unique ID (in real app, this would come from backend)
      final String newId = DateTime.now().millisecondsSinceEpoch.toString();

      // Create new lembaga data
      final newLembagaData = {
        'id': newId,
        'name': _nameController.text.trim(),
        'alamatLengkap': _alamatController.text.trim(),
        'nomorTelepon': _teleponController.text.trim(),
        'jamOperasional': _jamOperasionalController.text.trim(),
        'image': _selectedImagePath ?? 'default_image.jpg',
        'rawatInapLaki': int.tryParse(_rawatInapLakiController.text) ?? 0,
        'rawatInapPerempuan':
            int.tryParse(_rawatInapPerempuanController.text) ?? 0,
        'rawatJalan': int.tryParse(_rawatJalanController.text) ?? 0,
        'pascaRehab': int.tryParse(_pascaRehabController.text) ?? 0,
        'kapasitasLaki': int.tryParse(_kapasitasLakiController.text) ?? 0,
        'kapasitasPerempuan':
            int.tryParse(_kapasitasPerempuanController.text) ?? 0,
      };

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
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
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Berhasil',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 16,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            content: const Text(
              'Lembaga rehabilitasi berhasil ditambahkan!',
              style: TextStyle(
                color: Color(0xFF666666),
                fontSize: 14,
                fontFamily: 'Mulish',
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(
                    context,
                  ).pop(newLembagaData); // Return to list with new data
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Color(0xFF063CA8),
                    fontSize: 14,
                    fontFamily: 'Mulish',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
