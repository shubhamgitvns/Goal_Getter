import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todocreater/app_text_var.dart';

import 'detail_page.dart';

class KidsPage extends StatefulWidget {
  @override
  _KidsPageState createState() => _KidsPageState();
}

class _KidsPageState extends State<KidsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchKeyword = '';
  bool _isOffline = false;
  bool _isFirstLoadFailed = false;
  bool _isLoading = true;
  List<Map<String, dynamic>> lehengaData = []; // Final data to show
  List<Map<String, dynamic>> cachedData = []; // Cached data for offline use

  // Dummy JSON data

  List<Map<String, dynamic>> _lehengaDataSource = [
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
        title: const Text("Kids Collections"),
        backgroundColor: App_Text.app_bar,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by name or category',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.lightBlue.shade100)),
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
            const SnackBar(
              content: Text("No Internet Connection"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
