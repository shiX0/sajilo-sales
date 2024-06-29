import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final bool obscure;
  final Icon? icon;
  final IconData? leadingIcon;
  final Function()? prefixOnPressed;

  const CustomFormField(
      {super.key,
      required this.inputType,
      required this.textEditingController,
      required this.labelText,
      this.validator,
      this.icon,
      this.leadingIcon,
      this.prefixOnPressed,
      this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: inputType,
      validator: validator,
      obscureText: obscure,
      
      decoration: InputDecoration(
        prefixIcon: icon,
        fillColor: const Color(0xFF3C3D3F),
        filled: true,
        // prefix: IconButton(
        //   icon: Icon(leadingIcon),
        //   onPressed: prefixOnPressed,
        // ),

        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFFB0BCD1)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),

        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFBABFEF)),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            )),
      ),
    );
  }
}
