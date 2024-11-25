import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../src/model/mockups/Product.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'shopping_cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        image TEXT,
        quantity INTEGER NOT NULL
      )
      ''',
    );
  }

  // Insertar un producto en la base de datos
  Future<void> insertProduct(Product product) async {
    final db = await _databaseService.database;
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Obtener todos los productos del carrito
  Future<List<Product>> getProducts() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return maps.map((map) => Product.fromMap(map)).toList();
  }

  // Actualizar la cantidad de un producto
  Future<void> updateProductQuantity(int id, int quantity) async {
    final db = await _databaseService.database;
    await db.update(
      'products',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Eliminar un producto del carrito
  Future<void> deleteProduct(int id) async {
    final db = await _databaseService.database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Vaciar el carrito
  Future<void> clearCart() async {
    final db = await _databaseService.database;
    await db.delete('products');
  }
}
