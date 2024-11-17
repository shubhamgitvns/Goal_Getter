import 'package:flutter/material.dart';

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
      "price": "₹8,999",
      "review": "4.5/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5gr9aYub0RSLZDmZjDU6yMNTeS19ot_3CdA&s" // Replace with actual image URL
    },
    {
      "name": "Silk Lehenga",
      "description": "Elegant silk lehenga perfect for weddings.",
      "price": "₹12,499",
      "review": "4.8/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkLJqN4nWhYdwl9wRiX1OZ5un-6P4JvXRQ3A&s" // Replace with actual image URL
    },
    {
      "name": "Floral Lehenga",
      "description": "Bright floral lehenga for festive occasions.",
      "price": "₹7,499",
      "review": "4.2/5",
      "image":
          "https://www.lavanyathelabel.com/cdn/shop/files/0H8A3228_1800x.jpg?v=1700028456" // Replace with actual image URL
    },
    {
      "name": "Elegent Lehenga",
      "description": "Bright floral lehenga for festive occasions.",
      "price": "₹7,499",
      "review": "4.2/5",
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
    final filteredData = getFilteredData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lehenga Collection"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for lehengas',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Lehenga List
          Expanded(
            child: filteredData.isEmpty
                ? const Center(child: Text("No lehengas available"))
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5,
                    ),
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      final product = filteredData[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                product['image'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product['description'],
                                    style: const TextStyle(fontSize: 14),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Price: ${product['price']}",
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 14),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Review: ${product['review']}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
