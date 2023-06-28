class CartModel {
  CartModel({this.name, this.cartUId, this.imageUrl, this.price});

  late final String? name;
  late final String? cartUId;
  late final int? price;
  late final String? imageUrl;

  CartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cartUId = json['cartUId'];
    price = json['price'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cartUId': cartUId,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
