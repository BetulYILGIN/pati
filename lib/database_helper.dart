import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Kullanıcı modelini tanımlıyoruz
class User {
  final String patiAdi;
  final String parola;

  User({required this.patiAdi, required this.parola});

  Map<String, dynamic> toMap() {
    return {
      'patiAdi': patiAdi,
      'parola': parola,
    };
  }
}

// Veritabanı sınıfı
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  // Veritabanını başlatma
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Veritabanı dosyasını oluşturma
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_data.db');
    return openDatabase(path, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE users(patiAdi TEXT, parola TEXT)',
      );
    }, version: 1);
  }

  // Kullanıcı bilgilerini veritabanına kaydetme
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Veritabanından tüm kullanıcıları çekme
  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User(
        patiAdi: maps[i]['patiAdi'],
        parola: maps[i]['parola'],
      );
    });
  }
}
