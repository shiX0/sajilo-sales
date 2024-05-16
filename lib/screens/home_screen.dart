import 'package:flutter/material.dart';
import 'package:sajilo_sales/common/custom_formfield.dart';

import '../common/custom_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFormField(
                  inputType: TextInputType.text,
                  textEditingController: textEditingController,
                  labelText: 'Search'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  CustomCard(
                    icon: Icons.person,
                    text: 'Add customer',
                    onTap: () {
                      print('Add customer button tapped');
                    },
                    isActive: true,
                  ),
                  CustomCard(
                    icon: Icons.shopping_basket,
                    text: 'Add custom sale',
                    onTap: () {
                      print('Add custom sale button tapped');
                    },
                    isActive: true,
                  ),
                  CustomCard(
                    icon: Icons.discount,
                    text: 'Apply discount',
                    onTap: () {
                      print('Apply discount button tapped');
                    },
                    isActive: false,
                  ),
                  CustomCard(
                    icon: Icons.local_shipping,
                    text: 'Ship to customer',
                    onTap: () {
                      print('Ship to customer button tapped');
                    },
                    isActive: false,
                  ),
                  CustomCard(
                    icon: Icons.discount,
                    text: 'Discount -10%',
                    onTap: () {
                      print('Discount -10% button tapped');
                    },
                    isActive: false,
                  ),
                  CustomCard(
                    icon: Icons.add,
                    text: 'Add Items',
                    onTap: () {
                      print('Add Items button tapped');
                    },
                    isActive: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
