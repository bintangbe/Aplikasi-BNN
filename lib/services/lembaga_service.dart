import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LembagaService {
  static const String _key = 'lembaga_data';
  static LembagaService? _instance;
  static LembagaService get instance => _instance ??= LembagaService._();

  LembagaService._();

  // Data default lembaga
  static final List<Map<String, dynamic>> _defaultLembaga = [
    {
      'id': '1',
      'name': 'Klinik Pratama BNN Kota Surabaya',
      'location': 'Surabaya Selatan',
      'capacity': '100 orang',
      'capacityPria': '50 orang',
      'capacityWanita': '50 orang',
      'alamatLengkap': 'Jl. Ngagel Madya V no. 22 Surabaya',
      'nomorTelepon': '081231878822',
      'jamOperasional': '09.00 - 17.00 WIB',
      'image': 'assets/images/klinik_pratama1.jpg',
      'email': 'rehab.bnnksby@gmail.com',
      // Detailed capacity data
      'rawatInapLaki': 12,
      'rawatInapPerempuan': 8,
      'rawatJalan': 15,
      'pascaRehab': 10,
      'kapasitasLaki': 50,
      'kapasitasPerempuan': 50,
    },
    {
      'id': '2',
      'name': 'Yayasan Rumah Kita Surabaya',
      'location': 'Surabaya Timur',
      'capacity': '17 orang',
      'capacityPria': '17 orang',
      'capacityWanita': '0 orang',
      'alamatLengkap': 'Jl. Ngagel Madya II / 9 Surabaya',
      'nomorTelepon': '081230724211',
      'jamOperasional': '09.00 - 16.00 WIB',
      'image': 'assets/images/yayasan_rumah_kita.jpeg',
      'email': 'rumahkitasby86@gmail.com',
      // Detailed capacity data
      'rawatInapLaki': 3,
      'rawatInapPerempuan': 0,
      'rawatJalan': 2,
      'pascaRehab': 1,
      'kapasitasLaki': 17,
      'kapasitasPerempuan': 0,
    },
    {
      'id': '3',
      'name': 'Yayasan Orbit Surabaya',
      'location': 'Surabaya Timur',
      'capacity': '24 orang',
      'capacityPria': '24 orang',
      'capacityWanita': '0 orang',
      'alamatLengkap': 'Jl. Margorejo Indah Utara Blok B-922, Surabaya',
      'nomorTelepon': '081233563815',
      'jamOperasional': '09.00 - 21.00 WIB',
      'image': 'assets/images/yayasan_orbit.jpeg',
      'email': 'orbit.foundation@yahoo.com',
      // Detailed capacity data
      'rawatInapLaki': 5,
      'rawatInapPerempuan': 0,
      'rawatJalan': 3,
      'pascaRehab': 2,
      'kapasitasLaki': 24,
      'kapasitasPerempuan': 0,
    },
    {
      'id': '4',
      'name': 'Yayasan Plato Surabaya',
      'location': 'Surabaya Timur',
      'capacity': '40 orang',
      'capacityPria': '30 orang',
      'capacityWanita': '10 orang',
      'alamatLengkap':
          'Jalan Pagesangan Baru IV/5, RT 008 RW 001, kel. Pagesangangan, Kec. Jambangan, Surabaya',
      'nomorTelepon': '081330351599',
      'jamOperasional': '09.00 - 17.00 WIB',
      'image': 'assets/images/yayasan_plato_surabaya.jpeg',
      'email': 'plato.found@gmail.com',
      // Detailed capacity data
      'rawatInapLaki': 8,
      'rawatInapPerempuan': 2,
      'rawatJalan': 4,
      'pascaRehab': 3,
      'kapasitasLaki': 30,
      'kapasitasPerempuan': 10,
    },
    {
      'id': '5',
      'name': 'Yayasan LRPPN-BI Surabaya',
      'location': 'Surabaya Selatan',
      'capacity': '25 orang',
      'capacityPria': '25 orang',
      'capacityWanita': '0 orang',
      'alamatLengkap':
          'Jl. Khairil Anwar No.23, Darmo, Kec. Wonokromo, Surabaya',
      'nomorTelepon': '08123263524',
      'jamOperasional': '08.00 - 20.00 WIB',
      'image': 'assets/images/yayasan_lrppn.jpeg',
      'email': 'pantilrppnsurabaya@gmail.com',
      // Detailed capacity data
      'rawatInapLaki': 6,
      'rawatInapPerempuan': 0,
      'rawatJalan': 2,
      'pascaRehab': 1,
      'kapasitasLaki': 25,
      'kapasitasPerempuan': 0,
    },
    {
      'id': '6',
      'name': 'Yayasan Rumah Merah Putih Surabaya',
      'location': 'Surabaya',
      'capacity': '25 orang',
      'capacityPria': '25 orang',
      'capacityWanita': '0 orang',
      'alamatLengkap':
          'Jl. Rungkut Mananggal Blok X-19 Rt.009 Rw.004 Kel.Rungkut Mananggal Kec. Gunung Anyar, Surabaya',
      'nomorTelepon': '085853125026',
      'jamOperasional': '09.00 - 15.00 WIB',
      'image': 'assets/images/yayasan_rumah_merah_putih.jpeg',
      'email': 'Mako2rungkut@gmail.com',
      // Detailed capacity data
      'rawatInapLaki': 4,
      'rawatInapPerempuan': 0,
      'rawatJalan': 1,
      'pascaRehab': 2,
      'kapasitasLaki': 25,
      'kapasitasPerempuan': 0,
    },
    {
      'id': '7',
      'name': 'Yayasan Griya Ashefa Pusaka Surabaya',
      'location': 'Surabaya',
      'capacity': '25 orang',
      'capacityPria': '20 orang',
      'capacityWanita': '5 orang',
      'alamatLengkap': 'Jl Kutisari XIA no 1 RT 08 RW 05 Surabaya',
      'nomorTelepon': '087887175964',
      'jamOperasional': '09.00 - 17.00 WIB',
      'image': 'assets/images/yayasan_ashefa_griya_pusaka.jpeg',
      'email': 'fpratiwisuryaningrums@gmail.com',
      // Detailed capacity data
      'rawatInapLaki': 7,
      'rawatInapPerempuan': 1,
      'rawatJalan': 3,
      'pascaRehab': 2,
      'kapasitasLaki': 20,
      'kapasitasPerempuan': 5,
    },
    {
      'id': '8',
      'name': 'RS Menur Surabaya',
      'location': 'Surabaya Pusat',
      'capacity': '50 orang',
      'capacityPria': '25 orang',
      'capacityWanita': '25 orang',
      'alamatLengkap': 'Jl. Raya Menur No. 120 Surabaya',
      'nomorTelepon': '081330305585',
      'jamOperasional': '09.00 - 16.00 WIB',
      'image': 'assets/images/rs_menur.jpeg',
      'email': 'rsj.menur@gmail.com',
      // Detailed capacity data
      'rawatInapLaki': 10,
      'rawatInapPerempuan': 8,
      'rawatJalan': 6,
      'pascaRehab': 4,
      'kapasitasLaki': 25,
      'kapasitasPerempuan': 25,
    },
    {
      'id': '9',
      'name': 'Omah Sehat Bersinar',
      'location': 'Surabaya Pusat',
      'capacity': '30 orang',
      'capacityPria': '18 orang',
      'capacityWanita': '12 orang',
      'alamatLengkap': 'Jl. Jemur Andayani No.50 Surabaya',
      'nomorTelepon': 'Tidak tersedia',
      'jamOperasional': '08.00 - 17.00 WIB',
      'image': 'assets/images/yayasan_omah_sehat_bersinar.jpeg',
      // Detailed capacity data
      'rawatInapLaki': 5,
      'rawatInapPerempuan': 3,
      'rawatJalan': 2,
      'pascaRehab': 1,
      'kapasitasLaki': 18,
      'kapasitasPerempuan': 12,
    },
    {
      'id': '10',
      'name': 'Subdirektorat Mitigasi Crisis Center Unesa',
      'location': 'Surabaya Barat',
      'capacity': '10 orang',
      'capacityPria': '5 orang',
      'capacityWanita': '5 orang',
      'alamatLengkap':
          'SMCC di Gedung rektorat unesa lantai 4. Jl. Lidah Wetan, Lidah Wetan, Kec. Lakarsantri, Surabaya',
      'nomorTelepon': '0812-3456-7890',
      'jamOperasional': '09.00 - 15.00 WIB',
      'image': 'assets/images/yayasan_unesa.jpeg',
      // Detailed capacity data
      'rawatInapLaki': 2,
      'rawatInapPerempuan': 1,
      'rawatJalan': 1,
      'pascaRehab': 0,
      'kapasitasLaki': 5,
      'kapasitasPerempuan': 5,
    },
  ];

  // Mendapatkan semua data lembaga
  Future<List<Map<String, dynamic>>> getAllLembaga() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? dataString = prefs.getString(_key);

      if (dataString != null) {
        final List<dynamic> jsonList = json.decode(dataString);
        return jsonList.cast<Map<String, dynamic>>();
      } else {
        // Jika belum ada data, gunakan data default
        await _saveToStorage(_defaultLembaga);
        return _defaultLembaga;
      }
    } catch (e) {
      return _defaultLembaga;
    }
  }

  // Menyimpan data lembaga
  Future<bool> saveLembaga(List<Map<String, dynamic>> lembagaList) async {
    try {
      await _saveToStorage(lembagaList);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Menambah lembaga baru
  Future<bool> addLembaga(Map<String, dynamic> newLembaga) async {
    try {
      final currentList = await getAllLembaga();
      newLembaga['id'] = DateTime.now().millisecondsSinceEpoch.toString();
      currentList.add(newLembaga);
      return await saveLembaga(currentList);
    } catch (e) {
      return false;
    }
  }

  // Mengupdate lembaga
  Future<bool> updateLembaga(Map<String, dynamic> updatedLembaga) async {
    try {
      final currentList = await getAllLembaga();
      final index = currentList.indexWhere(
        (item) => item['id'] == updatedLembaga['id'],
      );

      if (index != -1) {
        currentList[index] = updatedLembaga;
        return await saveLembaga(currentList);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Menghapus lembaga
  Future<bool> deleteLembaga(String id) async {
    try {
      final currentList = await getAllLembaga();
      currentList.removeWhere((item) => item['id'] == id);
      return await saveLembaga(currentList);
    } catch (e) {
      return false;
    }
  }

  // Helper method untuk menyimpan ke storage
  Future<void> _saveToStorage(List<Map<String, dynamic>> data) async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = json.encode(data);
    await prefs.setString(_key, jsonString);
  }

  // Stream untuk mendengarkan perubahan data (optional)
  Stream<List<Map<String, dynamic>>> get lembagaStream async* {
    while (true) {
      yield await getAllLembaga();
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
