import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/rehabilitasi_model.dart';

class RehabilitasiService {
  static const String _storageKey = 'rehabilitasi_data';
  static List<RehabilitasiModel> _rehabilitasiData = [];
  
  // Static data dengan koordinat untuk area Surabaya
  static final Map<String, Map<String, double>> _geocodeData = {
    'lidah': {'latitude': -7.3121, 'longitude': 112.6875},
    'jalan kertajaya': {'latitude': -7.2965, 'longitude': 112.7521},
    'ngagel madya': {'latitude': -7.2947, 'longitude': 112.7271},
    'ngagel madya v': {'latitude': -7.2925, 'longitude': 112.7308}, // BNN Provinsi Jawa Timur - koordinat yang lebih tepat
    'baratajaya': {'latitude': -7.2944, 'longitude': 112.7299}, // Area BNN Provinsi, lebih ke timur
    'kertajaya': {'latitude': -7.2965, 'longitude': 112.7521},
    'surabaya pusat': {'latitude': -7.2575, 'longitude': 112.7521},
    'gubeng': {'latitude': -7.2944, 'longitude': 112.7299}, // Area Gubeng sekitar BNN
    'tegalsari': {'latitude': -7.2892, 'longitude': 112.7585},
    'wonokromo': {'latitude': -7.3121, 'longitude': 112.7271},
    'genteng': {'latitude': -7.2654, 'longitude': 112.7419},
    'sawahan': {'latitude': -7.2754, 'longitude': 112.7419},
    'semampir': {'latitude': -7.2299, 'longitude': 112.7419},
    'bubutan': {'latitude': -7.2385, 'longitude': 112.7298},
    'simokerto': {'latitude': -7.2299, 'longitude': 112.7298},
    'pabean cantikan': {'latitude': -7.2128, 'longitude': 112.7298},
    'krembangan': {'latitude': -7.2128, 'longitude': 112.7177},
    'kenjeran': {'latitude': -7.2043, 'longitude': 112.7941},
    'bulak': {'latitude': -7.2128, 'longitude': 112.7941},
    'tambaksari': {'latitude': -7.2470, 'longitude': 112.7628},
    'mulyorejo': {'latitude': -7.2299, 'longitude': 112.7734},
    'sukolilo': {'latitude': -7.2128, 'longitude': 112.7734},
    'rungkut': {'latitude': -7.3121, 'longitude': 112.7841},
    'tenggilis mejoyo': {'latitude': -7.3207, 'longitude': 112.7734},
    'gunung anyar': {'latitude': -7.3464, 'longitude': 112.7734},
    'wonocolo': {'latitude': -7.3550, 'longitude': 112.7628},
    'wiyung': {'latitude': -7.3379, 'longitude': 112.6875},
    'lakarsantri': {'latitude': -7.2970, 'longitude': 112.6771},
    'benowo': {'latitude': -7.2713, 'longitude': 112.6354},
    'pakal': {'latitude': -7.2213, 'longitude': 112.6458},
    'asemrowo': {'latitude': -7.2213, 'longitude': 112.6771},
    'sukomanunggal': {'latitude': -7.2713, 'longitude': 112.6875},
    'tandes': {'latitude': -7.2556, 'longitude': 112.6667},
    'karang pilang': {'latitude': -7.3293, 'longitude': 112.6875},
    'jambangan': {'latitude': -7.3464, 'longitude': 112.7065},
    'gayungan': {'latitude': -7.3293, 'longitude': 112.7271},
    'dukuh pakis': {'latitude': -7.3036, 'longitude': 112.7065},
  };

  static Future<void> _loadData() async {
    if (_rehabilitasiData.isNotEmpty) return;
    
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(_storageKey);
    
    if (dataString != null && dataString.isNotEmpty) {
      try {
        final List<dynamic> dataList = json.decode(dataString);
        _rehabilitasiData = dataList.map((item) => RehabilitasiModel.fromMap(item)).toList();
      } catch (e) {
        print('Error loading rehabilitation data: $e');
        _rehabilitasiData = _getDefaultData();
      }
    } else {
      _rehabilitasiData = _getDefaultData();
      await _saveData();
    }
  }

