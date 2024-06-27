import 'package:flutter/material.dart';
import 'package:quiz_demo/core/constant/app_colors.dart';
import 'package:quiz_demo/size_ext.dart';
import 'package:quiz_demo/ui/quiz_page.dart';
import 'package:quiz_demo/util.dart';
import 'package:quiz_demo/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:quiz_demo/widgets/scaffold_widget.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StreaksPage extends StatefulWidget {
  const StreaksPage({Key? key}) : super(key: key);

  @override
  State<StreaksPage> createState() => _StreaksPageState();
}

class _StreaksPageState extends State<StreaksPage> {
  late AuthViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<AuthViewModel>();
    return ScaffoldWidget(
      title: "Streaks",
      body: Container(
        margin: getMargin(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: getMargin(top: 20),
              child: getStreakUI(),
            ),
            Container(
              child: Text(
                "Days Streak",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.Sp, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              margin: getMargin(top: 0, horizontal: 20),
              child: Text(
                "You're doing really great, ${_viewModel.user.name}!\nKeep it up",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.Sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            getStatsUI(),
          ],
        ),
      ),
    );
  }

  getStreakUI() {
    return Container(
      height: 245.Sh,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 45.Sh,
            child: Container(
              padding: getPadding(all: 40),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  shape: BoxShape.circle),
              child: SvgPicture.asset(
                'assets/icons/fire2.svg',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Text(
                _viewModel.user.currentStreak.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 70.Sp, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getStatsUI() {
    return Container(
      margin: getMargin(top: 50),
      padding: getPadding(all: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: getPadding(top: 8, bottom: 10),
            child: Text(
              "Your Stats",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15.Sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: getPadding(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                getStatItem("Total Quiz", _viewModel.user.totalQuizAttempted.toString()),
                Container(height: 50.Sh, width: 1.Sw, color: Colors.grey.shade300),
                getStatItem("Correct", _viewModel.user.correctAttempts.toString()),
                Container(height: 50.Sh, width: 1.Sw, color: Colors.grey.shade300),
                getStatItem("Incorrect", (_viewModel.user.totalQuizAttempted - _viewModel.user.correctAttempts).toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getStatItem(String title, String value) {
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: getMargin(bottom: 10),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 14.Sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22.Sp,
            ),
          ),
        ],
      ),
    );
  }
}
