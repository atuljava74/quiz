import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_demo/core/constant/app_strings.dart';
import 'package:quiz_demo/models/user_model.dart';
import 'package:quiz_demo/ui/home_page.dart';
import 'package:quiz_demo/ui/login_page.dart';
import 'package:quiz_demo/ui/welcome_page.dart';
import 'package:quiz_demo/util.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthViewModel extends ChangeNotifier {
  bool _loading = false;
  UserModel user = UserModel(
    id: "",
    name: "",
    email: "",
    lastAttemptDate: DateTime.now(),
    currentStreak: 0,
    totalQuizAttempted: 0,
    correctAttempts: 0,
  );

  bool get loading => _loading;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  updateUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      notifyListeners();
    } else {
      return null;
    }
  }

  checkForBrokenStreak() async {
    if (FirebaseAuth.instance.currentUser != null) {
      DocumentReference docRef = FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid);

      if (isStreakBroken(user.lastAttemptDate, DateTime.now())) {
        await docRef.update({"currentStreak": 0});
        await updateUser();
      }
    }
  }

  bool isStreakBroken(DateTime firstDateTime, DateTime secondDateTime) {
    DateTime firstDate =
        DateTime(firstDateTime.year, firstDateTime.month, firstDateTime.day);
    DateTime secondDate =
        DateTime(secondDateTime.year, secondDateTime.month, secondDateTime.day);

    Duration difference = secondDate.difference(firstDate);
    int differenceInDays = difference.inDays;
    print("differenceInDays ${differenceInDays}");

    return differenceInDays > 1;
  }

  signupUser(String name, String email, String password) async {
    // name = "Test User";
    // email = "test@gmail.com";
    // password = "12345678";
    setLoading(true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'id': userCredential.user!.uid,
        'email': email,
        'name': name,
        'lastAttemptDate':
            Timestamp.fromDate(DateTime.now().subtract(Duration(days: 5))),
        'currentStreak': 0,
        'totalQuizAttempted': 0,
        'correctAttempts': 0,
      });
      await updateUser();
      Util.getSnackBar('Registration Successful', success: true);
      Get.offAll(() => HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Util.getSnackBar('Password Provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        Util.getSnackBar('Email Provided already Exists');
      }
    } catch (e) {
      print(e.toString());
      Util.getSnackBar(e.toString());
    }
    setLoading(false);
  }

  signInUser(String email, String password) async {
    setLoading(true);
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await updateUser();
      Get.offAll(() => HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Util.getSnackBar('No user Found with this Email');
      } else if (e.code == 'wrong-password') {
        Util.getSnackBar('Password did not match');
      } else {
        Util.getSnackBar(e.message ?? "Please check you login credentials");
      }
    }
    setLoading(false);
  }

  Future<void> handleAutoLogin() async {
    if (GetStorage().read(AppStrings.firstAppOpenSP) != true) {
      Get.offAll(() => WelcomePage());
    } else if (FirebaseAuth.instance.currentUser != null) {
      await updateUser();
      await checkForBrokenStreak();
      Get.offAll(() => HomePage());
    } else {
      Get.offAll(() => LoginPage());
    }
  }

  Future<void> logoutUser() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginPage());
  }
}