  static Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = json.encode(_rehabilitasiData.map((item) => item.toMap()).toList());
    await prefs.setString(_storageKey, dataString);
  }

  static List<RehabilitasiModel> _getDefaultData() {
    return [
      RehabilitasiModel(
        id: '1',
        nama: 'Waishabilla Rahadian F',
        nik: '35020783942961',
        status: 'Rawat Inap',
        alamat: 'Lidah',
        jenisKelamin: 'Laki-laki',
        lembagaRehab: 'Yayasan Rumah Kita',
        tanggalMasuk: '7 Agustus 2024',
        tanggalSelesai: '18 Agustus 2024',
        statusProgress: 'Selesai',
        latitude: -7.3121,
        longitude: 112.6875,
      ),
      RehabilitasiModel(
        id: '2',
        nama: 'Oktavian Ismarudin',
        nik: '35020783942962',
        status: 'Rawat Jalan',
        alamat: 'Jalan Simokerto',
        jenisKelamin: 'Laki-laki',
        lembagaRehab: 'Yayasan Orbit',
        tanggalMasuk: '10 Agustus 2024',
        tanggalSelesai: '20 Agustus 2024',
        statusProgress: 'Masa Rehab',
        latitude: -7.2299, // Simokerto coordinates
        longitude: 112.7298,
      ),
      RehabilitasiModel(
        id: '3',
        nama: 'Bintang Azis Satrio Wibowo',
        nik: '35020783942963',
        status: 'Rawat Jalan',
        alamat: 'Jalan Kertajaya',
        jenisKelamin: 'Laki-laki',
        lembagaRehab: 'Yayasan Plato',
        tanggalMasuk: '15 Agustus 2024',
        tanggalSelesai: '25 Agustus 2024',
        statusProgress: 'Selesai',
        latitude: -7.2965,
        longitude: 112.7521,
      ),
    ];
  }

  static Map<String, double>? _geocodeAddress(String alamat) {
    String normalizedAddress = alamat.toLowerCase().trim();
    
    // Direct match
    if (_geocodeData.containsKey(normalizedAddress)) {
      return _geocodeData[normalizedAddress];
    }
    
    // Partial match
    for (String key in _geocodeData.keys) {
      if (normalizedAddress.contains(key) || key.contains(normalizedAddress)) {
        return _geocodeData[key];
      }
    }
    
    // Default to Surabaya center if no match found
    return {'latitude': -7.2575, 'longitude': 112.7521};
  }

  static Future<List<RehabilitasiModel>> getAllRehabilitasi() async {
    await _loadData();
    return List.from(_rehabilitasiData);
  }

  static Future<List<RehabilitasiModel>> getRehabilitasiByStatus(String status) async {
    await _loadData();
    return _rehabilitasiData.where((item) => item.statusProgress == status).toList();
  }

  static Future<void> addRehabilitasi(RehabilitasiModel rehabilitasi) async {
    await _loadData();
    
    // Auto-geocode the address
    final coordinates = _geocodeAddress(rehabilitasi.alamat);
    final rehabilitasiWithCoords = rehabilitasi.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      latitude: coordinates!['latitude'],
      longitude: coordinates['longitude'],
    );
    
    _rehabilitasiData.add(rehabilitasiWithCoords);
    await _saveData();
  }

  static Future<void> updateRehabilitasi(RehabilitasiModel rehabilitasi) async {
    await _loadData();
    
    final index = _rehabilitasiData.indexWhere((item) => item.id == rehabilitasi.id);
    if (index != -1) {
      // Update coordinates if address changed
      final coordinates = _geocodeAddress(rehabilitasi.alamat);
      final updatedRehabilitasi = rehabilitasi.copyWith(
        latitude: coordinates!['latitude'],
        longitude: coordinates['longitude'],
      );
      
      _rehabilitasiData[index] = updatedRehabilitasi;
      await _saveData();
    }
  }

  static Future<void> deleteRehabilitasi(String id) async {
    await _loadData();
    _rehabilitasiData.removeWhere((item) => item.id == id);
    await _saveData();
  }

  static Future<RehabilitasiModel?> getRehabilitasiById(String id) async {
    await _loadData();
    try {
      return _rehabilitasiData.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  static Future<List<RehabilitasiModel>> searchRehabilitasi(String query) async {
    await _loadData();
    if (query.isEmpty) return _rehabilitasiData;
    
    return _rehabilitasiData.where((item) {
      return item.nama.toLowerCase().contains(query.toLowerCase()) ||
             item.nik.contains(query) ||
             item.alamat.toLowerCase().contains(query.toLowerCase()) ||
             item.lembagaRehab.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Get all rehabilitation locations for map markers
  static Future<List<Map<String, dynamic>>> getMapMarkers() async {
    await _loadData();
    return _rehabilitasiData.map((item) {
      return {
        'id': item.id,
        'nama': item.nama,
        'alamat': item.alamat,
        'status': item.statusProgress,
        'latitude': item.latitude ?? -7.2575,
        'longitude': item.longitude ?? 112.7521,
        'lembagaRehab': item.lembagaRehab,
      };
    }).toList();
  }

  // Clear all data (for testing)
  static Future<void> clearAllData() async {
    _rehabilitasiData.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
