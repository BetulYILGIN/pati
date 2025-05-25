import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for utf8

class User { // Basit bir User modeli, şimdilik burada tanımlayalım.
  final int? id;
  final String email;
  final String password; // Bu, hash'lenmemiş şifre olacak (insertUser'a verilirken)
  final String userType;

  User({this.id, required this.email, required this.password, required this.userType});

  Map<String, dynamic> toMap() {
    // id null ise map'e eklenmemeli (AUTOINCREMENT için)
    Map<String, dynamic> map = {
      'email': email,
      'password': password, // Bu, DatabaseHelper içinde hash'lenecek
      'user_type': userType,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Veritabanından okurken kullanılacak factory constructor
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      password: map['password'], // Bu, veritabanındaki hash'lenmiş şifre olacak
      userType: map['user_type'],
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'pati_check.db'); // Veritabanı adı
    print('Database path: $path'); // Log the database path
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        user_type TEXT NOT NULL 
      )
    ''');
    print("Users table created successfully");
  }

  // Yeni kullanıcı ekleme (şifreyi hash'leyerek)
  Future<int> insertUser(User user) async {
    final db = await database;
    var bytes = utf8.encode(user.password); // Şifreyi byte'lara çevir
    var digest = sha256.convert(bytes);    // SHA-256 ile hash'le
    String hashedPassword = digest.toString(); // Hash'i string'e çevir

    // toMap() metodu password'ü hash'lenmemiş haliyle döndüreceği için
    // burada manuel olarak map oluşturuyoruz.
    Map<String, dynamic> userMap = {
      'email': user.email,
      'password': hashedPassword, // Hash'lenmiş şifre
      'user_type': user.userType,
    };
     if (user.id != null) { // Eğer User nesnesinde id varsa (güncelleme senaryosu için?)
      userMap['id'] = user.id;
    }
    // conflictAlgorithm.replace: Eğer aynı email ile bir kullanıcı varsa üzerine yazar.
    // Genellikle UNIQUE constraint hatası almak ve kullanıcıyı bilgilendirmek daha iyi olabilir.
    // Şimdilik replace kullanıyoruz, isteğe bağlı olarak .ignore veya .fail seçilebilir.
    return await db.insert('users', userMap, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Giriş için kullanıcı sorgulama
  Future<User?> loginUser(String email, String password) async {
    final db = await database;
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    String hashedPassword = digest.toString();

    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, hashedPassword],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // E-postaya göre kullanıcı getirme (opsiyonel, e-posta kontrolü için vb.)
  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}
