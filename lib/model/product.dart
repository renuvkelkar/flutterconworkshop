class ProductModel {
  ProductModel({
    String? id,
    String? name,
    String? desc,
    int? price,
    String? imageUrl,
    String? cat_name,
  });

  late final String? name;
  late final String? id;
  late final String? desc;
  late final int? price;
  late final String? imageUrl;
  late final String? cat_name;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    price = json['price'];
    imageUrl = json['imageUrl'];
    cat_name = json['cat_name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'price': price,
      'imageUrl': imageUrl,
      'cat_name': cat_name,
    };
  }
}
