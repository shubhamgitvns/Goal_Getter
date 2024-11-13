import 'package:flutter/material.dart';
import 'package:todocreater/home_page/bottombar/Order_page.dart';
import 'package:todocreater/home_page/bottombar/wishlist_page.dart';

import '../home_page.dart';
import 'profile.dart';

class Bottomnavigation extends StatefulWidget {
  int index = 0;
  Bottomnavigation({super.key, required this.index});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  int _selectedIndex = 0;
  final bool _showBottomSheet = false;
  int _previousIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Wishlist(),
    Order_Page(),
    ProfilePage(),
    // const Profile(),
  ];

  final bool _isBottomSheetOpen = false;

  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.maincolor,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        selectedIconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.green.shade50,
        selectedLabelStyle: const TextStyle(fontSize: 2),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _previousIndex = _selectedIndex;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home_filled,
                    color: _selectedIndex == 0 ? Colors.green : Colors.grey,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 10,
                      color: _selectedIndex == 0 ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.padding,
                    color: _selectedIndex == 1 ? Colors.green : Colors.grey,
                  ),
                  Text(
                    "Wish List",
                    style: TextStyle(
                      fontSize: 10,
                      color: _selectedIndex == 1 ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag,
                    color: _selectedIndex == 2 ? Colors.green : Colors.grey,
                  ),
                  Text(
                    "Order",
                    style: TextStyle(
                      fontSize: 10,
                      color: _selectedIndex == 2 ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: _selectedIndex == 3 ? Colors.green : Colors.grey,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 10,
                      color: _selectedIndex == 3 ? Colors.green : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          ),
        ],
      ),

      body: Stack(
        children: [
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),
      // bottomSheet: _showBottomSheet ? _buildBottomSheet() : null,
    );
  }
}
