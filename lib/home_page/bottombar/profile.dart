import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green.shade300,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              // color: Colors.green.shade300,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    //   backgroundImage: NetworkImage(
                    //       'https://via.placeholder.com/150'), // Dummy profile picture
                  ),
                  SizedBox(height: 10),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'johndoe@example.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Account Options
            ListTile(
              leading: Icon(Icons.shopping_bag, color: Colors.green),
              title: Text('Order History'),
              onTap: () {
                // Add navigation to Order History
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.green),
              title: Text('Wishlist'),
              onTap: () {
                // Add navigation to Wishlist
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.payment, color: Colors.green),
              title: Text('Payment Methods'),
              onTap: () {
                // Add navigation to Payment Methods
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.green),
              title: Text('Shipping Addresses'),
              onTap: () {
                // Add navigation to Shipping Addresses
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.green),
              title: Text('Settings'),
              onTap: () {
                // Add navigation to Settings
              },
            ),
            Divider(),

            // Logout Option
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Add logout functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
