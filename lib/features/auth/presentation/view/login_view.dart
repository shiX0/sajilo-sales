import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sajilo_sales/features/auth/presentation/widget/main_button.dart';
import 'package:sajilo_sales/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../widget/custom_formfield.dart';

class LoginView extends ConsumerWidget {
  final TextEditingController emailController =
      TextEditingController(text: "hello@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "hello");
  LoginView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  buttonText: "Login",
                  onPressed: () {
                    ref.read(authViewModelProvider.notifier).loginAccount(
                        emailController.text, passwordController.text);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(authViewModelProvider.notifier)
                            .openRegisterView();
                      },
                      child: const Text(
                        'Register?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Text(
                      'Forget Password?',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Divider(
                  height: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
