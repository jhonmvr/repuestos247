import 'dart:convert';
import 'package:flutter/services.dart';

class ApiFake {
  // Método que simula la llamada a un servicio web leyendo un archivo JSON local
  Future<List<Map<String, dynamic>>> fetchProductos() async {
    // Leer el archivo JSON desde la carpeta assets
    String jsonString = await rootBundle.loadString('assets/listaItems.json');

    // Convertir la respuesta JSON en una lista de mapas
    List<dynamic> data = json.decode(jsonString);
    return List<Map<String, dynamic>>.from(data);
  }
}
