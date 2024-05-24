import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:silangka/presentation/models/animals_model.dart';

class DatabaseHelper {
  final String _databaseName = 'database_report.db';
  final int _databaseVersion = 5;

  final String table = 'report';
  final String id = 'id';
  final String title = 'title';
  final String location = 'location';
  final String animalCount = 'animalCount';
  final String image = 'image';
  final String desc = 'desc';
  final String categoryId = 'categoryId';
  final String status = 'status';

  Database? _database;

  Future<Database> database() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    print('Database path: $path');
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $title TEXT, $location TEXT, $animalCount TEXT, $image FILE, $categoryId INTEGER, $desc TEXT, $status TEXT)',
    );
    await db.execute(
      'CREATE TABLE categories (id INTEGER PRIMARY KEY, name TEXT, latinName TEXT, distribution TEXT, characteristics TEXT, habitat TEXT, foodType TEXT, uniqueBehavior TEXT, gestationPeriod TEXT, imageUrl TEXT, estimationAmounts TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> all() async {
    final db = await database();
    final data = await db.query(table);

    // print('Query result: $data');
    return data;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await database();
    final query = await db.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
    print('Inserted Row: $row with id: $query');
    return query;
  }

  Future<void> insertCategories(List<Animal> categories) async {
    final db = await database();
    for (Animal category in categories) {
      Map<String, dynamic> categoryMap = category.toMap();
      categoryMap.remove('estimationAmounts'); // Menghapus kunci 'estimationAmounts'
      categoryMap['estimationAmounts'] = null; // Menetapkan nilainya menjadi null
      await db.insert('categories', categoryMap);
    }
    print(categories);
  }

  Future<List<Animal>> getCategories() async {
    final db = await database();
    final List<Map<String, dynamic>> data = await db.query('categories');
    return data.map((map) => Animal.fromJson(map)).toList();
  }
}
