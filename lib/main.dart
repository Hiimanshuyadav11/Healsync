import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://xlumogtgtojzsjuyghak.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhsdW1vZ3RndG9qenNqdXlnaGFrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjkzNTY4NTYsImV4cCI6MjA4NDkzMjg1Nn0.328rRoy3AhSgR292-CypNIcxmMramjXYVeERqfeu_DA",
  );

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
      home: AuthScreen(), 
    );
  }
}

