import 'package:flutter/material.dart';
import 'package:quiz_demo/size_ext.dart';
import 'package:quiz_demo/ui/quiz_page.dart';
import 'package:quiz_demo/ui/streaks_page.dart';
import 'package:quiz_demo/util.dart';
import 'package:quiz_demo/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:quiz_demo/widgets/scaffold_widget.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AuthViewModel _viewModel;
  Duration _delayDuration = Duration(milliseconds: 500);
  Duration _animationDuration = Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    _viewModel = context.watch<AuthViewModel>();
    return ScaffoldWidget(
      title: "Dashboard",
      drawer: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DelayedWidget(
            delayDuration: _delayDuration,
            animationDuration: _animationDuration,
            child: Container(
              margin: getMargin(top: 50, horizontal: 20),
              child: Text(
                "Hello,\n${_viewModel.user.name} 👋",
                style: TextStyle(fontSize: 27.Sp, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          DelayedWidget(
            delayDuration: _delayDuration * 2,
            animationDuration: _animationDuration,
            child: Container(
              height: 150.Sh,
              margin: getMargin(top: 30, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => StreaksPage());
                      },
                      child: getDashboardWidget(
                        "Check Streak",
                        Colors.pink.shade300,
                        Colors.pinkAccent.shade200,
                        'assets/icons/star.svg',
                      ),
                    ),
                  ),
                  SizedBox(width: 10.Sw),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => QuizPage());
                      },
                      child: getDashboardWidget(
                        "Today's Test",
                        Colors.orangeAccent,
                        Colors.orange,
                        'assets/icons/hat.svg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  getDashboardWidget(String text, Color color1, Color color2, icon,
      {png = false}) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 15.Sh,
            right: 15.Sw,
            left: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: color1,
                boxShadow: [
                  BoxShadow(
                    color: color1.withOpacity(0.6),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(25),
              ),
              padding: getPadding(horizontal: 10, bottom: 25),
              alignment: Alignment.bottomLeft,
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 21.Sp),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: getPadding(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: color2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: png
                  ? Image.asset(
                      icon,
                      height: 34.Sh,
                    )
                  : SvgPicture.asset(
                      icon,
                      height: 34.Sh,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
