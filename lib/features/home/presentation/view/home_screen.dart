import 'package:flutter/material.dart';
import 'package:sajilo_sales/features/auth/presentation/widget/custom_formfield.dart';
import '../widget/custom_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // int crossAxisCount = screenWidth < 800 ? 2 : 3;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFormField(
                icon: const Icon(Icons.search),
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
                    childAspectRatio: screenWidth < 800
                        ? 1.3
                        : 1, // Ensuring the aspect ratio
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
    );
  }
}
