import 'package:quiz_demo/core/constant/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:quiz_demo/core/constant/app_strings.dart';
import 'package:quiz_demo/size_ext.dart';
import 'package:quiz_demo/ui/login_page.dart';
import 'package:quiz_demo/ui/register_page.dart';
import 'package:quiz_demo/util.dart';
import 'package:quiz_demo/widgets/app_button.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_screen_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 50.Sh),
            Expanded(
              child: Container(
                margin: getPadding(horizontal: 22),
                child: Image.asset("assets/work.png"),
              ),
            ),
            SizedBox(height: 47.Sh),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to the\nQuiz Challenge!",
                  style: TextStyle(
                      fontSize: 35,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 23.Sh),
                Text(
                  "Are you ready to put your knowledge to the test?\nLet's dive into the ultimate quiz experience!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Container(
              margin: getMargin(vertical: 88),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    title: "Login",
                    onTap: () {
                      GetStorage().write(AppStrings.firstAppOpenSP, true);
                      Get.off(() => LoginPage());
                    },
                  ),
                  AppButton(
                    title: "Register",
                    onTap: () {
                      GetStorage().write(AppStrings.firstAppOpenSP, true);
                      Get.off(() => RegisterPage());
                    },
                    color: Colors.white,
                    textColor: Colors.black,
                    shadow: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
