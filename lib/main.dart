import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const HealSyncApp());
}

class HealSyncApp extends StatelessWidget {
  const HealSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HealSync',
      theme: ThemeData.dark(useMaterial3: true),
      home: ChatScreen(), 
    );
  }
}

