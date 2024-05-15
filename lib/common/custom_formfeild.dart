import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType inputType;

  const CustomFormField({
    super.key,
    required this.inputType,
    required this.textEditingController,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: inputType,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFFB0BCD1)),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFB0BCD1)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFBABFEF)),
        ),
      ),
    );
  }
}
