import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regístrese con Nosotros'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'SOLICITUD DE REGISTRO',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 9, 83, 221),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            // Campo para el Asunto
            buildLabel('Asunto'),
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(
                    child: Text('Servicio al cliente'),
                    value: 'Servicio al cliente'),
                DropdownMenuItem(
                    child: Text('Soporte técnico'), value: 'Soporte técnico'),
                DropdownMenuItem(child: Text('Ventas'), value: 'Ventas'),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Campo para el correo electrónico
            buildLabel('Dirección de correo electrónico'),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'su@email.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            // Campo para el archivo adjunto
            buildLabel('Archivo adjunto'),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'opcional',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Acción para seleccionar archivo
                  },
                  child: Text('SELECCIONAR ARCHIVO'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.black, // Cambia "primary" por "backgroundColor"
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Campo para el mensaje
            buildLabel('Mensaje'),
            TextFormField(
              decoration: InputDecoration(
                hintText: '¿Cómo podemos ayudarle?',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            // Botón de enviar
            ElevatedButton(
              onPressed: () {
                // Acción de enviar el formulario
              },
              child: Text('ENVIAR'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.redAccent, // Cambia "primary" por "backgroundColor"
                padding: EdgeInsets.symmetric(vertical: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
