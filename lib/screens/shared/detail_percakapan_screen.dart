import 'package:flutter/material.dart';
import '../../models/masukkan_model.dart';
import '../../services/masukkan_service.dart';

class DetailPercakapanScreen extends StatefulWidget {
  final MasukkanModel masukkan;
  final bool isAdmin;
  final String currentUserName;

  const DetailPercakapanScreen({
    super.key,
    required this.masukkan,
    required this.isAdmin,
    required this.currentUserName,
  });

  @override
  State<DetailPercakapanScreen> createState() => _DetailPercakapanScreenState();
}

class _DetailPercakapanScreenState extends State<DetailPercakapanScreen> {
  final TextEditingController _pesanController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final MasukkanService _masukkanService = MasukkanService();
  late MasukkanModel _currentMasukkan;

  @override
  void initState() {
    super.initState();
    _currentMasukkan = widget.masukkan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isAdmin ? 'Balas Masukkan' : 'Detail Masukkan',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF063CA8),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Header dengan info masukkan
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFE7E0EC),
                      radius: 20,
                      child: Text(
                        _currentMasukkan.nama[0].toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentMasukkan.nama,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            _currentMasukkan.email,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _currentMasukkan.status == 'Sudah Dibalas'
                            ? Colors.green.withOpacity(0.2)
                            : Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _currentMasukkan.status,
                        style: TextStyle(
                          fontSize: 12,
                          color: _currentMasukkan.status == 'Sudah Dibalas'
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF0062F3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentMasukkan.judul,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _currentMasukkan.isi,
                        style: const TextStyle(
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_currentMasukkan.tanggal.day}/${_currentMasukkan.tanggal.month}/${_currentMasukkan.tanggal.year}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _currentMasukkan.percakapan.length,
              itemBuilder: (context, index) {
                final pesan = _currentMasukkan.percakapan[index];
                final isMe = widget.isAdmin
                    ? pesan.pengirim == 'admin'
                    : pesan.pengirim == 'user';

                return _buildChatBubble(pesan, isMe);
              },
            ),
          ),

          // Input pesan
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pesanController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF063CA8),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _kirimPesan,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage pesan, bool isMe) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              backgroundColor: pesan.pengirim == 'admin'
                  ? const Color(0xFF063CA8)
                  : const Color(0xFFE7E0EC),
              radius: 16,
              child: Icon(
                pesan.pengirim == 'admin' ? Icons.support_agent : Icons.person,
                color: pesan.pengirim == 'admin' ? Colors.white : Colors.black,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe
                    ? const Color(0xFF063CA8)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMe)
                    Text(
                      pesan.namaPengirim,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: isMe ? Colors.white70 : Colors.grey[600],
                      ),
                    ),
                  if (!isMe) const SizedBox(height: 4),
                  Text(
                    pesan.pesan,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${pesan.waktu.hour.toString().padLeft(2, '0')}:${pesan.waktu.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      fontSize: 10,
                      color: isMe ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: widget.isAdmin
                  ? const Color(0xFF063CA8)
                  : const Color(0xFFE7E0EC),
              radius: 16,
              child: Icon(
                widget.isAdmin ? Icons.support_agent : Icons.person,
                color: widget.isAdmin ? Colors.white : Colors.black,
                size: 20,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _kirimPesan() {
    if (_pesanController.text.trim().isEmpty) return;

    final pesanBaru = ChatMessage(
      id: _masukkanService.generateId(),
      pengirim: widget.isAdmin ? 'admin' : 'user',
      namaPengirim: widget.currentUserName,
      pesan: _pesanController.text.trim(),
      waktu: DateTime.now(),
    );

    _masukkanService.tambahBalasan(_currentMasukkan.id, pesanBaru);

    setState(() {
      _currentMasukkan = _masukkanService.getMasukkanById(_currentMasukkan.id)!;
    });

    _pesanController.clear();

    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pesan berhasil dikirim!'),
        backgroundColor: Color(0xFF10B981),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _pesanController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
