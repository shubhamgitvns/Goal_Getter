import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../jsonclass.dart';
import '../../localdb.dart';
import '../detail_page.dart';

class order_page extends StatefulWidget {
  @override
  _order_pageState createState() => _order_pageState();
}

class _order_pageState extends State<order_page> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';
  late Stream<List<Map<String, dynamic>>> _productsStream;

  @override
  void initState() {
    super.initState();
    _productsStream = getProductsStream();
    _searchController.addListener(() {
      setState(() {
        _searchKeyword = _searchController.text.toLowerCase();
      });
    });
  }

  // Stream to fetch products from the local database
  Stream<List<Map<String, dynamic>>> getProductsStream() async* {
    try {
      final list = await DatabaseHandler.orders();
      List<Order_Detail> lst = list;

      Map<String, Map<String, dynamic>> productMap = {};

      // Merge products with the same name
      for (var product in lst) {
        // is used to clean or filter the price of a product so that it only contains numbers and a decimal point.
        String cleanPrice = product.price.replaceAll(RegExp(r'[^\d.]'), '');

        if (productMap.containsKey(product.name)) {
          productMap[product.name]!['quantity'] += 1; // Increase quantity
        } else {
          productMap[product.name] = {
            "description": product.description,
            "name": product.name,
            "image": product.image,
            "price": double.parse(cleanPrice),
            "quantity": 1, // Initialize quantity
          };
        }
      }

      yield productMap.values.toList();
    } catch (e) {
      print("Error fetching products: $e");
      yield [];
    }
  }

  // Delete the product by name
  Future<void> deleteProduct(String productName) async {
    await DatabaseHandler.deleteJson(productName); // Delete from the DB
    setState(() {
      _productsStream = getProductsStream(); // Refresh the product list
    });
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
          title: const Text("Order List"),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(55.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name or category',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _productsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error loading products"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No products available"));
            }

            var filteredProducts = snapshot.data!.where((product) {
              return product['name'].toLowerCase().contains(_searchKeyword) ||
                  product['description'].toLowerCase().contains(_searchKeyword);
            }).toList();

            return LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth < 600 ? 1 : 4;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      description: product['description'],
                      name: product['name'],
                      imageUrl: product['image'],
                      price: product['price'],
                      quantity: product['quantity'],
                      onDelete: () => deleteProduct(product['name']),
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

class ExitConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Do you want to exit?",
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
      actions: [
        InkWell(
          child: Container(
            height: 50,
            width: 60,
            color: Colors.green,
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
  final int quantity;
  final VoidCallback onDelete;

  const ProductCard({
    required this.description,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              imageUrl: imageUrl,
              description: description,
              name: name,
              price: price.toString(),
              product: name,
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
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹ $price",
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Qty: $quantity"),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Order Cancel",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onTap: () async {
                          // Show confirmation dialog
                          bool confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Delete Confirmation"),
                              content: Text(
                                  "Are you sure you want to delete this product?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(
                                      context, false), // Dismiss dialog
                                  child: Text("No",
                                      style: TextStyle(color: Colors.red)),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    // Delete product
                                    onDelete();
                                    Navigator.pop(context);
                                  },
                                  child: Text("Yes",
                                      style: TextStyle(color: Colors.green)),
                                ),
                              ],
                            ),
                          );

                          // If confirmed, delete product and refresh
                          if (confirm) {
                            await DatabaseHandler.deleteOrderByName(
                                name); // Delete product
                            onDelete(); // Refresh the product list
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
