import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sajilo_sales/features/auth/presentation/widget/main_button.dart';
import 'package:sajilo_sales/features/auth/domain/entity/auth_entity.dart';
import 'package:sajilo_sales/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../widget/custom_formfield.dart';

class RegisterView extends ConsumerWidget {
  final _fnameController = TextEditingController(text: 'Shishir');
  final _lnameController = TextEditingController(text: 'Sharma');
  final _address = TextEditingController(text: 'Anamnagar');
  final _emailController = TextEditingController(text: 'hello@mail.com');
  final _passwordController = TextEditingController(text: 'shishir123');

  RegisterView({super.key});

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
                  'Register',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  textEditingController: _fnameController,
                  labelText: 'First Name',
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
                  textEditingController: _lnameController,
                  labelText: 'LastName',
                  validator: (value) {
                    // Add your validation logic here
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  inputType: TextInputType.name,
                ),
                CustomFormField(
                  textEditingController: _lnameController,
                  labelText: 'Address',
                  validator: (value) {
                    // Add your validation logic here
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  inputType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                CustomFormField(
                  textEditingController: _emailController,
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
                  textEditingController: _passwordController,
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
                  onPressed: () {
                    var user = AuthEntity(
                        fname: _fnameController.text,
                        lname: _lnameController.text,
                        address: _address.text,
                        email: _emailController.text,
                        password: _passwordController.text);
                    ref
                        .read(authViewModelProvider.notifier)
                        .registerAccount(user);
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Login?',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
