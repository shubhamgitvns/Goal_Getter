import 'dart:io';

import 'package:flutter/material.dart';

class LehengaPage extends StatefulWidget {
  @override
  _LehengaPageState createState() => _LehengaPageState();
}

class _LehengaPageState extends State<LehengaPage> {
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
      "name": "Embroidered Lehenga",
      "description": "Beautifully crafted lehenga with intricate embroidery.",
      "price": "₹8,999.90",
      "review": "4.5/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5gr9aYub0RSLZDmZjDU6yMNTeS19ot_3CdA&s"
    },
    {
      "name": "Silk Lehenga",
      "description": "Elegant silk lehenga perfect for weddings.",
      "price": "₹12,499.67",
      "review": "4.8/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkLJqN4nWhYdwl9wRiX1OZ5un-6P4JvXRQ3A&s"
    },
    {
      "name": "Silk Lehenga",
      "description": "Elegant silk lehenga perfect for weddings.",
      "price": "₹12,499.67",
      "review": "4.8/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkLJqN4nWhYdwl9wRiX1OZ5un-6P4JvXRQ3A&s"
    },
    {
      "name": "Floral Lehenga",
      "description": "Bright floral lehenga for festive occasions.",
      "price": "₹7,499.50",
      "review": "4.2/5",
      "image":
          "https://www.lavanyathelabel.com/cdn/shop/files/0H8A3228_1800x.jpg?v=1700028456"
    },
    {
      "name": "Elegant Lehenga",
      "description": "Elegant lehenga for grand celebrations.",
      "price": "₹7,999.70",
      "review": "4.3/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-_cWfeqkN8Lwu1P9Ndm2rpzWXkyFoof2ByQ&s"
    },
    {
      "name": "Silk Lehenga",
      "description": "Elegant silk lehenga perfect for weddings.",
      "price": "₹12,499.67",
      "review": "4.8/5",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkLJqN4nWhYdwl9wRiX1OZ5un-6P4JvXRQ3A&s"
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
          return Card(
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
                        style:
                            const TextStyle(color: Colors.green, fontSize: 14)),
                    Text(product['review'],
                        style: const TextStyle(
                            color: Colors.orange, fontSize: 14)),
                  ],
                ),
              ],
            ),
          );
        },
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
