import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // Dummy product data as a stream (replace with your database stream)
  Stream<List<Map<String, dynamic>>> getProductsStream() async* {
    await Future.delayed(Duration(seconds: 1)); // Simulate delay
    yield [
      {
        "name": "Silk Saree",
        "image":
            "https://shubhamgitvns.github.io/ecommerce/assets/images/6.jpg",
        "price": "₹1299.99",
      },
      {
        "name": "Cotton Saree",
        "image":
            "https://shubhamgitvns.github.io/ecommerce/assets/images/4.jpg",
        "price": "₹699.99",
      },
      {
        "name": "Banarasi Saree",
        "image":
            "https://shubhamgitvns.github.io/ecommerce/assets/images/1.jpg",
        "price": "₹2499.99",
      },
      // More dummy data
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SareeHub"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: getProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading products"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No products available"));
          }

          // Responsive grid layout for products
          return LayoutBuilder(
            builder: (context, constraints) {
              // Determine column count based on screen width
              int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
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
                    name: product['name'],
                    imageUrl: product['image'],
                    price: product['price'],
                  );
                },
                padding: EdgeInsets.all(10),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String price;

  ProductCard(
      {required this.name, required this.imageUrl, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(color: Colors.green.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DataGet {
  static String token = '';
}
