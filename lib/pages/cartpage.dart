import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterconworkshop/model/cart_model.dart';

class CartPage extends StatefulWidget {
  final String? userId;
  CartPage({this.userId});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final cartRef = FirebaseFirestore.instance
      .collection('cart')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .withConverter<ShopCart>(
        fromFirestore: (snapshot, _) => ShopCart.fromJson(
          snapshot.data()!,
        ),
        toFirestore: (model, _) => model.toJson(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: StreamBuilder<DocumentSnapshot<ShopCart>>(
        stream: cartRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final shopCart = snapshot.data?.data()?.shopCart;

          if (shopCart == null || shopCart.isEmpty) {
            return Text('No items in the cart.');
          }

          return ListView.builder(
            itemCount: shopCart.length,
            itemBuilder: (context, index) {
              final cartItem = shopCart[index];

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 150),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              cartItem.name ?? '',
                              style: TextStyle(
                                color: Color.fromARGB(255, 243, 243, 248),
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    '£${cartItem.price.toString()}',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 243, 243, 248),
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(50),
                        child: Image.network(
                          cartItem.imageUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
