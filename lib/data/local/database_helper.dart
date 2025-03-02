import 'package:sqflite/sqflite.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import '../models/book_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  final tableName = 'favorites';

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('books.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id TEXT PRIMARY KEY,
        title TEXT,
        authors TEXT,
        thumbnail TEXT
      )
    ''');
  }

  Future<List<FavoriteBook>> getFavorites() async {
    final db = await instance.database;
    final maps = await db.query(tableName);
    return maps.map((json) {
      return FavoriteBook.fromJson(json);
    }).toList();
  }

  Future<void> toggleFavorite(BookModel book) async {
    final db = await instance.database;
    final exists = await db.query(
      tableName,
      where: 'id = ?',
      whereArgs: [book.id],
    );

    if (exists.isEmpty) {
      await db.insert(tableName, book.toJson());
    } else {
      await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [book.id],
      );
    }
  }
}
