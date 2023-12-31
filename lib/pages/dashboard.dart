import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterconworkshop/model/cart_model.dart';
import 'package:flutterconworkshop/model/category.dart';
import 'package:flutterconworkshop/model/product.dart';
import 'package:flutterconworkshop/pages/cartpage.dart';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  DashBoard(this.userId, {super.key});
  final String userId;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  //final response = await http.get("https://us-central1-fluttercon-workshop.cloudfunctions.net/ext-firestore-bundle-builder-serve/icecreams" as Uri);
  final ref = FirebaseFirestore.instance
      .collection('products')
      .withConverter<ProductModel>(
        fromFirestore: (snapshot, _) => ProductModel.fromJson(
          snapshot.data()!,
        ),
        toFirestore: (model, _) => model.toJson(),
      );

  getBundle() async {
    final res = await http.get(Uri.parse(
        "https://us-central1-fluttercon-workshop.cloudfunctions.net/ext-firestore-bundle-builder-serve/icecreams"));
    FirebaseFirestore.instance.loadBundle(res.bodyBytes).stream.listen((event) {
      if (event.bytesLoaded == event.totalBytes) {
        print("Completed ");
        getProducts();
      }
    });
  }

  Future<QuerySnapshot> getDataFromServerFirestore() {
    return FirebaseFirestore.instance.collection("products").get();
  }

  Future<QuerySnapshot> getDataFromCacheFirestore() {
    return FirebaseFirestore.instance
        .collection("products")
        .get(const GetOptions(source: Source.cache));
  }

  DateTime dateTime = DateTime(2023, 07, 03, 19, 56);

  List productList = [];
  getProducts() async {
    QuerySnapshot data;
    if (DateTime.now().minute - dateTime.minute > 5) {
      print("Getting from Server");
      data = await getDataFromServerFirestore();
    } else {
      data = await getDataFromCacheFirestore();
      print("Getting from Cache");
    }

    setState(() {});
    productList = data.docs.map((e) => e.data()).toList();

    print(productList.length);
  }

  final catRef =
      FirebaseFirestore.instance.collection('category').withConverter<CatModel>(
            fromFirestore: (snapshot, _) => CatModel.fromJson(
              snapshot.data()!,
            ),
            toFirestore: (model, _) => model.toJson(),
          );

  final cartRef = FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .withConverter<ShopCart>(
        fromFirestore: (snapshot, _) => ShopCart.fromJson(
          snapshot.data()!,
        ),
        toFirestore: (model, _) => model.toJson(),
      );
  List<CartModel> shoppinCart = [];
  String? currentCatName;
  String? productName;
  int? price;
  String? imageUrl;

  addToCart() {
    ShopCart shopCart = ShopCart(shopCart: shoppinCart);
    CartModel cartData = CartModel(
        name: productName,
        cartUId: widget.userId,
        price: price,
        imageUrl: imageUrl);
    shoppinCart.add(cartData);
    // ShopCart shopCart = ShopCart(shopCart: shoppinCart);
    cartRef.set(shopCart);
  }

  @override
  void initState() {
    fetchCartData();
    getBundle();
    super.initState();
  }

  void fetchCartData() async {
    final snapshot = await cartRef.get();

    if (snapshot.exists) {
      final ShopCart shopCart = snapshot.data()!;
      if (shopCart.shopCart != null) {
        shoppinCart = shopCart.shopCart!;
      }
    }
  }

  // addToCart() {
  //   CartModel cartData = CartModel(
  //       name: productName,
  //       cartUId: widget.userId,
  //       price: price,
  //       imageUrl: imageUrl);
  //   shoppinCart.add(cartData);
  //   setState(() {
  //     cartRef.add();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ice Cream flavours "),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 25,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CartPage(userId: widget.userId)));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot<ProductModel>?>(
          stream: currentCatName != "all"
              ? ref.where("cat_name", isEqualTo: currentCatName).snapshots()
              : ref.snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            print("data");
            print(snapshot.data.toString);
            if (snapshot.hasData) {
              final snapshotData = snapshot.data;
              return Container(
                color: Color.fromARGB(255, 238, 235, 223),
                child: Column(
                  children: [
                    Image.network(
                        "https://img.freepik.com/free-vector/nice-blue-background-hand-drawn-ice-cream_23-2147635708.jpg?w=1380&t=st=1687971273~exp=1687971873~hmac=94a295650ce4777c8a640ecfff7ad43f74244b382d4509b44440fdb5d7067ff1"),
                    Container(
                      height: 60,
                      width: double.infinity,
                      child: StreamBuilder<QuerySnapshot<CatModel>?>(
                          stream: catRef.snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              final snapshotData = snapshot.data;
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final catData =
                                        snapshotData.docs[index].data();
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentCatName = catData.name;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 234, 122, 165),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                catData.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            } else {
                              return Text("no cat data");
                            }
                          }),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final data = snapshotData.docs[index].data();
                        productName = data.name;
                        imageUrl = data.imageUrl;
                        price = data.price;
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 200, top: 30),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          data.name.toString(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 243, 243, 248),
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data.desc.toString(),
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 243, 243, 248),
                                            fontSize: 18,
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "£" + data.price.toString(),
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 243, 243, 248),
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Container(
                                                height: 50,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.shopping_cart,
                                                    color: Colors.pink,
                                                  ),
                                                  onPressed: () {
                                                    addToCart();
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(20), // Image border
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(100), // Image radius
                                  child: Image.network(data.imageUrl,
                                      fit: BoxFit.cover),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Text("no data");
            }
          },
        ),
      ),
    );
  }
}
