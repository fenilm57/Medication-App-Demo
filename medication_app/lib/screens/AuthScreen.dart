import 'package:flutter/material.dart';
import 'package:medication_app/widgets/CustomButton.dart';
import 'package:medication_app/widgets/CustomPasssword.dart';
import 'package:medication_app/widgets/CustomTextField.dart';

import 'home_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication App'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            controller: emailController,
            hintText: "Enter Username",
            initialValue: '',
          ),
          CustomPass(
            obscureText: true,
            controller: passwordController,
            hintText: "Enter Password",
            initialValue: '',
            textInputType: TextInputType.visiblePassword,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomElevatedButton(
            text: 'Login',
            onPressed: () {
              if (emailController.text == '' || passwordController.text == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter email and password'),
                  ),
                );
                return;
              }

              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const HomePage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
