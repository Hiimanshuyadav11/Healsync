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
  PlatformFile? _selectedFile; // Added state for selected file

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
    if (text.isEmpty && _selectedFile == null) return; // Allow sending if only file is present

    if (_selectedFile != null) {
      setState(() {
        messages.add({'text': "Uploading ${_selectedFile!.name}...", 'isUser': true});
      });
      _scrollToBottom();
      
      try {
        final String? filePath = kIsWeb ? null : _selectedFile!.path;
        await ApiService.uploadFile(
          filePath,
          bytes: _selectedFile!.bytes,
          filename: _selectedFile!.name,
        );
        setState(() {
            _selectedFile = null; // Clear after upload
        });
      } catch (e) {
        if (!mounted) return;
         setState(() {
          messages.add({'text': "Upload failed: $e", 'isUser': false});
        });
        return; // Stop if upload fails
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
      if (!mounted) return;
      setState(() {
        messages.add({
          'text': response['reply'] ?? "I didn't get that.",
          'isUser': false,
        });
      });
      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        messages.add({
          'text': "Error: $e",
          'isUser': false,
        });
      });
      _scrollToBottom();
    }
   }
  }

  Future<void> _handleAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
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
      backgroundColor: const Color(0xFF121212), // Dark premium background
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1E1E1E),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
              child: const Text('H', style: TextStyle(color: Colors.blueAccent)),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Healsync', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Online', style: TextStyle(fontSize: 12, color: Colors.greenAccent)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {}, // Settings placeholder
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  text: messages[index]['text'],
                  isUser: messages[index]['isUser'],
                );
              },
            ),
          ),
          // Input Area
          Container(
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  offset: const Offset(0, -2),
                  blurRadius: 10,
                ),
              ],
            ),
             child: SafeArea(
               child: Column(
                mainAxisSize: MainAxisSize.min,
                 children: [
                   if (_selectedFile != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.description, color: Colors.white70, size: 20),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              _selectedFile!.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedFile = null;
                              });
                            },
                            child: const Icon(Icons.close, color: Colors.grey, size: 18),
                          ),
                        ],
                      ),
                    ),
                   Row(
                children: [
                  // Attachment Button
                  IconButton(
                    onPressed: _handleAttachment,
                    icon: const Icon(Icons.attach_file_rounded, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  // Text Input
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        onSubmitted: (_) => _handleSend(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Send Button
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _handleSend,
                      icon: const Icon(Icons.arrow_upward, color: Colors.white),
                    ),
                  ),
                ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}