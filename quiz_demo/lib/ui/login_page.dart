import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_demo/ui/register_page.dart';
import 'package:quiz_demo/util.dart';
import 'package:quiz_demo/view_model/auth_view_model.dart';
import 'package:quiz_demo/widgets/app_button.dart';
import 'package:get/get.dart';
import 'package:quiz_demo/widgets/custom_progress_bar.dart';

import '../core/constant/app_colors.dart';
import '../widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late AuthViewModel _viewModel;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<AuthViewModel>();
    return Scaffold(
      body: CustomProgressBar(
        visibility: _viewModel.loading,
        child: Container(
          padding: getPadding(horizontal: 30),
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login_screen_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: getMargin(top: 140),
                    child: Text(
                      "Login here",
                      style: TextStyle(
                        fontSize: 30,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: getMargin(top: 26, bottom: 74),
                    child: const Text(
                      "Welcome back you’ve\nbeen missed!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: getMargin(vertical: 30),
                    child: CustomTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: getMargin(top: 30, bottom: 40),
                    child: AppButton(
                      title: "Sign in",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _viewModel.signInUser(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const RegisterPage());
                    },
                    child: const Text(
                      "Create new account",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
