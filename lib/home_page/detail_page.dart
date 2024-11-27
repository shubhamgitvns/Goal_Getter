import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../jsonclass.dart';
import '../localdb.dart';
import 'order_detail_page.dart';

class DetailPage extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String name;
  final String price;
  final String product;

  const DetailPage(
      {required this.imageUrl,
      required this.description,
      required this.name,
      required this.price,
      required this.product});
  static FirebaseFirestore? firestoredb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Container(
                    height: 50,
                    width: 100,
                    color: Colors.green,
                    child: const Center(
                        child: Text(
                      "Buy now",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => OrderFormPage()));
                  },
                ),
                InkWell(
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green)),
                    child: const Center(
                        child: Text(
                      "Add card",
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )),
                  ),
                  onTap: () async {
                    print("add page");
                    try {
                      print("Adding to wishlist");
                      var crd = await DatabaseHandler.cards();
                      print(crd.length);
                      print(crd);
                      var javabook =
                          Shopping(description, name, price, imageUrl);
                      await DatabaseHandler.insertShopping_card(javabook);
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Product successfully added to wishlist!"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      // Show error message if something goes wrong
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Failed to add product: $e"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    " Rs. $price",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
