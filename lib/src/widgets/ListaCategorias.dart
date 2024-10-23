import 'package:flutter/material.dart';
import 'package:project/src/model/mockups/ApiFake.dart';
import 'package:project/src/widgets/DetalleProducto.dart';
import 'package:project/src/widgets/ListaProductos.dart';
class ListaCategorias extends StatefulWidget {
  @override
  _ListaCategoriasState createState() => _ListaCategoriasState();

}

class _ListaCategoriasState extends State<ListaCategorias> {
  final ApiFake apiFake = ApiFake();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: apiFake.fetchCategorias(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<Map<String, dynamic>> Categorias = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Número de Categorias por fila
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75, // Proporción entre ancho y alto
              ),
              itemCount: Categorias.length,
              itemBuilder: (context, index) {
                var categoria = Categorias[index];
                return GestureDetector(
                  onTap: () {
                    // Navegar a la pantalla de detalles cuando se selecciona una tarjeta
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListaProductos(categoria: categoria['nombre']),
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
                                categoria['imagen'],
                                fit: BoxFit.contain,
                                height: 100, // Tamaño ajustado para la imagen
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            categoria['nombre'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(child: Text('No hay Categorias disponibles'));
        }
      },
    );
  }
}
