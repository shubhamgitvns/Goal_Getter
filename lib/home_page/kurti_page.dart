import 'package:flutter/material.dart';

class KurtiPage extends StatefulWidget {
  @override
  _KurtiPageState createState() => _KurtiPageState();
}

class _KurtiPageState extends State<KurtiPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  // Dummy JSON data for lehenga details
  final List<Map<String, dynamic>> lehengaData = [
    {
      "name": "Cotton printed kurti",
      "description": "Beautifully crafted lehenga with intricate embroidery.",
      "price": "₹8,999",
      "review": "4.5/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX4XTI1qRLrsZIKntGTxQ56omfcqmGVzbO4g&s" // Replace with actual image URL
    },
    {
      "name": "Gradiant Kurti",
      "description": "Elegant silk lehenga perfect for weddings.",
      "price": "₹12,499",
      "review": "4.8/5",
      "image":
          "https://www.ethnicrajasthan.com/cdn/shop/files/ETHNICRAJASTHANAPKULCCHBPLFL30401SV_3.jpg?v=1698763228&width=2048" // Replace with actual image URL
    },
    {
      "name": "Handwork Gajiri silk",
      "description": "Bright floral lehenga for festive occasions.",
      "price": "₹7,499",
      "review": "4.2/5",
      "image":
          "https://clothsvilla.com/cdn/shop/products/party-wear-gaji-silk-printed-plazo-kurti-set-by-looknbook-art_1000x.jpg?v=1680884148" // Replace with actual image URL
    },
    {
      "name": "Plain designer kurti",
      "description": "Bright floral lehenga for festive occasions.",
      "price": "₹7,499",
      "review": "4.2/5",
      "image":
          "https://cdn.sareeka.com/image/cache/data2023/plain-cotton-designer-kurti-256633-1000x1375.jpg" // Replace with actual image URL
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
        title: const Text("Kurti Collection"),
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
                ? const Center(child: Text("No Kurti available"))
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
