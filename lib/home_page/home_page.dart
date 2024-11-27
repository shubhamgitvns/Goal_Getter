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

  final List<String> _sliderImages = [
    "https://shantipursaree.com/wp-content/uploads/2024/06/Red-And-White-Modern-Wedding-Season-Offer-Instagram-Post.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRo8fq6Mkhx1yGInuZoPiVBvN0hy1sw7fYsvQ&s",
    "https://www.samyakk.com/blog/wp-content/uploads/2024/01/Kanchipuram-Saree-Mobile01-Copy.jpg",
  ];

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
        // add nestedScrollview widget
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 500.0,
                pinned: true,
                automaticallyImplyLeading: false,
                //specially create fexibleSpace if the scrool on the top the its fix according his size
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              categoryItem(
                                "Lehenga set",
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1riobDe7UUaUwHOrWnwmx-d5M6NjkTGg7yjdEhfef3wlki7txX0GFi6YLCG1KxyZPNYk&usqp=CAU",
                                LehengaPage(),
                              ),
                              categoryItem(
                                "Kurti set",
                                "https://www.wholesaletextile.in/product-img/Banwery-Pankh-Ladies-Kurti-Cot-1623224100.jpeg",
                                KurtiPage(),
                              ),
                              categoryItem(
                                "Kids set",
                                "https://cdn.shopify.com/s/files/1/0086/0150/1792/files/Girls_Clothing_-_Kidstudio.jpg?v=1600863380",
                                KidsPage(),
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
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: PageView.builder(
                            itemCount: _sliderImages.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    _sliderImages[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
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
      ),
    );
  }

  Widget categoryItem(String name, String imageUrl, Widget page) {
    return InkWell(
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
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
