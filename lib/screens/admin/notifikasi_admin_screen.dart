import 'package:flutter/material.dart';
import '../../widgets/admin_header.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pesanMasuk = [
      {'judul': 'Balasan Masukkan', 'isi': 'Terima kasih atas masukkan Anda, akan kami tindaklanjuti.'},
      {'judul': 'Info Kegiatan', 'isi': 'BNNK Surabaya mengadakan sosialisasi P4GN minggu depan.'},
    ];
    return Scaffold(
      body: Column(
        children: [
          const AdminHeader(),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: pesanMasuk.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, i) => Card(
                child: ListTile(
                  title: Text(pesanMasuk[i]['judul'] ?? ''),
                  subtitle: Text(pesanMasuk[i]['isi'] ?? ''),
                  leading: const Icon(Icons.notifications_active, color: Color(0xFF2563EB)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
