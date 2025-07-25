import 'package:flutter/material.dart';

class DetailLembagaUserScreen extends StatelessWidget {
  final Map<String, dynamic> lembagaData;

  const DetailLembagaUserScreen({super.key, required this.lembagaData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              _buildHeader(context),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildImageSection(),
                        _buildDetailContent(),
                        const SizedBox(height: 20),
                      ],
                    ),
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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Detail Lembaga',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    final image = lembagaData['image'] ?? 'assets/images/placeholder.jpeg';

    return Container(
      margin: const EdgeInsets.all(20),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) =>
                      const Icon(Icons.broken_image),
                ),
              ),
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailContent() {
    final name = lembagaData['name'] ?? 'Nama tidak tersedia';
    final location = lembagaData['location'] ?? 'Lokasi tidak tersedia';
    final alamatLengkap =
        lembagaData['alamatLengkap'] ?? 'Alamat tidak tersedia';
    final nomorTelepon = lembagaData['nomorTelepon'] ?? 'Nomor tidak tersedia';
    final jamOperasional =
        lembagaData['jamOperasional'] ?? 'Jam tidak tersedia';
    final email = lembagaData['email'] ?? 'Email tidak tersedia';

    // Get detailed capacity information using same structure as admin
    final kapasitasLaki = lembagaData['kapasitasLaki'] ?? 0;
    final kapasitasPerempuan = lembagaData['kapasitasPerempuan'] ?? 0;
    final rawatInapLaki = lembagaData['rawatInapLaki'] ?? 0;
    final rawatInapPerempuan = lembagaData['rawatInapPerempuan'] ?? 0;
    final rawatJalan = lembagaData['rawatJalan'] ?? 0;
    final pascaRehab = lembagaData['pascaRehab'] ?? 0;

    // Calculate total capacity and remaining slots
    final totalKapasitas = kapasitasLaki + kapasitasPerempuan;
    final totalTerisi = rawatInapLaki + rawatInapPerempuan;
    final sisaKapasitas = totalKapasitas - totalTerisi;

    // Fallback to old structure if new structure is not available
    final capacityPria = kapasitasLaki > 0
        ? '$kapasitasLaki orang'
        : (lembagaData['capacityPria'] ??
              lembagaData['capacity_pria'] ??
              'Tidak tersedia');
    final capacityWanita = kapasitasPerempuan > 0
        ? '$kapasitasPerempuan orang'
        : (lembagaData['capacityWanita'] ??
              lembagaData['capacity_wanita'] ??
              'Tidak tersedia');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            location,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),

          // Informasi Umum
          _buildDetailCard('Informasi Umum', [
            _buildDetailRow(
              Icons.location_on_outlined,
              'Alamat Lengkap',
              alamatLengkap,
              const Color(0xFF059669),
            ),
            _buildDetailRow(
              Icons.access_time_outlined,
              'Jam Operasional',
              jamOperasional,
              const Color(0xFFF59E0B),
            ),
          ]),

          const SizedBox(height: 16),

          // Kontak
          _buildDetailCard('Kontak', [
            _buildDetailRow(
              Icons.phone_outlined,
              'Nomor Telepon',
              nomorTelepon,
              const Color(0xFF059669),
            ),
            _buildDetailRow(
              Icons.email_outlined,
              'Email',
              email,
              const Color(0xFF2563EB),
            ),
          ]),

          const SizedBox(height: 16),

          // Kapasitas Rehabilitasi (if detailed data available)
          if (totalKapasitas > 0) ...[
            _buildDetailCard('Kapasitas Rehabilitasi', [
              _buildDetailRow(
                Icons.analytics_outlined,
                'Kapasitas Total',
                '$totalKapasitas orang',
                const Color(0xFF063CA8),
              ),
              _buildDetailRow(
                Icons.person_outline,
                'Sisa Kapasitas',
                '$sisaKapasitas orang',
                const Color(0xFF00AEEF),
              ),
            ]),

            const SizedBox(height: 16),

            // Detail Kapasitas per Kategori
            _buildDetailCard('Detail Kapasitas', [
              _buildCapacityDetailRow(
                'Rawat Inap Laki-laki',
                rawatInapLaki,
                kapasitasLaki,
                const Color(0xFF2563EB),
              ),
              _buildCapacityDetailRow(
                'Rawat Inap Perempuan',
                rawatInapPerempuan,
                kapasitasPerempuan,
                const Color(0xFFEC4899),
              ),
              _buildDetailRow(
                Icons.local_hospital_outlined,
                'Rawat Jalan',
                '$rawatJalan pasien',
                const Color(0xFF059669),
              ),
              _buildDetailRow(
                Icons.timeline_outlined,
                'Pasca Rehabilitasi',
                '$pascaRehab peserta',
                const Color(0xFFF59E0B),
              ),
            ]),
          ] else ...[
            // Fallback to old capacity structure
            _buildDetailCard('Kapasitas', [
              _buildDetailRow(
                Icons.man_outlined,
                'Kapasitas Pria',
                capacityPria,
                const Color(0xFF2563EB),
              ),
              _buildDetailRow(
                Icons.woman_outlined,
                'Kapasitas Wanita',
                capacityWanita,
                const Color(0xFFEC4899),
              ),
            ]),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCapacityDetailRow(
    String label,
    int current,
    int capacity,
    Color iconColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              current > capacity * 0.8 ? Icons.warning : Icons.bed_outlined,
              color: current > capacity * 0.8 ? Colors.orange : iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '$current / $capacity',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1F2937),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: capacity > 0 ? current / capacity : 0,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          current > capacity * 0.8 ? Colors.orange : iconColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${capacity > 0 ? ((current / capacity) * 100).toInt() : 0}%',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
