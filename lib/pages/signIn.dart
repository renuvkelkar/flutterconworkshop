import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutterconworkshop/pages/dashboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? userId;
  Future signInAnonymously() async {
    final userCredential =
        await FirebaseAuth.instance.signInAnonymously().then((value) {
      userId = value.user!.uid;
      FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
        'id': value.user!.uid,
      });
    });
    print(userCredential);
    // userId = userCredential.user!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 238, 122, 161),
        title: Text("Icecream App"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Image.network(
            "https://img.freepik.com/free-vector/background-ice-cream-with-hand-drawn-wafer_23-2147634569.jpg?w=1380&t=st=1687971488~exp=1687972088~hmac=70ecbe1ef7708b2beaa1dbc0363737e2fe6968f4c511b73a5c0bb3749443db79",
            width: double.infinity,
            fit: BoxFit.fill),
        SizedBox(
          height: 80,
        ),
        Center(
          child: Container(
              height: 60,
              width: 300,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 122, 161),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextButton(
                  onPressed: () async {
                    signInAnonymously();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DashBoard(userId!)));
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text('user is added'),
                    //   ),
                    // );
                  },
                  child: Text(
                    "Sign In",
                    style: Theme.of(context).textTheme.titleLarge,
                  ))),
        ),
      ]),
    );
  }
}
