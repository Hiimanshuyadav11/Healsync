import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../widgets/chat_bubble.dart';
import '../services/api_service.dart';
import 'package:file_picker/file_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {'text': "Hi, I'm Healsync.\nHow can I help you today? 🌿", 'isUser': false},
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  PlatformFile? _selectedFile;

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSend() async {
    final text = _controller.text.trim();
    if (text.isEmpty && _selectedFile == null) return;

    if (_selectedFile != null) {
      setState(() {
        messages.add({
          'text': "Uploading ${_selectedFile!.name}...",
          'isUser': true
        });
      });
      _scrollToBottom();

      try {
        final filePath = kIsWeb ? null : _selectedFile!.path;
        await ApiService.uploadFile(
          filePath,
          bytes: _selectedFile!.bytes,
          filename: _selectedFile!.name,
        );
        _selectedFile = null;
      } catch (e) {
        setState(() {
          messages.add({'text': "Upload failed: $e", 'isUser': false});
        });
        return;
      }
    }

    if (text.isNotEmpty) {
      setState(() {
        messages.add({'text': text, 'isUser': true});
      });
      _controller.clear();
      _scrollToBottom();

      try {
        final response = await ApiService.sendMessage(text);
        setState(() {
          messages.add({
            'text': response['reply'] ?? "I didn’t get that.",
            'isUser': false,
          });
        });
      } catch (e) {
        setState(() {
          messages.add({'text': "Error: $e", 'isUser': false});
        });
      }
      _scrollToBottom();
    }
  }

  Future<void> _handleAttachment() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = result.files.single;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Healsync'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  text: messages[index]['text'],
                  isUser: messages[index]['isUser'],
                );
              },
            ),
          ),
          if (_selectedFile != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Attached: ${_selectedFile!.name}",
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          SafeArea(
            child: Row(
              children: [
                IconButton(
                  onPressed: _handleAttachment,
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _handleSend(),
                  ),
                ),
                IconButton(
                  onPressed: _handleSend,
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
