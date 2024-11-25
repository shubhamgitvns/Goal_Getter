import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todocreater/home_page/kids_page.dart';
import 'package:todocreater/home_page/kurti_page.dart';
import 'package:todocreater/home_page/lehenga_page.dart';

import '../jsonclass.dart';
import '../localdb.dart';
import 'bottombar/wishlist_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  Stream<List<Map<String, dynamic>>> getProductsStream() async* {
    try {
      final list = await DatabaseHandler.jsons();
      List<Json> lst = list;
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(jsonDecode(lst.first.json_data));

      List<Map<String, dynamic>> filteredData = data.where((product) {
        final name = product['name']?.toLowerCase() ?? '';
        return name.contains(_searchKeyword.toLowerCase());
      }).toList();

      yield filteredData;
    } catch (e) {
      print("Error fetching products: $e");
      yield [];
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchKeyword = _searchController.text;
      });
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
          automaticallyImplyLeading: false,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(140.0), // Increased height for categories
            child: Column(
              children: [
                // Category Row
                SizedBox(
                  height: 100, // Fixed height for the category row
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: const Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1riobDe7UUaUwHOrWnwmx-d5M6NjkTGg7yjdEhfef3wlki7txX0GFi6YLCG1KxyZPNYk&usqp=CAU"), // Using NetworkImage
                              // Optional fallback content
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Lehenga set",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LehengaPage()));
                        },
                      ),
                      InkWell(
                        child: const Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  "https://www.wholesaletextile.in/product-img/Banwery-Pankh-Ladies-Kurti-Cot-1623224100.jpeg"), // Using NetworkImage
                              // Optional fallback content
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Kurti set",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => KurtiPage()));
                        },
                      ),
                      InkWell(
                        child: const Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(
                                  "https://cdn.shopify.com/s/files/1/0086/0150/1792/files/Girls_Clothing_-_Kidstudio.jpg?v=1600863380"), // Using NetworkImage
                              // Optional fallback content
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Kids set",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => KidsPage()));
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name or category',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
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
                int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.5,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final product = snapshot.data![index];
                    return Product_Saree(
                      description: product['description'],
                      name: product['name'],
                      imageUrl: product['image'],
                      price: product['price'],
                      product: product.toString(),
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

// sarees product list only
class Product_Saree extends StatelessWidget {
  final String description;
  final String name;
  final String imageUrl;
  final double price;
  final String product;

  const Product_Saree({
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              imageUrl: imageUrl,
              description: description,
              name: name,
              price: price.toString(),
              product: product,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "₹ $price",
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DataGet {
  static String token = '';
}
