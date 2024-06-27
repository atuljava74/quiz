import 'package:quiz_demo/core/constant/app_strings.dart';
import 'package:quiz_demo/ui/home_page.dart';
import 'package:quiz_demo/ui/welcome_page.dart';
import 'package:quiz_demo/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_demo/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      Provider.of<AuthViewModel>(context, listen: false).handleAutoLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    Util.deviceHeight = MediaQuery.of(context).size.height;
    Util.deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Center(
          child: FlutterLogo(
            size: 200,
          ),
        ),
      ),
    );
  }
}
