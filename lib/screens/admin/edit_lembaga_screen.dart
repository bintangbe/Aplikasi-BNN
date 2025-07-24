import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditLembagaScreen extends StatefulWidget {
  final Map<String, dynamic> lembagaData;

  const EditLembagaScreen({super.key, required this.lembagaData});

  @override
  State<EditLembagaScreen> createState() => _EditLembagaScreenState();
}

class _EditLembagaScreenState extends State<EditLembagaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _alamatController;
  late TextEditingController _teleponController;
  late TextEditingController _jamOperasionalController;
  late TextEditingController _rawatInapLakiController;
  late TextEditingController _rawatInapPerempuanController;
  late TextEditingController _rawatJalanController;
  late TextEditingController _pascaRehabController;
  late TextEditingController _kapasitasLakiController;
  late TextEditingController _kapasitasPerempuanController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameController = TextEditingController(
      text: widget.lembagaData['name'] ?? '',
    );
    _alamatController = TextEditingController(
      text: widget.lembagaData['alamatLengkap'] ?? '',
    );
    _teleponController = TextEditingController(
      text: widget.lembagaData['nomorTelepon'] ?? '',
    );
    _jamOperasionalController = TextEditingController(
      text: widget.lembagaData['jamOperasional'] ?? '',
    );

    // Initialize capacity controllers with default values
    _rawatInapLakiController = TextEditingController(
      text: widget.lembagaData['rawatInapLaki']?.toString() ?? '3',
    );
    _rawatInapPerempuanController = TextEditingController(
      text: widget.lembagaData['rawatInapPerempuan']?.toString() ?? '1',
    );
    _rawatJalanController = TextEditingController(
      text: widget.lembagaData['rawatJalan']?.toString() ?? '2',
    );
    _pascaRehabController = TextEditingController(
      text: widget.lembagaData['pascaRehab']?.toString() ?? '2',
    );
    _kapasitasLakiController = TextEditingController(
      text: widget.lembagaData['kapasitasLaki']?.toString() ?? '17',
    );
    _kapasitasPerempuanController = TextEditingController(
      text: widget.lembagaData['kapasitasPerempuan']?.toString() ?? '5',
    );
  }

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
                                // Informasi Lembaga Card
                                _buildInformasiLembagaCard(),
                                const SizedBox(height: 16),

                                // Kapasitas Card
                                _buildKapasitasCard(),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Save Button positioned at bottom
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      child: _buildSaveButton(context),
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
              'Edit Lembaga Rehabilitasi',
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
                    if (intValue > kapasitas) {
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
                    if (intValue == null || intValue <= 0) {
                      return 'Harus > 0';
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
                    if (intValue > kapasitas) {
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
                    if (intValue == null || intValue <= 0) {
                      return 'Harus > 0';
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
        onPressed: () => _saveChanges(context),
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
              'Simpan Perubahan',
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

  void _saveChanges(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Create updated data
      final updatedData = {
        ...widget.lembagaData,
        'name': _nameController.text.trim(),
        'alamatLengkap': _alamatController.text.trim(),
        'nomorTelepon': _teleponController.text.trim(),
        'jamOperasional': _jamOperasionalController.text.trim(),
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
              'Data lembaga berhasil diperbarui!',
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
                  ).pop(updatedData); // Return to detail with updated data
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
