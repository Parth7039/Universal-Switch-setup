import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminService {
  final String baseUrl = 'http://192.168.67.198:5001/admin-login';

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      // Print the status code and response body
      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');


      if (response.statusCode == 200) {
        // Login successful, return the response body
        return jsonDecode(response.body);
      } else {
        // Handle errors, e.g., invalid credentials
        return {
          'error': 'Invalid username or password',
        };
      }
    } catch (e) {
      // Handle network or other errors
      return {
        'error': 'An error occurred: ${e.toString()}',
      };
    }
  }
}
