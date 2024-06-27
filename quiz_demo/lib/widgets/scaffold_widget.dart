import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_demo/core/constant/app_colors.dart';
import 'package:quiz_demo/size_ext.dart';
import 'package:quiz_demo/widgets/drawer_widget.dart';

class ScaffoldWidget extends StatelessWidget {
  String title;
  Widget? titleWidget;
  bool backButton;
  bool showAppBar;
  Widget? leadingIcon;
  Function? leadingClick;
  bool drawer;
  Widget body;
  Widget? floatingActionButton;

  ScaffoldWidget({
    Key? key,
    required this.title,
    this.titleWidget,
    this.backButton = true,
    this.showAppBar = true,
    this.drawer = false,
    required this.body,
    this.leadingIcon,
    this.leadingClick,
    this.floatingActionButton,
  }) : super(key: key);

  GlobalKey bellKey = GlobalKey();

  // final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  Widget build(BuildContext context) {
    print("BUILD HEADER");
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: showAppBar
          ? getAppbar()
          : AppBar(
              backgroundColor: AppColors.scaffoldColor,
              toolbarHeight: 0,
              elevation: 0,
            ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Container(
          //   height: 1.Sh,
          //   color: Colors.grey.shade300,
          // ),
          Expanded(child: body),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  getAppbar() {
    return AppBar(
      automaticallyImplyLeading: true,
      toolbarHeight: 50.Sh,
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: !drawer
          ? backButton
              ? GestureDetector(
                  onTap: () => Get.back(),
                  child: Center(
                    child: Container(
                      height: 30.Sh,
                      width: 30.Sh,
                      // decoration: BoxDecoration(
                      //   shape: BoxShape.circle,
                      //   border: Border.all(color: Colors.grey),
                      // ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20.Sh,
                        ),
                      ),
                    ),
                  ),
                )
              : (leadingIcon != null)
                  ? IconButton(
                      onPressed: () {
                        if (leadingClick == null) return;
                        leadingClick!();
                      },
                      icon: leadingIcon!,
                    )
                  : null
          : Builder(builder: (context) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Center(
                  child: Container(
                    height: 30.Sh,
                    width: 30.Sh,
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.circle,
                    //   border: Border.all(color: Colors.grey),
                    // ),
                    child: Center(
                      child: Icon(
                        Icons.menu_rounded,
                        size: 24.Sh,
                      ),
                    ),
                  ),
                ),
              );
            }),
      title: titleWidget ??
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.Sp,
              fontWeight: FontWeight.w600,
            ),
          ),
    );
  }
}
