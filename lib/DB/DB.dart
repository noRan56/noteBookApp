import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/models/node.dart';

class DB {
  static final DB _instance = DB._internal();
  factory DB() => _instance;
  static Database? _database;

  static const _notesTableName = 'notes';
  static const _usersTableName = 'users';

  DB._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_notesTableName (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        createdAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $_usersTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        phone_number TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  // Note-related methods
  Future<void> insertNote({required Note note}) async {
    final db = await database;
    await db.insert(
      _notesTableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_notesTableName);

    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'] as int,
        title: maps[i]['title'] as String,
        description: maps[i]['description'] as String,
        createdAt: DateTime.parse(maps[i]['createdAt']),
      );
    });
  }

  Future<void> updateNote({required Note note}) async {
    final db = await database;
    await db.update(
      _notesTableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote({required Note note}) async {
    final db = await database;
    await db.delete(
      _notesTableName,
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  // User-related methods
  Future<int> registerUser(String username, String email, String phoneNumber,
      String password) async {
    final db = await database;
    return await db.insert(_usersTableName, {
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'password': password,
    });
  }

  Future<Map<String, dynamic>?> authenticateUser(
      String username, String password) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      _usersTableName,
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
