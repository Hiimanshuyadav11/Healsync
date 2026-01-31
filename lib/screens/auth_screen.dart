import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'chat_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;

  Future<void> _submit() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      Map<String, dynamic> res;
      if (_isLogin) {
        res = await ApiService.login(email, password);
      } else {
        res = await ApiService.register(email, password);
      }

      if (res.containsKey('token')) {
         await ApiService.saveSession("user_${email.hashCode}", res['token']);
         
         if (!mounted) return;
         Navigator.pushReplacement(
           context, 
           MaterialPageRoute(builder: (_) => const ChatScreen())
         );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $res')));
      }

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_isLogin ? 'Login' : 'Register', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text(_isLogin ? 'Login' : 'Register')),
            TextButton(
              onPressed: () => setState(() => _isLogin = !_isLogin),
              child: Text(_isLogin ? 'Create Account' : 'Have Account? Login'),
            )
          ],
        ),
      ),
    );
  }
}
