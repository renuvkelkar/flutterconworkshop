import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterconworkshop/model/cart_model.dart';

class CartPage extends StatefulWidget {
  final String? userId;
  CartPage({this.userId});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartRef =
      FirebaseFirestore.instance.collection('cart').withConverter<CartModel>(
            fromFirestore: (snapshot, _) => CartModel.fromJson(
              snapshot.data()!,
            ),
            toFirestore: (model, _) => model.toJson(),
          );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: StreamBuilder(
          stream:
              cartRef.where("cartUId", isEqualTo: widget.userId).snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final snapshotData = snapshot.data;
                    final catData = snapshotData.docs[index].data();
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 150,
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      catData.name.toString(),
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 243, 243, 248),
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "£" + catData.price.toString(),
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 243, 243, 248),
                                              fontSize: 18,
                                            ),
                                          ),
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
                              size: Size.fromRadius(50), // Image radius
                              child: Image.network(catData.imageUrl,
                                  fit: BoxFit.cover),
                            ),
                          )
                        ],
                      ),
                    );
                    // return Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     color: Colors.red,
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Center(child: Text(catData.name)),
                    //     ),
                    //   ),
                    // );
                  });
            } else {
              return Text("no Cart data");
            }
          }),
    );
  }
}
