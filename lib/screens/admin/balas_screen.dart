import 'package:flutter/material.dart';
import 'profile_screen.dart';

class BalasScreen extends StatefulWidget {
  final String nama;
  final String email;
  final String judul;
  final String isi;

  const BalasScreen({
    super.key,
    required this.nama,
    required this.email,
    required this.judul,
    required this.isi,
  });

  @override
  State<BalasScreen> createState() => _BalasScreenState();
}

class _BalasScreenState extends State<BalasScreen> {
  final TextEditingController _balasanController = TextEditingController();

  @override
  void dispose() {
    _balasanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background biru atas
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF063CA8), Color(0xFF00AEEF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Isi halaman
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Logo di tengah
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo_bnn.png',
                        height: 100,
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'KOTA\nSURABAYA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Kontainer putih isi
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tombol kembali & judul
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProfileScreen(),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(30),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black12,
                                child: Icon(Icons.arrow_back, size: 16, color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Balas Masukan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Card masukan yang dibalas
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Color(0xFFE7E0EC),
                                  radius: 22,
                                  child: Icon(Icons.person, color: Colors.black),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.nama, 
                                      style: const TextStyle(fontWeight: FontWeight.bold)
                                    ),
                                    Text(widget.email, 
                                      style: const TextStyle(color: Colors.grey)
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF0062F3)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Judul: ${widget.judul}',
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Isi Masukan: ',
                                    style: TextStyle(
                                      color: Color(0xFF0062F3),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: widget.isi),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Form balasan
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Balas Masukan:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _balasanController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Tulis balasan anda disini...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color(0xFF0062F3)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // TODO: Implement kirim balasan
                                  if (_balasanController.text.isNotEmpty) {
                                    // Proses pengiriman balasan
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Balasan berhasil dikirim'),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0062F3),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Kirim Balasan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}