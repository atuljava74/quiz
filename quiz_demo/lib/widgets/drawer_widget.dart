import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quiz_demo/core/constant/app_colors.dart';
import 'package:quiz_demo/size_ext.dart';
import 'package:quiz_demo/util.dart';
import 'package:quiz_demo/view_model/auth_view_model.dart';
import 'package:quiz_demo/widgets/custom_progress_bar.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late AuthViewModel _loginViewModel;

  @override
  Widget build(BuildContext context) {
    _loginViewModel = context.watch<AuthViewModel>();
    return WillPopScope(
      onWillPop: _onBackPress,
      child: CustomProgressBar(
        visibility: _loginViewModel.loading,
        child: SizedBox(
          width: double.infinity,
          child: Drawer(
            child: Scaffold(
              backgroundColor: AppColors.primary,
              body: SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.transparent,
                      child: SizedBox(
                        height: 222.Sh,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                height: 203.Sh,
                                width: 193.Sw,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    opacity: 0.2,
                                    image: AssetImage('assets/drawer_bg.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 24.Sw,
                              top: 48.Sh,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white),
                                      ),
                                      child: Icon(
                                        Icons.arrow_back_rounded,
                                        size: 18.Sh,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 12.Sw,
                                      top: 18.Sh,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DottedBorder(
                                          color: Colors.orange,
                                          borderType: BorderType.Circle,
                                          strokeWidth: 2.Sh,
                                          padding: EdgeInsets.zero,
                                          dashPattern: [5, 2],
                                          child: Container(
                                            height: 90.Sh,
                                            width: 90.Sh,
                                            padding: getPadding(all: 5),
                                            child: Container(
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: Image.asset(
                                                "assets/user_icon.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: getPadding(
                                              left: 24, top: 11, bottom: 12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Hi! ${_loginViewModel.user.name}",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 20.Sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Padding(
                                                padding: getPadding(top: 1),
                                                child: Text(
                                                  _loginViewModel.user.email,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontSize: 15.Sp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: getPadding(
                            left: 30, top: 36, right: 30, bottom: 36),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: getBody(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPress() {
    Get.back();
    return Future.value(false);
  }

  getDrawerListItem(
    String title,
    Function onClick, {
    String imagePath = "",
    EdgeInsets? margin,
    Widget? widget,
  }) {
    return Container(
      height: 63.Sh,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      margin: margin,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onClick();
          },
          child: Row(
            children: [
              Container(
                child: widget,
              ),
              Expanded(
                child: Padding(
                  padding: getPadding(
                    left: 21,
                    top: 4,
                    bottom: 2,
                  ),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 17.Sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getBody() {
    return Column(
      children: [

        getDrawerListItem(
          "Logout",
          () {
            _loginViewModel.logoutUser();
          },
          widget: Icon(
            Icons.power_settings_new_rounded,
            color: Colors.red,
            size: 24.Sh,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
