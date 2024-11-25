import 'package:flutter/material.dart';
import '../../services/sqlite_service.dart';
import '../model/mockups/Product.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DatabaseService _databaseService = DatabaseService();
  late Future<List<Product>> _cartProducts;

  @override
  void initState() {
    super.initState();
    _cartProducts = _databaseService.getProducts(); // Obtener productos al iniciar
  }

  Future<void> _refreshCart() async {
    setState(() {
      _cartProducts = _databaseService.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<List<Product>>(
        future: _cartProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('El carrito está vacío.'));
          } else {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cantidad: ${product.quantity}'),
                        Text('Precio: \$${product.price.toStringAsFixed(2)}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        await _databaseService.deleteProduct(product.id);
                        _refreshCart(); // Refrescar lista después de eliminar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Producto eliminado del carrito')),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            // Vaciar el carrito
            await _databaseService.clearCart();
            _refreshCart(); // Refrescar la lista después de vaciar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('El carrito ha sido vaciado')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'VACIAR CARRITO',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
