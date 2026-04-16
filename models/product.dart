class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;
  final int categoryId;
  final String size;
  final String color;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.categoryId,
    this.size = 'M',
    this.color = 'Black',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['img'] ?? '',
      description: json['des'] ?? '',
      categoryId: json['catId'] ?? 0,
      size: json['size'] ?? 'M',
      color: json['color'] ?? 'Black',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'description': description,
      'categoryId': categoryId,
      'size': size,
      'color': color,
    };
  }
}
