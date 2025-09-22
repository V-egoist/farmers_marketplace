// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
// Fixed: The shared_preferences package must be added to pubspec.yaml for this import to work.
// TODO: Run 'flutter pub add shared_preferences' in your project root to resolve this error.
import 'package:shared_preferences/shared_preferences.dart';

// Your API base URL
const String _baseUrl = 'http://127.0.0.1:8000/api'; 

class AuthService {
  // Method to handle user registration
  Future<Map<String, dynamic>> register(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    return _processResponse(response);
  }

  // Method to handle user login
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    return _processResponse(response);
  }

  // Common method to process the API response and save the token
  Future<Map<String, dynamic>> _processResponse(http.Response response) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      return {'success': true, 'data': data};
    } else {
      return {'success': false, 'error': jsonDecode(response.body)};
    }
  }

  // Method to get the saved token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Method to log the user out
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}