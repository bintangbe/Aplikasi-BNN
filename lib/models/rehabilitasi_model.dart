class RehabilitasiModel {
  final String id;
  final String nama;
  final String nik;
  final String status;
  final String alamat;
  final String jenisKelamin;
  final String lembagaRehab;
  final String tanggalMasuk;
  final String tanggalSelesai;
  final String statusProgress;
  final double? latitude;
  final double? longitude;

  RehabilitasiModel({
    required this.id,
    required this.nama,
    required this.nik,
    required this.status,
    required this.alamat,
    required this.jenisKelamin,
    required this.lembagaRehab,
    required this.tanggalMasuk,
    required this.tanggalSelesai,
    required this.statusProgress,
    this.latitude,
    this.longitude,
  });

  factory RehabilitasiModel.fromMap(Map<String, dynamic> map) {
    return RehabilitasiModel(
      id: map['id'] ?? '',
      nama: map['nama'] ?? '',
      nik: map['nik'] ?? '',
      status: map['status'] ?? '',
      alamat: map['alamat'] ?? '',
      jenisKelamin: map['jenisKelamin'] ?? '',
      lembagaRehab: map['lembagaRehab'] ?? '',
      tanggalMasuk: map['tanggalMasuk'] ?? '',
      tanggalSelesai: map['tanggalSelesai'] ?? '',
      statusProgress: map['statusProgress'] ?? '',
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nik': nik,
      'status': status,
      'alamat': alamat,
      'jenisKelamin': jenisKelamin,
      'lembagaRehab': lembagaRehab,
      'tanggalMasuk': tanggalMasuk,
      'tanggalSelesai': tanggalSelesai,
      'statusProgress': statusProgress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  RehabilitasiModel copyWith({
    String? id,
    String? nama,
    String? nik,
    String? status,
    String? alamat,
    String? jenisKelamin,
    String? lembagaRehab,
    String? tanggalMasuk,
    String? tanggalSelesai,
    String? statusProgress,
    double? latitude,
    double? longitude,
  }) {
    return RehabilitasiModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      nik: nik ?? this.nik,
      status: status ?? this.status,
      alamat: alamat ?? this.alamat,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      lembagaRehab: lembagaRehab ?? this.lembagaRehab,
      tanggalMasuk: tanggalMasuk ?? this.tanggalMasuk,
      tanggalSelesai: tanggalSelesai ?? this.tanggalSelesai,
      statusProgress: statusProgress ?? this.statusProgress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
