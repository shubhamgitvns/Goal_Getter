import 'package:flutter/material.dart';

import 'detail_page.dart'; // Import the DetailPage

class LehengaPage extends StatefulWidget {
  @override
  _LehengaPageState createState() => _LehengaPageState();
}

class _LehengaPageState extends State<LehengaPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  // Dummy JSON data for lehenga details
  final List<Map<String, dynamic>> lehengaData = [
    {
      "name": "Embroidered Lehenga",
      "description": "Beautifully crafted lehenga with intricate embroidery.",
      "price": "₹8,999.90",
      "review": "4.5/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5gr9aYub0RSLZDmZjDU6yMNTeS19ot_3CdA&s" // Replace with actual image URL
    },
    {
      "name": "Silk Lehenga",
      "description": "Elegant silk lehenga perfect for weddings.",
      "price": "₹12,499.67",
      "review": "4.8/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkLJqN4nWhYdwl9wRiX1OZ5un-6P4JvXRQ3A&s" // Replace with actual image URL
    },
    {
      "name": "Floral Lehenga",
      "description": "Bright floral lehenga for festive occasions.",
      "price": "₹7,499.50",
      "review": "4.2/5",
      "image":
          "https://www.lavanyathelabel.com/cdn/shop/files/0H8A3228_1800x.jpg?v=1700028456" // Replace with actual image URL
    },
    {
      "name": "Elegant Lehenga",
      "description": "Elegant lehenga for grand celebrations.",
      "price": "₹7,999.70",
      "review": "4.3/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-_cWfeqkN8Lwu1P9Ndm2rpzWXkyFoof2ByQ&s" // Replace with actual image URL
    },
  ];

  // Filter lehenga data based on search keyword
  List<Map<String, dynamic>> getFilteredData() {
    return lehengaData.where((product) {
      final name = product['name']?.toLowerCase() ?? '';
      return name.contains(_searchKeyword.toLowerCase());
    }).toList();
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Lehenga Collections"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
          final filteredData = getFilteredData();
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 8,
              childAspectRatio: 0.5,
            ),
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final product = filteredData[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to DetailPage with product details
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(
                        imageUrl: product['image'],
                        description: product['description'],
                        name: product['name'],
                        price: product['price'],
                        product: product.toString(),
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.network(
                          product['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product['description'],
                          style: const TextStyle(
                              //fontWeight: FontWeight.bold,
                              //  fontSize: 15,
                              ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(product['price'],
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 14)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(product['review'],
                                style: const TextStyle(
                                    color: Colors.orange, fontSize: 14)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            padding: const EdgeInsets.all(10),
          );
        },
      ),
    );
  }
}
