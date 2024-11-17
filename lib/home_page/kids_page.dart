import 'package:flutter/material.dart';

class KidsPage extends StatefulWidget {
  @override
  _KidsPageState createState() => _KidsPageState();
}

class _KidsPageState extends State<KidsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';

  // Dummy JSON data for lehenga details
  final List<Map<String, dynamic>> lehengaData = [
    {
      "name": "Jacket Frock",
      "description": "Beautifully crafted lehenga with intricate embroidery.",
      "price": "₹8,999",
      "review": "4.5/5",
      "image":
          "https://images.meesho.com/images/products/417312020/tvtl8_512.webp" // Replace with actual image URL
    },
    {
      "name": "Printed Frock",
      "description": "Elegant silk lehenga perfect for weddings.",
      "price": "₹12,499",
      "review": "4.8/5",
      "image":
          "https://images.meesho.com/images/products/422934292/8pgcy_512.webp" // Replace with actual image URL
    },
    {
      "name": "Handwork designer frock",
      "description": "Bright floral lehenga for festive occasions.",
      "price": "₹7,499",
      "review": "4.2/5",
      "image":
          "https://www.dhresource.com/webp/m/0x0/f2/albu/g17/M01/34/90/rBVa4mIwCOWAFjyMAAtOhIMfn9A495.jpg" // Replace with actual image URL
    },
    {
      "name": "Baby Girl Casual",
      "description": "Bright floral lehenga for festive occasions.",
      "price": "₹7,499",
      "review": "4.2/5",
      "image":
          "https://rukminim2.flixcart.com/image/850/1000/xif0q/kids-ethnic-set/f/q/i/8-9-years-clothing-set-yellow-rmdsstores-original-imagskrhbbnzcezk.jpeg?q=90&crop=false" // Replace with actual image URL
    },
    {
      "name": "Tranding Kurti",
      "description": "Bright floral lehenga for festive occasions.",
      "price": "₹7,499",
      "review": "4.2/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzrtohj3ThLz_KNcqeVaT4NRqEAQsLqo22Fg&s" // Replace with actual image URL
    },
    {
      "name": "Banweary Princes",
      "description": "Bright floral lehenga for festive occasions.",
      "price": "₹7,499",
      "review": "4.2/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTk2IzPeZi8hwf3SRb8ED7pBtjFa04tAuC4ZQ&s" // Replace with actual image URL
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
        title: const Text("Kids Collection"),
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
