import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_demo/disposable_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_demo/models/question_model.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:quiz_demo/models/user_model.dart';
import 'package:quiz_demo/util.dart';
import 'package:quiz_demo/view_model/auth_view_model.dart';
import 'package:quiz_demo/widgets/app_dialog.dart';

class QuizViewModel extends DisposableProvider {
  bool _loading = true;
  int selectedOptionIndex = -1;
  QuestionModel question =
      QuestionModel(id: -1, question: "", options: [], correctAnswer: -1);

  bool get loading => _loading;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  init() {
    UserModel user =
        Provider.of<AuthViewModel>(Get.context!, listen: false).user;
    if (isSameDay(user.lastAttemptDate, DateTime.now())) {
      _loading = false;
      Get.back();
      Get.dialog(
        AppDialog(
          title: "Quiz already taken",
          subTitle:
              "You have already attempted today's quiz. Please come back tomorrow for another test.",
          icon: "assets/icons/tick_file.svg",
          buttonText: "Continue",
        ),
      );
      notifyListeners();
    } else {
      getQuestion();
    }
  }

  getQuestion() async {
    setLoading(true);
    CollectionReference mcqQuestions =
        FirebaseFirestore.instance.collection('mcqQuestions');
    QuerySnapshot querySnapshot = await mcqQuestions.limit(30).get();
    Random random = Random();
    int randomIndex = random.nextInt(querySnapshot.docs.length);
    DocumentSnapshot randomDocument = querySnapshot.docs[randomIndex];
    question =
        QuestionModel.fromJson(randomDocument.data() as Map<String, dynamic>);
    print(question.toJson());
    setLoading(false);
  }

  Future<bool> updateUserAttempt() async {
    UserModel user =
        Provider.of<AuthViewModel>(Get.context!, listen: false).user;
    try {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(user.id);

      await FirebaseFirestore.instance.runTransaction(
        (transaction) async {
          DocumentSnapshot snapshot = await transaction.get(userDoc);

          if (!snapshot.exists) {
            Util.getSnackBar("User does not exist!");
            return false;
          }

          transaction.update(
            userDoc,
            (question.correctAnswer == selectedOptionIndex)
                ? {
                    'lastAttemptDate': FieldValue.serverTimestamp(),
                    'currentStreak': FieldValue.increment(1),
                    'totalQuizAttempted': FieldValue.increment(1),
                    'correctAttempts': FieldValue.increment(1),
                  }
                : {
                    'lastAttemptDate': FieldValue.serverTimestamp(),
                    'currentStreak': FieldValue.increment(1),
                    'totalQuizAttempted': FieldValue.increment(1),
                  },
          );
        },
      );
    } catch (e) {
      Util.getSnackBar("Please try again later");
      return false;
    }
    await Provider.of<AuthViewModel>(Get.context!, listen: false).updateUser();
    return true;
  }

  submitQuestion() async {
    setLoading(true);
    bool status = await updateUserAttempt();
    if (status) {
      Get.back();
      if (question.correctAnswer == selectedOptionIndex) {
        Get.dialog(
          AppDialog(
            title: "Congratulations!!",
            subTitle:
                "You have successfully completed the quiz. Please come back tomorrow to take another quiz.",
            icon: "assets/icons/tick_icon.svg",
            buttonText: "Continue",
          ),
        );
      } else {
        Get.dialog(
          AppDialog(
            title: "Incorrect Answer",
            subTitle:
                "That's not the correct answer. Please return tomorrow to take another quiz. Your streak will be maintained regardless of the quiz result.",
            icon: "assets/icons/cross_icon.svg",
            iconColor: Colors.red,
            buttonText: "Continue",
          ),
        );
      }
    }
  }

  void selectOption(int index) {
    selectedOptionIndex = index;
    notifyListeners();
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  void disposeValues() {
    _loading = true;
    selectedOptionIndex = -1;
    question =
        QuestionModel(id: -1, question: "", options: [], correctAnswer: -1);
  }
}
