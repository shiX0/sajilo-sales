import 'package:flutter/material.dart';
import 'package:sajilo_sales/app/navigator_key/navigator_key.dart';

class CustomSheet {
  CustomSheet._();
  static void showBottomSheet({
    required Widget content,
  }) {
    showModalBottomSheet(
      context: AppNavigator.navigatorKey.currentState!.context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return content;
      },
    );
  }
}
