import 'dart:io';
import 'package:silangka/presentation/models/report_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

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
      'CREATE TABLE $table ($id INTEGER PRIMARY KEY, $title TEXT, $location TEXT, $animalCount TEXT, $image FILE, $categoryId INTEGER, $desc TEXT)',
    );
  }

  Future<List<Report>> all() async {
    final db = await database();
    final data = await db.query(table);
    print('Query result: $data');
    List<Report> result = data.map((e) => Report.fromJson(e)).toList();
    return result;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    final db = await database();
    final query = await db.insert(table, row);
    print('Inserted Row: $row with id: $query');
    return query;
  }
}
