import 'dart:convert';
import 'package:http/http.dart' as http;

import '../src/config/conf.dart';

class AuthService {
  final String baseUrl = Conf.API_URL;


  Future<void> login(Map<String, dynamic> credentials) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(credentials),
    );

    if (response.statusCode == 200) {
      print('Login exitoso');
    } else if (response.statusCode == 401) {
      throw Exception('Credenciales incorrectas');
    } else {
      throw Exception('Error al intentar iniciar sesión');
    }
  }
}
