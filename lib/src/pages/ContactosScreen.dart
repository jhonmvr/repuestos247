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
            phoneNumbers: [
              '04-220 33 33',
              '04-221 22 22'
            ], // Ejemplo de números
            whatsappNumbers: [
              '0998 777 888',
              '0999 555 444'
            ], // Ejemplo de WhatsApp
            email: 'guayaquil@repuestos247.com',
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatefulWidget {
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
  _ContactSectionState createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isExpanded = false; // Para controlar el estado de la expansión

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded; // Cambiar el estado al tocar
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500), // Duración de la animación
        curve: Curves.easeInOut, // Curva de la animación
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: _isExpanded ? Colors.red[50] : Colors.white, // Cambio de color
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Sombra para darle profundidad
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
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
                    widget.address,
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
                    children: widget.phoneNumbers
                        .map((number) =>
                            Text(number, style: TextStyle(fontSize: 16)))
                        .toList(),
                  ),
                ),
              ],
            ),
            if (_isExpanded) ...[
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.whatsappNumbers
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
                      widget.email,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
