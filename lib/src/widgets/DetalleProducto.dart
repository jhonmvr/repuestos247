import 'package:flutter/material.dart';
import '../../services/sqlite_service.dart';
import '../model/mockups/Product.dart';

class DetalleProducto extends StatelessWidget {
  final Map<String, dynamic> producto;

  DetalleProducto({required this.producto});

  final DatabaseService _databaseService = DatabaseService();

  Future<void> _addToCart(BuildContext context) async {
    try {
      // Crear un objeto Product a partir del producto actual
      final Product product = Product(
        id: producto['id'],
        name: producto['nombre'],
        price: producto['precio'],
        image: producto['imagen'],
        quantity: 1, // Por defecto agregar una unidad
      );

      // Verificar si el producto ya está en el carrito
      final existingProducts = await _databaseService.getProducts();
      final existingProduct = existingProducts.firstWhere(
            (p) => p.id == product.id,
        orElse: () => Product(
          id: 0,
          name: '',
          price: 0,
          image: '',
          quantity: 0,
        ),
      );

      if (existingProduct.id != 0) {
        // Si el producto ya existe, actualiza la cantidad
        await _databaseService.updateProductQuantity(
          product.id,
          existingProduct.quantity + 1,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cantidad actualizada en el carrito')),
        );
      } else {
        // Si el producto no existe, agrégalo al carrito
        await _databaseService.insertProduct(product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Producto agregado al carrito')),
        );
      }
    } catch (e) {
      print('Error al agregar al carrito: ${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al agregar al carrito: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Centrar el título
        title: Text(
          'Repuestos 24/7', // El logo o nombre de la tienda
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black), // Color de los íconos del AppBar
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // Hacer que el Column se ajuste a sus hijos
          children: [
            // Imagen del producto
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Image.network(
                  producto['imagen'], // URL de la imagen del producto
                  height: 250,
                  fit: BoxFit.contain, // Asegura que la imagen mantenga su proporción
                ),
              ),
            ),
            Divider(), // Línea divisoria para separar la imagen de los detalles

            // Información del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("Nombre", producto['nombre'] ?? "No disponible"),
                  _buildDetailRow("Marca", producto['marca'] ?? "No disponible"),
                  _buildDetailRow("Modelo", producto['modelo'] ?? "No disponible"),
                  _buildDetailRow(
                    "Categoría",
                    producto['categoria']?['nombre'] ?? "No disponible",
                  ),
                  _buildDetailRow(
                    "Subcategoría",
                    producto['subcategoria'] ?? "No disponible",
                  ),
                  SizedBox(height: 10), // Espaciado

                  // Precio del producto
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Precio",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${producto['precio'] ?? "No disponible"}', // Mostrar el precio
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Descripción del producto
                  Text(
                    "Descripción",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    producto['descripcion'] ?? 'No hay descripción disponible',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20), // Espaciado adicional antes de los botones

            // Botones
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _addToCart(context); // Llamar a la función para agregar al carrito
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent, // Color del botón
                        padding: EdgeInsets.symmetric(vertical: 16), // Ajustar el tamaño del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // Borde redondeado
                        ),
                      ),
                      child: Text(
                        "AGREGAR AL CARRITO",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función para construir cada fila de detalle con clave: valor
  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
