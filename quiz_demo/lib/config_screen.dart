import 'package:quiz_demo/core/constant/app_strings.dart';
import 'package:quiz_demo/splash_screen.dart';
import 'package:quiz_demo/view_model/quiz_view_model.dart';
import 'package:quiz_demo/view_model/auth_view_model.dart';
import 'package:quiz_demo/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ConfigScreen extends StatefulWidget {
  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => QuizViewModel()),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          fontFamily: AppStrings.appFontFamily
        ),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        home: SplashScreen(),
      ),
    );
  }
}
