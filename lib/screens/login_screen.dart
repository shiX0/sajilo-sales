import 'package:flutter/material.dart';
import 'package:sajilo_sales/common/custom_formfeild.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              CustomFormField(
                  validator: (value) {},
                  inputType: TextInputType.emailAddress,
                  textEditingController: emailController,
                  labelText: "enter your email"),
              const SizedBox(
                height: 10,
              ),
              CustomFormField(
                  validator: (value) {},
                  inputType: TextInputType.emailAddress,
                  textEditingController: emailController,
                  labelText: "enter your Password")
            ],
          ),
        ),
      ),
    );
  }
}
