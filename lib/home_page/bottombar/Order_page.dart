import 'package:flutter/material.dart';

class Order_Page extends StatelessWidget {
  const Order_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("Order Is Not Availabel"),
          )
        ],
      ),
    );
  }
}
