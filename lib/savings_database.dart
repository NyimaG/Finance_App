import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'savingclass.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('savings.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        targetAmount INTEGER,
        savedAmount INTEGER
      )
    ''');
  }

  Future<int> saveGoal(SavingsGoal goal) async {
    final db = await database;
    if (goal.id == null) {
      // Insert new goal
      return await db.insert('goals', goal.toMap());
    } else {
      // Update existing goal
      return await db.update(
        'goals',
        goal.toMap(),
        where: 'id = ?',
        whereArgs: [goal.id],
      );
    }
  }

  Future<List<SavingsGoal>> getGoals() async {
    final db = await database;
    final result = await db.query('goals');

    return result.map((json) => SavingsGoal.fromMap(json)).toList();
  }

  Future<int> deleteGoal(int id) async {
    final db = await database;
    return await db.delete('goals', where: 'id = ?', whereArgs: [id]);
  }
}
