import 'package:flutter/material.dart';

class OauthButton extends StatelessWidget {
  const OauthButton(
      {super.key,
      this.textColor = Colors.black45,
      required this.buttonText,
      this.onPressed,
      this.mainColor = Colors.white});
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
        ),
      ),
    );
  }
}
