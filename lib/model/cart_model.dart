// class CartModel {
//   CartModel({
//     this.name,
//     this.cartUId,
//     this.imageUrl,
//     this.price,
//   });

//   late final String? name;
//   late final String? cartUId;
//   late final int? price;
//   late final String? imageUrl;

//   CartModel.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     cartUId = json['cartUId'];
//     price = json['price'];
//     imageUrl = json['imageUrl'];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'cartUId': cartUId,
//       'price': price,
//       'imageUrl': imageUrl,
//     };
//   }
// }

// class ShopCart {
//   ShopCart({this.shopCart});
//   List<CartModel>? shopCart;
//   ShopCart.fromJson(Map<String, dynamic> json) {
//     shopCart = json['shopCart'];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'shopCart': shopCart,
//     };
//   }
// }
class CartModel {
  String? name;
  String? cartUId;
  int? price;
  String? imageUrl;

  CartModel({
    this.name,
    this.cartUId,
    this.imageUrl,
    this.price,
  });

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

class ShopCart {
  List<CartModel>? shopCart;

  ShopCart({this.shopCart});

  ShopCart.fromJson(Map<String, dynamic> json) {
    if (json['shopCart'] != null) {
      shopCart = List<CartModel>.from(
        json['shopCart'].map((item) => CartModel.fromJson(item)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'shopCart': shopCart?.map((item) => item.toJson()).toList(),
    };
  }
}
