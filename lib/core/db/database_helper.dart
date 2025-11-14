import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  static const String _dbName = 'eshop.db';
  static const String _tableName = 'favorites';
  static const int _dbVersion = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // This SQL statement creates the table.
  // We use TEXT for the 'categories' list and store it as a JSON string.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        productCode TEXT,
        name TEXT,
        description TEXT,
        arabicName TEXT,
        arabicDescription TEXT,
        coverPictureUrl TEXT,
        price REAL,
        stock INTEGER,
        weight REAL,
        color TEXT,
        rating REAL,
        reviewsCount INTEGER,
        discountPercentage REAL,
        sellerId TEXT,
        categories TEXT
      )
    ''');
  }

  // A helper method to get the table name
  String get tableName => _tableName;
}
