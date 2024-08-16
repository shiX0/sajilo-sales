import 'dart:async';

import 'package:all_sensors/all_sensors.dart';
import 'package:flutter/material.dart';
import 'package:sajilo_sales/core/common/custom_sheet.dart';
import 'package:sajilo_sales/features/Settings/presentation/view/settings_view.dart';
import 'package:sajilo_sales/features/customers/presentation/view/customer_view.dart';
import 'package:sajilo_sales/features/home/presentation/view/home_screen.dart';
import 'package:sajilo_sales/features/orders/presentation/view/order_view.dart';
import 'package:sajilo_sales/features/products/presentation/view/product_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const OrderView(),
    const ProductView(),
    CustomerView(),
    const SettingsView(),
  ];

  final List<double> _accelerometerValues = [0, 0, 0];
  final double _shakeThreshold = 15.0;
  bool _isModalOpen = false;
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription =
        accelerometerEvents!.listen((AccelerometerEvent event) {
      if (!_isModalOpen) {
        setState(() {
          _accelerometerValues[0] = event.x;
          _accelerometerValues[1] = event.y;
          _accelerometerValues[2] = event.z;
        });

        if (_isShakeDetected(event)) {
          _showReportIssueModal();
        }
      }
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  bool _isShakeDetected(AccelerometerEvent event) {
    double magnitude =
        event.x * event.x + event.y * event.y + event.z * event.z;
    magnitude = magnitude / (9.81 * 9.81);
    return magnitude > _shakeThreshold;
  }

  void _showReportIssueModal() {
    if (_isModalOpen) return; // Prevent multiple modals from opening

    setState(() {
      _isModalOpen = true;
    });

    CustomSheet.showBottomSheet(
      content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Report a Bug or Issue',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Describe the issue',
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _isModalOpen = false;
                    });
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _screens[_selectedIndex],
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
