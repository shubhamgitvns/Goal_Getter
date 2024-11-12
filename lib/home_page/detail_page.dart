import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String name;
  final String price;

  const DetailPage(
      {required this.imageUrl,
      required this.description,
      required this.name,
      required this.price});
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
                Container(
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
                    await DetailPage.firestoredb
                        ?.collection("srees_data_detail")
                        .add({
                      "id": '11',
                      "img": "$imageUrl",
                      "description": "$description",
                      "price": "$price",
                      "name": "$name"
                    });
                    print("sending dta");
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
