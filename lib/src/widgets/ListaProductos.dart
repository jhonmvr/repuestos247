import 'package:flutter/material.dart';
import 'package:project/src/model/mockups/ApiFake.dart';
import 'package:project/src/widgets/DetalleProducto.dart';

class ListaProductos extends StatefulWidget {
  @override
  _ListaProductosState createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  final ApiFake apiFake = ApiFake(); // Instancia de ApiFake

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: apiFake.fetchProductos(), // Leer el archivo JSON
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Muestra un indicador de carga
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Muestra el error
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> productos = snapshot.data!;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context, index) {
              var producto = productos[index];
              return GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de detalles cuando se selecciona una tarjeta
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalleProducto(producto: producto),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            producto['imagen'], // Mostrar imagen del producto
                            height: 200,
                          ),
                        ),
                        Text(
                          producto['nombre'],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('Precio: \$${producto['precio'].toString()}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text('No hay productos disponibles'));
        }
      },
    );
  }
}
