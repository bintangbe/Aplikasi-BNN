import '../models/masukkan_model.dart';

class MasukkanService {
  static final MasukkanService _instance = MasukkanService._internal();
  factory MasukkanService() => _instance;
  MasukkanService._internal();

  final List<MasukkanModel> _daftarMasukkan = [
    MasukkanModel(
      id: '1',
      nama: 'Diana Cantika',
      email: 'dianacanci123@gmail.com',
      judul: 'Kurangnya Privasi Saat Konsultasi di Tempat Rehabilitasi',
      isi: 'Halo BNN, saya mau sampaikan sedikit unek-unek waktu dampingi teman saya konsultasi ke salah satu tempat rehabilitasi. '
          'Pas sesi konsultasi berlangsung, ruangannya ternyata terbuka dan ada beberapa orang lain yang bisa dengar pembicaraan. '
          'Padahal menurut saya, untuk hal sensitif kayak gini, privasi itu penting banget.',
      tanggal: DateTime(2025, 7, 20),
      status: 'Belum Dibalas',
      percakapan: [],
    ),
    MasukkanModel(
      id: '2',
      nama: 'Budi Santoso',
      email: 'budisantoso@gmail.com',
      judul: 'Saran Untuk Program Pencegahan di Sekolah',
      isi: 'Selamat siang BNN, saya ingin memberikan saran terkait program pencegahan narkoba di sekolah. '
          'Mungkin bisa ditambahkan sesi interaktif atau games yang lebih menarik agar siswa lebih antusias dalam mengikuti program.',
      tanggal: DateTime(2025, 7, 19),
      status: 'Menunggu Balasan Admin',
      percakapan: [
        ChatMessage(
          id: '1',
          pengirim: 'admin',
          namaPengirim: 'Admin BNN',
          pesan: 'Terima kasih atas saran yang sangat berharga, Bapak Budi. Kami sangat mengapresiasi masukan Anda terkait program pencegahan narkoba di sekolah. '
              'Saran Anda untuk menambahkan sesi interaktif dan games edukatif akan kami sampaikan kepada tim yang bertanggung jawab untuk pengembangan program. '
              'Kami terus berupaya meningkatkan metode penyampaian agar lebih menarik dan efektif bagi para siswa.',
          waktu: DateTime(2025, 7, 19, 14, 30),
        ),
        ChatMessage(
          id: '2',
          pengirim: 'user',
          namaPengirim: 'Budi Santoso',
          pesan: 'Terima kasih atas responnya, Admin. Saya juga ingin menambahkan bahwa mungkin bisa dipertimbangkan untuk mengundang alumni yang pernah mengalami rehabilitasi untuk berbagi cerita. '
              'Menurut saya, testimoni langsung dari mereka akan lebih berkesan bagi para siswa.',
          waktu: DateTime(2025, 7, 19, 15, 45),
        ),
      ],
    ),
  ];

  List<MasukkanModel> get daftarMasukkan => List.unmodifiable(_daftarMasukkan);

  void tambahMasukkan(MasukkanModel masukkan) {
    _daftarMasukkan.add(masukkan);
  }

  void tambahBalasan(String masukkanId, ChatMessage pesan) {
    final index = _daftarMasukkan.indexWhere((m) => m.id == masukkanId);
    if (index != -1) {
      _daftarMasukkan[index].percakapan.add(pesan);
      // Update status berdasarkan pengirim pesan terakhir
      String newStatus;
      if (_daftarMasukkan[index].percakapan.isEmpty) {
        newStatus = 'Menunggu Balasan';
      } else {
        final lastMessage = _daftarMasukkan[index].percakapan.last;
        if (lastMessage.pengirim == 'admin') {
          newStatus = 'Menunggu Balasan User';
        } else {
          newStatus = 'Menunggu Balasan Admin';
        }
      }
      
      _daftarMasukkan[index] = MasukkanModel(
        id: _daftarMasukkan[index].id,
        nama: _daftarMasukkan[index].nama,
        email: _daftarMasukkan[index].email,
        judul: _daftarMasukkan[index].judul,
        isi: _daftarMasukkan[index].isi,
        tanggal: _daftarMasukkan[index].tanggal,
        status: newStatus,
        percakapan: _daftarMasukkan[index].percakapan,
      );
    }
  }

  MasukkanModel? getMasukkanById(String id) {
    try {
      return _daftarMasukkan.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // Mendapatkan status dinamis berdasarkan percakapan terakhir
  String getStatusDinamis(MasukkanModel masukkan) {
    if (masukkan.percakapan.isEmpty) {
      return 'Menunggu Balasan';
    }
    
    final lastMessage = masukkan.percakapan.last;
    if (lastMessage.pengirim == 'admin') {
      return 'Menunggu Balasan User';
    } else {
      return 'Menunggu Balasan Admin';
    }
  }
}
