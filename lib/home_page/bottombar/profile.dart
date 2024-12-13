import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todocreater/app_text_var.dart';

import '../../utilittes.dart';
import 'bottombar.dart';

class ProfilePage extends StatelessWidget {
  final GoogleSignInAccount? user = Googel_Signin.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: App_Text.app_bar,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              // color: Colors.green.shade300,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade100,
                    //   backgroundImage: NetworkImage(
                    //       'https://via.placeholder.com/150'), // Dummy profile picture
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user!.email,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Account Options
            ListTile(
              leading:
                  Icon(Icons.shopping_bag, color: Colors.lightBlue.shade300),
              title: const Text(
                'Order History',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Bottomnavigation(
                              index: 2,
                            )));
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.favorite, color: Colors.lightBlue.shade300),
              title: const Text(
                'Wishlist',
                style: TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Bottomnavigation(
                              index: 1,
                            )));
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.1), // Shadow color with transparency
                      spreadRadius: 5, // Spread of the shadow
                      blurRadius: 10, // Blur intensity of the shadow
                      offset: const Offset(
                          0, 4), // Shadow position (horizontal, vertical)
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(
                    16), // Internal padding of the container
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Buy Again',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'See what others are recomanded on Buy Again',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey)),
                        child: const Center(
                          child: Text("View Page"),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Bottomnavigation(
                                      index: 0,
                                    )));
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
