import 'dart:convert';
import 'package:e_shop_flutter_app/core/db/database_helper.dart';
import 'package:e_shop_flutter_app/features/home/data/models/products_response.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteRepo {
  final DatabaseHelper _dbHelper;

  FavoriteRepo(this._dbHelper);

  /// Converts a Product object to a map suitable for SQL.
  /// This is where we ENCODE the categories list into a JSON string.
  Map<String, dynamic> _productToMap(Product product) {
    final map = product.toJson();
    // Convert the List<String> to a JSON string to store in a TEXT column
    map['categories'] = jsonEncode(product.categories);
    return map;
  }

  /// Converts a map from SQL to a Product object.
  /// This is where we DECODE the JSON string back into a categories list.
  Product _mapToProduct(Map<String, dynamic> map) {
    // Must make a mutable copy to modify it before fromJson
    final mutableMap = Map<String, dynamic>.from(map);
    final String categoriesJson = mutableMap['categories'] as String;
    final List<dynamic> categoryList = jsonDecode(categoriesJson);

    // Replace the string with the decoded list
    mutableMap['categories'] = categoryList.map((e) => e.toString()).toList();

    return Product.fromJson(mutableMap);
  }

  /// Adds a product to favorites.
  Future<void> addToFavorites(Product product) async {
    final db = await _dbHelper.database;
    final map = _productToMap(product);
    await db.insert(
      _dbHelper.tableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Removes a product from favorites using its ID.
  Future<void> removeFromFavorites(String productId) async {
    final db = await _dbHelper.database;
    await db.delete(
      _dbHelper.tableName,
      where: 'id = ?', // 'id' is the column name we set as PRIMARY KEY
      whereArgs: [productId],
    );
  }

  /// Checks if a specific product is already favorited.
  Future<bool> isFavorite(String productId) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _dbHelper.tableName,
      where: 'id = ?',
      whereArgs: [productId],
      limit: 1,
    );
    return maps.isNotEmpty;
  }

  /// Gets all favorite products from the database.
  Future<List<Product>> getFavorites() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(_dbHelper.tableName);

    if (maps.isEmpty) {
      return [];
    }

    // Convert each map back to a Product, handling the categories decoding
    return maps.map((map) => _mapToProduct(map)).toList();
  }
}
