import 'package:flutter/material.dart';

class DetalleProducto extends StatelessWidget {
  final Map<String, dynamic> producto;

  DetalleProducto({required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,  // Centrar el título
        title: Text(
          'Repuestos 24/7',  // El logo o nombre de la tienda
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black), // Color de los íconos del AppBar
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,  // Hacer que el Column se ajuste a sus hijos
          children: [
            // Imagen del producto
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Image.network(
                  producto['imagen'],  // URL de la imagen del producto
                  height: 250,
                  fit: BoxFit.contain,  // Asegura que la imagen mantenga su proporción
                ),
              ),
            ),
            Divider(),  // Línea divisoria para separar la imagen de los detalles

            // Información del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("Marca", producto['marca']),
                  _buildDetailRow("Modelo", producto['modelo']),
                  _buildDetailRow("Años", producto['años'].join(", ")),  // Unir años en una cadena
                  _buildDetailRow("Categoría", producto['categoria']),
                  _buildDetailRow("Subcategoría", producto['subcategoria']),

                  SizedBox(height: 10),  // Espaciado


                  // Precio del producto
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Precio",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${producto['precio']}',  // Mostrar el precio
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Descripción del producto
                  Text(
                    "Descripcion",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    producto['descripcion'] ?? 'No description available',  // Mostrar la descripción si está disponible
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),  // Espaciado adicional antes de los botones

            // Botones
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón "Add to Cart"
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción cuando se presiona "Agregar al carrito"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,  // Color del botón
                        padding: EdgeInsets.symmetric(vertical: 16),  // Ajustar el tamaño del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),  // Borde redondeado
                        ),
                      ),
                      child: Text(
                        "ADD TO CART",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),  // Espaciado entre botones
                  // Botón "Available at Shops"
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción cuando se presiona "Disponible en tiendas"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,  // Color del botón
                        padding: EdgeInsets.symmetric(vertical: 16),  // Ajustar el tamaño del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),  // Borde redondeado
                        ),
                      ),
                      child: Text(
                        "AVAILABLE AT SHOPS",
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
