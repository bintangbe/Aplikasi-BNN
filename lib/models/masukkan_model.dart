class MasukkanModel {
  final String id;
  final String nama;
  final String email;
  final String judul;
  final String isi;
  final DateTime tanggal;
  final String status;
  final List<ChatMessage> percakapan;

  MasukkanModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.judul,
    required this.isi,
    required this.tanggal,
    required this.status,
    required this.percakapan,
  });
}

class ChatMessage {
  final String id;
  final String pengirim; // 'user' atau 'admin'
  final String namaPengirim;
  final String pesan;
  final DateTime waktu;

  ChatMessage({
    required this.id,
    required this.pengirim,
    required this.namaPengirim,
    required this.pesan,
    required this.waktu,
  });
}
