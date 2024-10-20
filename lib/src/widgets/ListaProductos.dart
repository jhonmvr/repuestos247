import 'package:flutter/material.dart';
import 'package:project/src/model/mockups/ApiFake.dart';
import 'package:project/src/widgets/DetalleProducto.dart';
class ListaProductos extends StatefulWidget {
  @override
  _ListaProductosState createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  final ApiFake apiFake = ApiFake();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: apiFake.fetchProductos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> productos = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de productos por fila
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75, // Proporción entre ancho y alto
              ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Image.network(
                                producto['imagen'],
                                fit: BoxFit.contain,
                                height: 100, // Tamaño ajustado para la imagen
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            producto['nombre'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$${producto['precio'].toString()}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  '${producto['descuento'].toString()}% OFF',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: Text('No hay productos disponibles'));
        }
      },
    );
  }
}
