import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/category.dart';
import '../models/product.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Categories
  CollectionReference get _categoriesRef => _firestore.collection('categories');
  CollectionReference get _productsRef => _firestore.collection('products');

  // CRUD Categories
  Future<void> addCategory(Category category) async {
    await _categoriesRef.add({
      'name': category.name,
      'image': category.image,
    });
  }

  Stream<List<Category>> getCategories() {
    return _categoriesRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Category(
          id: int.tryParse(doc.id) ?? 0,
          name: doc['name'],
          image: doc['image'],
        );
      }).toList();
    });
  }

  Future<void> updateCategory(String docId, Category category) async {
    await _categoriesRef.doc(docId).update({
      'name': category.name,
      'image': category.image,
    });
  }

  Future<void> deleteCategory(String docId) async {
    await _categoriesRef.doc(docId).delete();
  }

  // CRUD Products
  Future<void> addProduct(Product product) async {
    await _productsRef.add({
      'name': product.name,
      'price': product.price,
      'image': product.image,
      'description': product.description,
      'categoryId': product.categoryId,
      'size': product.size,
      'color': product.color,
    });
  }

  Stream<List<Product>> getProducts() {
    return _productsRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product(
          id: int.tryParse(doc.id) ?? 0,
          name: doc['name'],
          price: doc['price'].toDouble(),
          image: doc['image'],
          description: doc['description'],
          categoryId: doc['categoryId'],
          size: doc['size'] ?? 'M',
          color: doc['color'] ?? 'Black',
        );
      }).toList();
    });
  }

  Future<void> updateProduct(String docId, Product product) async {
    await _productsRef.doc(docId).update({
      'name': product.name,
      'price': product.price,
      'image': product.image,
      'description': product.description,
      'categoryId': product.categoryId,
      'size': product.size,
      'color': product.color,
    });
  }

  Future<void> deleteProduct(String docId) async {
    await _productsRef.doc(docId).delete();
  }
}
