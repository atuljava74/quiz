import 'package:flutter/material.dart';
import 'package:quiz_demo/core/constant/app_colors.dart';
import 'package:quiz_demo/util.dart';

class AppButton extends StatefulWidget {
  final String title;
  final Color? color;
  final Color textColor;
  final bool shadow;
  final VoidCallback onTap;

  const AppButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.shadow = true,
    this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: widget.shadow ? [
          BoxShadow(
            color: AppColors.fromHex("#CBD6FF"),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ] : [],
      ),
      child: Material(
        color: widget.color ?? AppColors.primary,
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            padding: getPadding(vertical: 15, horizontal: 52),
            child: Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
