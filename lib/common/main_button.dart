import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      this.textColor = Colors.white,
      required this.buttonText,
      this.onPressed,
      this.mainColor = const Color(0xFFFF7A7A)});
  final String buttonText;
  final Function()? onPressed;
  final Color? mainColor;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            buttonText,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          )),
    );
  }
}
