import 'package:quiz_demo/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:quiz_demo/config_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ConfigScreen());
}
