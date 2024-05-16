import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sajilo_sales/common/main_button.dart';

import '../common/custom_formfield.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/icons/logo.svg'),
              const SizedBox(height: 20),
              const Text(
                'SajiloSales',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Register',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              CustomFormField(
                textEditingController: nameController,
                labelText: 'Name',
                validator: (value) {
                  // Add your validation logic here
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                inputType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              CustomFormField(
                textEditingController: emailController,
                labelText: 'Email',
                inputType: TextInputType.emailAddress,
                validator: (value) {
                  // Add your validation logic here
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomFormField(
                textEditingController: passwordController,
                labelText: 'Password',
                obscure: true,
                validator: (value) {
                  // Add your validation logic here
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                inputType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 20),
              MainButton(
                buttonText: "Register",
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Handle navigation to login screen
                },
                child: const Text(
                  'Login?',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
