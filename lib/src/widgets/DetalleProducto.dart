import 'package:flutter/material.dart';

class DetalleProducto extends StatelessWidget {
  final Map<String, dynamic> producto;

  DetalleProducto({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(producto['nombre']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                producto['imagen'], // Mostrar imagen del producto
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            Text(
              producto['nombre'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Precio: \$${producto['precio']}'),
            SizedBox(height: 5),
            Text('Descuento: ${producto['descuento']}%'),
            SizedBox(height: 15),
            Text(
              'Descripción:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              producto['descripcion'],
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
