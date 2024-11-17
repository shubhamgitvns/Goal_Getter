import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../jsonclass.dart';
import '../../localdb.dart';
import '../detail_page.dart';

class Wishlist extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  // Stream to fetch products from the local database
  Stream<List<Map<String, dynamic>>> getProductsStream() async* {
    try {
      final list = await DatabaseHandler.cards();
      List<Shopping> lst = list;
      print(lst);
      print("hii");
      print(lst);
      print(lst[0]);
      // print(lst[0].card_data);
      print(lst[0].name);
      // List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(lst);
      // print("done");
      var data = lst;

      print(lst.runtimeType);
      print(lst.length);
      print("My data");
      print(data[0].description);
      yield data.map((product) {
        return {
          "description": product.description,
          "name": product.name,
          "image": product.image,
          "price": double.parse(product.price)
        };
      }).toList();
    } catch (e) {
      print("Error fetching products: $e");
      yield []; // Return empty list in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
          context: context,
          builder: (context) => ExitConfirmationDialog(),
        );
        return value ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("SareeHub"),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  _searchKeyword = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search by name or category',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: getProductsStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error loading products"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No products available"));
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth < 600 ? 1 : 4;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    return ProductCard(
                      description: product['description'],
                      name: product['name'],
                      imageUrl: product['image'],
                      price: product['price'],
                      product: product,
                    );
                  },
                  padding: const EdgeInsets.all(10),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// Custom Exit Confirmation Dialog (make sure this widget exists)
class ExitConfirmationDialog extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(
        Icons.check_box,
        color: Colors.green.shade200,
        size: 50,
      ),
      content: const Text(
        "Do you want to exit?",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      actions: [
        InkWell(
          child: Container(
            height: 50,
            width: 60,
            color: Colors.red,
            child: const Center(
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          onTap: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          },
        ),
        const SizedBox(width: 20),
        InkWell(
          child: Container(
            height: 50,
            width: 60,
            color: Colors.red,
            child: const Center(
              child: Text(
                "No",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String description;
  final String name;
  final String imageUrl;
  final double price;
  final Map<String, dynamic> product;

  const ProductCard({
    required this.description,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Print product details on card tap
        print("Product Details:");
        print("Name: ${product['name']}");
        print("Image URL: ${product['image']}");
        print("Price: ${product['price']}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              imageUrl: imageUrl,
              description: description,
              name: name,
              price: price.toString(),
              product: product.toString(),
            ),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          description,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      //const SizedBox(height: 4),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          price.toString(),
                          style: TextStyle(color: Colors.green.shade700),
                        ),
                      ),
                    ],
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
