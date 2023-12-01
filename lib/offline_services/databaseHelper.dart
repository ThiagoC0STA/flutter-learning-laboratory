import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'taskOffline.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  late Database _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    _database = await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        completed INTEGER
      )
    ''');
  }

  Future<int> insertTask(Task task) async {
    await _initDatabase();
    Database db = _database;
    return await db.insert('tasks', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getTasks() async {
    await _initDatabase(); // Garante que o banco de dados foi inicializado
    Database db = _database;
    List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (index) {
      return Task.fromMap(maps[index]);
    });
  }

  Future<Database> get database async {
    await _initDatabase(); // Garante que o banco de dados foi inicializado
    return _database;
  }
}
