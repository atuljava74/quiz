import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_demo/core/constant/app_colors.dart';
import 'package:quiz_demo/size_ext.dart';
import 'package:quiz_demo/util.dart';

class AppDialog extends StatefulWidget {
  String title;
  String subTitle;
  String icon;
  Color iconColor;
  String buttonText;

  AppDialog({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.iconColor = Colors.green,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: IntrinsicHeight(
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: getMargin(top: 30),
                child: SvgPicture.asset(
                  widget.icon,
                  height: 70.Sh,
                  color: widget.iconColor,
                ),
              ),
              Container(
                margin: getMargin(top: 30, bottom: 10, horizontal: 20),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.Sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: getMargin(bottom: 40, horizontal: 20),
                child: Text(
                  widget.subTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.Sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary),
                ),
              ),
              Material(
                color: AppColors.primary,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: getPadding(vertical: 15, horizontal: 52),
                    child: Text(
                      widget.buttonText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.Sp,
                        fontWeight: FontWeight.w600,
                      ),
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
}
