import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Use 10.0.2.2 for Android Emulator, localhost for iOS simulator
  // Since we are running on macos, localhost should work fine for iOS/macOS.
  // For Real Device, use your machine IP.
  static const String baseUrl = "http://localhost:5678/api"; 

  static Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> uploadFile(String? filePath, {List<int>? bytes, String? filename}) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));
    
    if (bytes != null && filename != null) {
      // Web Upload
      request.files.add(http.MultipartFile.fromBytes('pdf', bytes, filename: filename));
    } else if (filePath != null) {
      // Mobile Upload
      request.files.add(await http.MultipartFile.fromPath('pdf', filePath));
    } else {
      throw Exception("No file provided");
    }
    
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> sendMessage(String text) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    final response = await http.post(
      Uri.parse('$baseUrl/chat'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'message': text}),
    );
    return jsonDecode(response.body);
  }

  static Future<void> saveSession(String userId, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('token', token);
  }
}
