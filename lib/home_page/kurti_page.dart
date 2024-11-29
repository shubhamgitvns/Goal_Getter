import 'dart:io';

import 'package:flutter/material.dart';

import 'detail_page.dart';

class KurtiPage extends StatefulWidget {
  @override
  _KurtiPageState createState() => _KurtiPageState();
}

class _KurtiPageState extends State<KurtiPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';
  bool _isOffline = false;
  bool _isFirstLoadFailed = false;
  bool _isLoading = true;
  List<Map<String, dynamic>> lehengaData = []; // Final data to show
  List<Map<String, dynamic>> cachedData = []; // Cached data for offline use

  // Dummy JSON data

  final List<Map<String, dynamic>> _lehengaDataSource = [
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
  @override
  void initState() {
    super.initState();
    _checkConnectivityAndLoadData();
    _searchController.addListener(() {
      setState(() {
        _searchKeyword = _searchController.text;
      });
    });
  }

  Future<void> _checkConnectivityAndLoadData() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _loadData();
      }
    } on SocketException catch (_) {
      setState(() {
        _isOffline = true;
        _isFirstLoadFailed = lehengaData.isEmpty;
        _isLoading = false;
      });
    }
  }

  Future<void> _loadData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    setState(() {
      lehengaData = _lehengaDataSource; // Load data
      cachedData = lehengaData; // Cache data
      _isOffline = false;
      _isFirstLoadFailed = false;
      _isLoading = false;
    });
  }

  List<Map<String, dynamic>> getFilteredData() {
    return lehengaData.where((product) {
      final name = product['name']?.toLowerCase() ?? '';
      return name.contains(_searchKeyword.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Kurti Collections"),
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _isFirstLoadFailed
              ? _buildNoInternetView()
              : _buildGridView(),
    );
  }

  Widget _buildNoInternetView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 50, color: Colors.red),
          SizedBox(height: 10),
          Text(
            "No Internet Connection",
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _checkConnectivityAndLoadData,
            child: Text("Refresh"),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
    final filteredData = getFilteredData();
    return RefreshIndicator(
      onRefresh: () async {
        try {
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            await _loadData();
          }
        } on SocketException catch (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("No Internet Connection"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 8,
          childAspectRatio: 0.5,
        ),
        itemCount: filteredData.length,
        itemBuilder: (context, index) {
          final product = filteredData[index];
          return GestureDetector(
            //******* if the user click the product the the user go to the detail page here code ************//
            onTap: () {
              // Navigate to Detail Page
              print(product.toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    name: product['name'],
                    description: product['description'],
                    price: product['price'],
                    imageUrl: product['image'],
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
                    child: Text(product['description']),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(product['price'],
                          style: const TextStyle(
                              color: Colors.green, fontSize: 14)),
                      Text(product['review'],
                          style: const TextStyle(
                              color: Colors.orange, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
