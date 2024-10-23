import 'dart:convert';
import 'package:flutter/services.dart';

class ApiFake {
  // Método que simula la llamada a un servicio web leyendo un archivo JSON local
  Future<List<Map<String, dynamic>>> fetchProductos(String categoria) async {
    // Leer el archivo JSON desde la carpeta assets
    String jsonString = await rootBundle.loadString('assets/listaItems.json');

    // Convertir la respuesta JSON en una lista de mapas
    List<dynamic> data = json.decode(jsonString);

    // Convertir la lista dinámica en una lista de mapas
    List<Map<String, dynamic>> productos = List<Map<String, dynamic>>.from(data);

    // Filtrar productos por categoría
    List<Map<String, dynamic>> filteredProductos = productos.where((producto) {
      return producto['categoria'] == categoria;
    }).toList();

    return filteredProductos;
  }

  // Método que simula la llamada a un servicio web leyendo un archivo JSON local
  Future<List<Map<String, dynamic>>> fetchCategorias() async {
    // Leer el archivo JSON desde la carpeta assets
    String jsonString = await rootBundle.loadString('assets/listaCategorias.json');

    // Convertir la respuesta JSON en una lista de mapas
    List<dynamic> data = json.decode(jsonString);
    return List<Map<String, dynamic>>.from(data);
  }
}
