import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todocreater/app_text_var.dart';

import 'detail_page.dart';

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
  List<Map<String, dynamic>> lehengaData = [];
  List<Map<String, dynamic>> cachedData = [];

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

//*********** This function ckeck the internet connection then load the data  **********//
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

//************** Loading the Product Data  ******************************//
  Future<void> _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      lehengaData = _lehengaDataSource;
      cachedData = lehengaData;
      _isOffline = false;
      _isFirstLoadFailed = false;
      _isLoading = false;
    });
  }

// ****************** Searching the data according to product name *****************//
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

// ********** if the internet connection is empty *************//
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

//*********** refresh indicator code here ****************//
  Widget _buildGridView() {
    final filteredData = getFilteredData();
    return RefreshIndicator(
      onRefresh: () async {
        //******* if the connection is connected ****************//
        try {
          final result = await InternetAddress.lookup('example.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            await _loadData();
          }
        }
        //******* if the connection is not connected ****************//

        on SocketException catch (_) {
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
