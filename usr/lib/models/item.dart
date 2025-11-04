class Item {
  String id;
  String name;
  double wholesalePrice;
  double sellingPrice;

  Item({
    required this.id,
    required this.name,
    required this.wholesalePrice,
    required this.sellingPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'wholesalePrice': wholesalePrice,
      'sellingPrice': sellingPrice,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      wholesalePrice: map['wholesalePrice'],
      sellingPrice: map['sellingPrice'],
    );
  }
}
