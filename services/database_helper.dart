import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/category.dart';
import '../models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('clothes_shop.db');
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

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        image TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        image TEXT NOT NULL,
        description TEXT,
        categoryId INTEGER,
        size TEXT,
        color TEXT,
        FOREIGN KEY (categoryId) REFERENCES categories (id)
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  Future _insertSampleData(Database db) async {
    // Categories
    await db.insert('categories', {'name': 'Áo', 'image': 'shirt_white.jpg'});
    await db.insert('categories', {'name': 'Quần', 'image': 'jean_blue.jpg'});
    await db.insert('categories', {'name': 'Váy', 'image': 'dress_flower.jpg'});
    await db.insert('categories', {'name': 'Phụ kiện', 'image': 'accessory.jpg'});

    // Products
    await db.insert('products', {
      'name': 'Áo sơ mi trắng',
      'price': 350000,
      'image': 'shirt_white.jpg',
      'description': 'Áo sơ mi trắng thanh lịch',
      'categoryId': 1,
      'size': 'M',
      'color': 'Trắng'
    });
    await db.insert('products', {
      'name': 'Quần jean xanh',
      'price': 450000,
      'image': 'jean_blue.jpg',
      'description': 'Quần jean xanh trẻ trung',
      'categoryId': 2,
      'size': 'L',
      'color': 'Xanh'
    });
    await db.insert('products', {
      'name': 'Váy hoa',
      'price': 550000,
      'image': 'dress_flower.jpg',
      'description': 'Váy hoa nhẹ nhàng',
      'categoryId': 3,
      'size': 'S',
      'color': 'Hồng'
    });
    await db.insert('products', {
      'name': 'Thắt lưng da',
      'price': 150000,
      'image': 'accessory.jpg',
      'description': 'Thắt lưng da bò thật',
      'categoryId': 4,
      'size': 'One Size',
      'color': 'Đen'
    });
  }

  // CRUD Categories
  Future<int> insertCategory(Category category) async {
    final db = await instance.database;
    return await db.insert('categories', category.toMap());
  }

  Future<List<Category>> getAllCategories() async {
    final db = await instance.database;
    final result = await db.query('categories');
    return result.map((json) => Category(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
    )).toList();
  }

  Future<int> updateCategory(Category category) async {
    final db = await instance.database;
    return await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<int> deleteCategory(int id) async {
    final db = await instance.database;
    return await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // CRUD Products
  Future<int> insertProduct(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getAllProducts() async {
    final db = await instance.database;
    final result = await db.query('products');
    return result.map((json) => Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as double,
      image: json['image'] as String,
      description: json['description'] as String? ?? '',
      categoryId: json['categoryId'] as int,
      size: json['size'] as String? ?? 'M',
      color: json['color'] as String? ?? 'Black',
    )).toList();
  }

  Future<List<Product>> getProductsByCategory(int categoryId) async {
    final db = await instance.database;
    final result = await db.query(
      'products',
      where: 'categoryId = ?',
      whereArgs: [categoryId],
    );
    return result.map((json) => Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as double,
      image: json['image'] as String,
      description: json['description'] as String? ?? '',
      categoryId: json['categoryId'] as int,
      size: json['size'] as String? ?? 'M',
      color: json['color'] as String? ?? 'Black',
    )).toList();
  }

  Future<int> updateProduct(Product product) async {
    final db = await instance.database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
