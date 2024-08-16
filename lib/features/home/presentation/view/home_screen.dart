import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sajilo_sales/app/navigator/navigator.dart';
import 'package:sajilo_sales/core/common/custom_sheet.dart';
import 'package:sajilo_sales/core/common/custom_snackbar.dart';
import 'package:sajilo_sales/core/shared_prefs/user_shared_prefs.dart';
import 'package:sajilo_sales/features/auth/presentation/widget/custom_formfield.dart';
import 'package:sajilo_sales/features/home/presentation/widget/customer_select.dart';
import 'package:sajilo_sales/features/home/presentation/widget/greeting.dart';
import 'package:sajilo_sales/features/home/presentation/widget/product_select.dart';
import 'package:sajilo_sales/features/orders/presentation/view/order_preview.dart';
import 'package:sajilo_sales/features/orders/presentation/viewmodel/order_view_model.dart';
import '../widget/custom_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderViewModelProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: GreetingCard(name: "sui"),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth < 800 ? 2 : 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: screenWidth < 800 ? 1.3 : 1,
                  ),
                  itemBuilder: (context, index) {
                    final List<CustomCard> cards = [
                      CustomCard(
                        icon: Icons.person,
                        text: state.customerEntity != null
                            ? 'Remove customer'
                            : 'Add customer',
                        onTap: () {
                          if (state.customerEntity != null) {
                            ref
                                .read(orderViewModelProvider.notifier)
                                .clearCustomer();
                            showMySnackBar(message: "Customer removed");
                            return;
                          } else {
                            CustomSheet.showBottomSheet(
                                content: const CustomerSelect());
                          }
                        },
                        isActive: state.customerEntity != null,
                      ),
                      CustomCard(
                        icon: Icons.insert_drive_file_rounded,
                        text: 'Add Tax +13%',
                        onTap: () {
                          if (state.tax == 13) {
                            ref.read(orderViewModelProvider.notifier).setTax(0);
                            return;
                          }
                          ref.read(orderViewModelProvider.notifier).setTax(13);
                        },
                        isActive: state.tax == 13,
                      ),
                      CustomCard(
                        icon: Icons.discount,
                        text: 'Discount -10%',
                        onTap: () {
                          if (state.discount == 10) {
                            ref
                                .read(orderViewModelProvider.notifier)
                                .setDiscount(0);
                            return;
                          }
                          ref
                              .read(orderViewModelProvider.notifier)
                              .setDiscount(10);
                        },
                        isActive: state.discount == 10,
                      ),
                      CustomCard(
                        icon: Icons.add,
                        text: 'Add Items',
                        onTap: () {
                          CustomSheet.showBottomSheet(
                              content: const ProductSelect());
                        },
                        isActive: true,
                      ),
                    ];
                    return cards[index];
                  },
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    // add gray background color
                    height: 50,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Color.fromARGB(100, 117, 117, 117),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total Products:"),
                            Text("${state.products.length}")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    // add gray background color
                    height: 50,
                    width: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        // color: Color.fromARGB(187, 155, 140, 215),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total:"),
                            Text("${state.total ?? 0}")
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      NavigateRoute.pushRoute(const OrderPreview());
                    },
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.checklist_rtl_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Go to Checkout',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     NavigateRoute.pushRoute(const OrderPreview());
                  //   },
                  //   child: const Text('Checkout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
