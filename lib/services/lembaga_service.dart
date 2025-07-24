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
      'capacity': '17 orang',
      'capacityPria': '10 orang',
      'capacityWanita': '7 orang',
      'alamatLengkap': 'Jl. Ngagel Madya V no. 22 Surabaya',
      'nomorTelepon': '081231878822',
      'jamOperasional': '09.00 - 17.00 WIB',
      'image': 'assets/images/klinik_pratama.jpeg',
      'email': 'rehab.bnnksby@gmail.com',
    },
    {
      'id': '2',
      'name': 'Yayasan Rumah Kita Surabaya',
      'location': 'Surabaya Timur',
      'capacity': '17 orang',
      'capacityPria': '9 orang',
      'capacityWanita': '8 orang',
      'alamatLengkap': 'Jl. Ngagel Madya II / 9 Surabaya',
      'nomorTelepon': '081230724211',
      'jamOperasional': '24 Jam',
      'image': 'assets/images/yayasan_rumah_kita.jpeg',
      'email': 'rumahkitasby86@gmail.com',
    },
    {
      'id': '3',
      'name': 'Yayasan Orbit Surabaya',
      'location': 'Surabaya Timur',
      'capacity': '24 orang',
      'capacityPria': '15 orang',
      'capacityWanita': '9 orang',
      'alamatLengkap':
          'Jl. BarataJaya XII A No.6, RT.001/RW.004, Baratajaya, Kec. Gubeng, Surabaya',
      'nomorTelepon': '082245948605',
      'jamOperasional': '09.00 - 17.00 WIB',
      'image': 'assets/images/yayasan_orbit.jpeg',
      'email': 'orbit.foundation@yahoo.com',
    },
    {
      'id': '4',
      'name': 'Yayasan Plato Surabaya',
      'location': 'Surabaya Timur',
      'capacity': '24 orang',
      'capacityPria': '14 orang',
      'capacityWanita': '10 orang',
      'alamatLengkap':
          'Jl. Cipta Mananggal v No. 16, RT 011 RW 005, Kelurahan Menanggal, Kecamatan Gayungan',
      'nomorTelepon': '081330351599',
      'jamOperasional': '08.00 - 16.00 WIB',
      'image': 'assets/images/yayasan_plato_surabaya.jpeg',
      'email': 'plato.found@gmail.com',
    },
    {
      'id': '5',
      'name': 'Yayasan LRPPN-BI Surabaya',
      'location': 'Surabaya Selatan',
      'capacity': '20 orang',
      'capacityPria': '12 orang',
      'capacityWanita': '8 orang',
      'alamatLengkap':
          'Jl. Khairil Anwar No.23, Darmo, Kec. Wonokromo, Surabaya',
      'nomorTelepon': '08123263524',
      'jamOperasional': '08.00 - 20.00 WIB',
      'image': 'assets/images/yayasan_lrppn.jpeg',
      'email': 'pantilrppnsurabaya@gmail.com',
    },
    {
      'id': '6',
      'name': 'Yayasan Rumah Merah Putih Surabaya',
      'location': 'Waru',
      'capacity': '25 orang',
      'capacityPria': '15 orang',
      'capacityWanita': '10 orang',
      'alamatLengkap': 'Jl. Blimbing I No.18, Ngipa, Wadungasri, Kec. Waru',
      'nomorTelepon': '085853125026',
      'jamOperasional': '09.00 - 15.00 WIB',
      'image': 'assets/images/yayasan_rumah_merah_putih.jpeg',
      'email': 'Mako2rungkut@gmail.com',
    },
    {
      'id': '7',
      'name': 'Yayasan Griya Ashefa Pusaka Surabaya',
      'location': 'Surabaya',
      'capacity': '20 orang',
      'capacityPria': '12 orang',
      'capacityWanita': '8 orang',
      'alamatLengkap': 'Jl Kutisari XIA no 1 RT 08 RW 05 Surabaya',
      'nomorTelepon': '085959591822',
      'jamOperasional': '09.00 - 17.00 WIB',
      'image': 'assets/images/yayasan_ashefa_griya_pusaka.jpeg',
      'email': 'fpratiwisuryaningrums@gmail.com',
    },
    {
      'id': '8',
      'name': 'RS Menur Surabaya',
      'location': 'Surabaya Pusat',
      'capacity': '42 orang',
      'capacityPria': '25 orang',
      'capacityWanita': '17 orang',
      'alamatLengkap': 'Jl. Raya Menur No. 120 Surabaya',
      'nomorTelepon': '081330305585',
      'jamOperasional': 'Buka 24 jam',
      'image': 'assets/images/rs_menur.jpeg',
      'email': 'rsj.menur@gmail.com',
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
    },
    {
      'id': '10',
      'name': 'Subdirektorat Mitigasi Crisis Center Unesa',
      'location': 'Surabaya Barat',
      'capacity': '10 orang',
      'capacityPria': '6 orang',
      'capacityWanita': '4 orang',
      'alamatLengkap':
          'SMCC di Gedung rektorat unesa lantai 4. Jl. Lidah Wetan, Lidah Wetan, Kec. Lakarsantri, Surabaya',
      'nomorTelepon': '0812-3456-7890',
      'jamOperasional': '09.00 - 15.00 WIB',
      'image': 'assets/images/smcc_unesa.jpeg',
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
