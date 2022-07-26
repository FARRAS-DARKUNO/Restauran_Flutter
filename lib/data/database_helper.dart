import 'package:restauran_app_revisi/model/home_detail_data/home_restoran.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
  static const String _tblBookmark = 'bookmarks';

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/newsapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblBookmark(
            id TEXT PRIMARY KEY,
            name TEXT,
            description TEXT,
            pictureId TEXT,
            city TEXT,
            rating REAL
        )''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  // Metode untuk menyimpan data
  Future<void> insertBookmark(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblBookmark, restaurant.toJson());
  }

  // Mendapatkan seluruh data bookmark yang tersimpan
  Future<List<Restaurant>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(_tblBookmark);

    return result.map((res) => Restaurant.fromJson(res)).toList();
  }

  // Mencari bookmark yang disimpan berdasarkan ur
  Future<Map> getBookmarkByID(String id) async {
    final db = await database;

    List<Map<String, dynamic>> result = await db!.query(
      _tblBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
    }
  }

  //Menghapus data bookmark berdasarkan url
  Future<void> removeBookmark(String id) async {
    final db = await database;
    await db!.delete(
      _tblBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
