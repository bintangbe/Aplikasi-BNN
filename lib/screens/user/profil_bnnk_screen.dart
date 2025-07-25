import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilBNNKScreen extends StatelessWidget {
  const ProfilBNNKScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil BNNK Surabaya'),
        backgroundColor: const Color(0xFF063CA8),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header dengan logo
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF063CA8).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF063CA8), width: 2),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/bnn.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF063CA8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.image,
                              color: Colors.white,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'BNN Kota Surabaya',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF063CA8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Informasi Kontak
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informasi Kontak',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF063CA8),
                      ),
                    ),
                    const SizedBox(height: 12),
                                        _buildInfoRow(Icons.location_on, 'Alamat', 'Jl. Ngagel Madya V No.22, Barata Jaya'),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.phone_android, 'WhatsApp 1', '081234484195'),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.phone_android, 'WhatsApp 2', '081288881122'),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.email, 'Email', 'bnnkota_surabaya@bnn.go.id '),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Sosial Media
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sosial Media',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF063CA8),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildSocialMediaRow(context, 'Instagram', '@infobnn_kota_surabaya'),
                    const SizedBox(height: 8),
                    _buildSocialMediaRow(context, 'Twitter/X', '@SBnnksby'),
                    const SizedBox(height: 8),
                    _buildSocialMediaRow(context, 'Facebook', 'BNN Kota Surabaya'),
                    const SizedBox(height: 8),
                    _buildSocialMediaRow(context, 'TikTok', '@sahabatbnnksby'),
                    const SizedBox(height: 8),
                    _buildSocialMediaRow(context, 'YouTube', 'sobatbnnkotasurabaya'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: const Color(0xFF063CA8),
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                content,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaRow(BuildContext context, String platform, String handle) {
    IconData icon;
    Color color;
    String url;
    
    switch (platform.toLowerCase()) {
      case 'instagram':
        icon = Icons.camera_alt;
        color = Colors.purple;
        url = 'https://www.instagram.com/infobnn_kota_surabaya?igsh=cXprNGlvZTVwaWk0';
        break;
      case 'twitter/x':
        icon = Icons.alternate_email;
        color = Colors.black;
        url = 'https://x.com/SBnnksby?t=YBOeef7RjC9B7f6X2h6big&s=09';
        break;
      case 'facebook':
        icon = Icons.facebook;
        color = Colors.blue[800]!;
        url = 'https://www.facebook.com/bnnsurabaya?locale=id_ID';
        break;
      case 'tiktok':
        icon = Icons.music_video;
        color = Colors.black;
        url = 'https://www.tiktok.com/@sahabatbnnksby';
        break;
      case 'youtube':
        icon = Icons.play_circle_filled;
        color = Colors.red;
        url = 'https://www.youtube.com/@sobatbnnkotasurabaya';
        break;
      default:
        icon = Icons.link;
        color = Colors.grey;
        url = '';
    }

    return InkWell(
      onTap: () async {
        if (url.isNotEmpty) {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            // Fallback jika tidak bisa membuka URL
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tidak dapat membuka $platform'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    platform,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    handle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.open_in_new,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}