import 'package:flutter/material.dart';
import 'package:sajilo_sales/app/navigator_key/navigator_key.dart';

class CustomSheet {
  CustomSheet._();

  static void showBottomSheet({
    required Widget content,
  }) {
    showModalBottomSheet(
      context: AppNavigator.navigatorKey.currentState!.context,
      isScrollControlled:
          true, // Allows the bottom sheet to resize and move above the keyboard
      showDragHandle: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            margin: EdgeInsetsDirectional.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: content,
          ),
        );
      },
    );
  }
}
