import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo blanco en lugar de imagen
      backgroundColor: Colors.white,
      body: Center(  // Aseguramos que todo esté centrado
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Centrar los elementos verticalmente
          children: [
            // Logo "Repuestos 24/7"
            Image.asset(
              'assets/logo_repuestos.png', // Asegúrate de colocar la imagen del logo en la carpeta assets
              width: 300, // Ajusta el tamaño según sea necesario
            ),
            SizedBox(height: 20),
            // Botón circular
            ElevatedButton(
              onPressed: () {
                // Navega a la ruta '/'
                Navigator.pushNamed(context, '/');
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                elevation: 5,
              ),
              child: Icon(
                Icons.arrow_forward, // Ícono de la flecha
                color: Colors.black,
                size: 30,
              ),
            ),
            SizedBox(height: 20),
            // Texto pequeño "Powered by"
            Text(
              'Powered by RepuestosApp',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
