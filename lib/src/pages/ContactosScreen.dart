import 'package:flutter/material.dart';

class ContactosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contactos'),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Matriz Quito Section
          ContactSection(
            title: 'Matriz Quito',
            address: 'De las Hortencias E9-41 y Av. 6 de Diciembre',
            phoneNumbers: ['02-240 40 40', '02-241 01 63'],
            whatsappNumbers: ['0962 301 257', '0962 303 380', '0961 808 080'],
            email: 'comercial@repuestos247.com',
          ),
          SizedBox(height: 20),
          // Sucursal Guayaquil Section
          ContactSection(
            title: 'Sucursal Guayaquil',
            address: 'Dirección de Sucursal Guayaquil',
            phoneNumbers: ['04-220 33 33', '04-221 22 22'], // Example numbers
            whatsappNumbers: [
              '0998 777 888',
              '0999 555 444'
            ], // Example WhatsApp numbers
            email: 'guayaquil@repuestos247.com',
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  final String title;
  final String address;
  final List<String> phoneNumbers;
  final List<String> whatsappNumbers;
  final String email;

  ContactSection({
    required this.title,
    required this.address,
    required this.phoneNumbers,
    required this.whatsappNumbers,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red[700]),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.red[700]),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: phoneNumbers
                        .map((number) =>
                            Text(number, style: TextStyle(fontSize: 16)))
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                // Icon(Icons.whatsapp, color: Colors.green),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: whatsappNumbers
                        .map((number) =>
                            Text(number, style: TextStyle(fontSize: 16)))
                        .toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.email, color: Colors.red[700]),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    email,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
