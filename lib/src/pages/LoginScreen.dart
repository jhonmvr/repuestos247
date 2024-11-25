import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para manejar la serialización JSON
import 'package:project/src/pages/WelcomeScreen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Método para iniciar sesión usando el API
  Future<void> _login(BuildContext context) async {
    try {
      final String username = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      // URL del endpoint del API
      final String apiUrl = "http://localhost:8080/api/auth/login";

      // Realizar la solicitud POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "username": username,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        // Inicio de sesión exitoso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inicio de sesión exitoso')),
        );

        // Navegar a la pantalla de bienvenida
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      } else if (response.statusCode == 401) {
        // Credenciales incorrectas
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Contraseña incorrecta')),
        );
      } else {
        // Otros errores
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error inesperado: ${response.body}')),
        );
      }
    } catch (e) {
      // Manejo de errores generales
      print('Error: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inesperado: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresar'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/logo_repuestos.png', height: 100), // Imagen del logo
            SizedBox(height: 20),
            Text(
              "Bienvenido de nuevo",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Usuario',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Lógica para la recuperación de contraseña (puedes agregar esto más tarde)
              },
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
