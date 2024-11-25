import 'package:flutter/material.dart';

import 'package:project/src/widgets/DetalleProducto.dart';

import '../../services/backend_service.dart';

class ListaProductos extends StatefulWidget {
  final String categoria;

  ListaProductos({required this.categoria});

  @override
  _ListaProductosState createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  final BackendService backendService = BackendService();
  late Future<List<dynamic>> _productosFuture;

  @override
  void initState() {
    super.initState();
    _productosFuture = backendService.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _productosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay productos disponibles.'));
        } else {
          final productos = snapshot.data!;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              final producto = productos[index];
              return ListTile(
                leading: Image.network(producto['imagen'], width: 50, height: 50, fit: BoxFit.cover),
                title: Text(producto['nombre']),
                subtitle: Text('\$${producto['precio']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleProducto(producto: producto),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
