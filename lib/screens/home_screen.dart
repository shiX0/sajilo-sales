import 'package:flutter/material.dart';
import 'package:sajilo_sales/core/common/custom_formfield.dart';
import '../core/common/custom_card.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth < 800 ? 2 : 3;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFormField(
                inputType: TextInputType.text,
                textEditingController: textEditingController,
                labelText: 'Search',
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth < 800 ? 2 : 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1, // Ensuring the aspect ratio
                  ),
                  itemBuilder: (context, index) {
                    final List<CustomCard> cards = [
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
                    ];
                    return cards[index];
                  },
                ),
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
