import 'dart:convert';
import 'package:http/http.dart' as http;

class BackendService {
  final String baseUrl = 'http://localhost:8080/api';

  // Get all products
  Future<List<dynamic>> getAllProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/productos'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Get a product by ID
  Future<dynamic> getProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/productos/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load product with ID $id');
    }
  }

  // Create a new product
  Future<void> createProduct(Map<String, dynamic> product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/productos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create product');
    }
  }

  // Update a product
  Future<void> updateProduct(int id, Map<String, dynamic> product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/productos/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product with ID $id');
    }
  }

  // Delete a product by ID
  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/productos/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete product with ID $id');
    }
  }
}
