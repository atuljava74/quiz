import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_demo/ui/login_page.dart';
import 'package:quiz_demo/util.dart';
import 'package:quiz_demo/view_model/auth_view_model.dart';
import 'package:quiz_demo/widgets/app_button.dart';
import 'package:quiz_demo/widgets/custom_progress_bar.dart';
import '../core/constant/app_colors.dart';
import '../widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late AuthViewModel _viewModel;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<AuthViewModel>();
    return Scaffold(
      body: CustomProgressBar(
        visibility: _viewModel.loading,
        child: Container(
          padding: getPadding(horizontal: 30),
          height: double.infinity,
          decoration: BoxDecoration(
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
                    child: Column(
                      children: [
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 30,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          margin: getMargin(top: 6),
                          child: Text(
                            "Create an account so you can explore all the\nexisting jobs",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: getMargin(top: 53, bottom: 26),
                    child: CustomTextField(
                      controller: _nameController,
                      hintText: 'Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: getMargin(bottom: 26),
                    child: CustomTextField(
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
                  ),
                  CustomTextField(
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
                  Container(
                    margin: getMargin(top: 26, bottom: 53),
                    child: CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Password and Confirm Password do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  AppButton(
                    title: "Sign Up",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _viewModel.signupUser(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                  ),
                  Container(
                    margin: getMargin(top: 40),
                    child: GestureDetector(
                      onTap: () {
                        Get.offAll(() => LoginPage());
                      },
                      child: Text(
                        "Already have an account",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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
