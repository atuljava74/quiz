import 'package:flutter/material.dart';
import '../../core/constant/app_colors.dart';

class CustomProgressBar extends StatefulWidget {
  final bool visibility;
  final Widget child;
  final bool blurBg;

  CustomProgressBar({
    Key? key,
    required this.visibility,
    required this.child,
    this.blurBg = true,
  }) : super(key: key);

  @override
  _CustomProgressBarState createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.visibility,
      child: Stack(
        children: [
          widget.child,
          Visibility(
            visible: (widget.blurBg && widget.visibility),
            child: Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          Positioned.fill(
            child: Center(
              child: Visibility(
                visible: widget.visibility,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
