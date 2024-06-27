import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:quiz_demo/size_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/constant/app_strings.dart';

const USER_INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;
const UNAUTHORISED = 401;

EdgeInsetsGeometry getMargin({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
  double? horizontal,
  double? vertical,
}) {
  if (horizontal != null && horizontal != 0) {
    left = right = horizontal;
  }
  if (vertical != null && vertical != 0) {
    top = bottom = vertical;
  }
  if (all != null) {
    left = all;
    top = all;
    right = all;
    bottom = all;
  }
  return EdgeInsets.only(
    left: left ?? 0,
    top: top ?? 0,
    right: right ?? 0,
    bottom: bottom ?? 0,
  );
}

EdgeInsetsGeometry getPadding({
  double? all,
  double? left,
  double? top,
  double? right,
  double? bottom,
  double? horizontal,
  double? vertical,
}) {
  if (horizontal != null && horizontal != 0) {
    left = right = horizontal;
  }
  if (vertical != null && vertical != 0) {
    top = bottom = vertical;
  }
  if (all != null) {
    left = all;
    top = all;
    right = all;
    bottom = all;
  }
  return EdgeInsets.only(
    left: left ?? 0,
    top: top ?? 0,
    right: right ?? 0,
    bottom: bottom ?? 0,
  );
}

class Util {
  static var mockupHeight = 926;
  static var mockupWidth = 428;
  static var deviceHeight;
  static var deviceWidth;

  static List<BoxShadow> get defaultShadow => [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 8,
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ];

  static getSnackBar(String text,
      {var icon,
      color,
      int duration = 3,
      int delayMilli = 0,
      bool success = false}) async {
    if (!Get.isSnackbarOpen) {
      await Future.delayed(Duration(milliseconds: delayMilli));
      Get.showSnackbar(
        GetSnackBar(
          maxWidth: 600,
          messageText: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 20.Sh),
                  child: Icon(
                      icon ??
                          (success
                              ? Icons.check_circle_outline
                              : Icons.info_outline),
                      color: Colors.white,
                      size: 25.Sh)),
              Expanded(
                child: Util.text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.Sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppStrings.appFontFamily,
                  ),
                ),
              ),
            ],
          ),
          margin: EdgeInsets.fromLTRB(20.Sh, 0, 20.Sh, 20.Sh),
          padding: EdgeInsets.symmetric(vertical: 20.Sh, horizontal: 20.Sh),
          borderRadius: 13.r,
          backgroundColor: color ??
              (success ? Colors.green : const Color.fromRGBO(238, 82, 95, 1)),
          duration: Duration(seconds: duration),
        ),
      );
    }
  }

  static text(String title,
      {TextAlign textAlign = TextAlign.center,
      var alignment,
      style = const TextStyle(),
      margin = EdgeInsets.zero,
      double height = 0.0,
      double width = 0.0,
      overflow = TextOverflow.ellipsis,
      maxLines = 0}) {
    return Container(
      width: (width == 0.0) ? null : width,
      margin: margin,
      alignment:
          (alignment != null) ? alignment : alignmentByTextAlign(textAlign),
      child: Text(
        title,
        textAlign: textAlign,
        style: style,
        textScaleFactor: 1.0,
        overflow: overflow,
        maxLines: (maxLines == 0) ? 100 : maxLines,
      ),
    );
  }

  static richText(String text1, String text2,
      {TextAlign textAlign = TextAlign.center,
      style1 = const TextStyle(),
      style2 = const TextStyle(),
      margin = EdgeInsets.zero,
      double height = 0.0,
      overflow = TextOverflow.ellipsis,
      maxLines}) {
    return Container(
      margin: margin,
      alignment: alignmentByTextAlign(textAlign),
      child: RichText(
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(text: text1, style: style1),
            TextSpan(text: text2, style: style2),
          ],
        ),
      ),
    );
  }

  static alignmentByTextAlign(TextAlign textAlign) {
    switch (textAlign) {
      case TextAlign.left:
        return Alignment.centerLeft;
      case TextAlign.right:
        return Alignment.centerRight;
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.justify:
        return Alignment.bottomCenter;
      case TextAlign.start:
        return Alignment.centerLeft;
      case TextAlign.end:
        return Alignment.centerRight;
    }
  }

  static parseDateTime(dynamic dateTimeIst, {bool changeToIst = true}) {
    if (dateTimeIst == null) return AppStrings.NA;
    if ((DateTime.tryParse(dateTimeIst) ?? AppStrings.NA) is DateTime) {
      if (changeToIst) {
        var d = DateTime.parse(dateTimeIst);
        return d;
      } else {
        return DateTime.parse(dateTimeIst);
      }
    } else {
      return AppStrings.NA;
    }
  }

  static double getHeight(var height) {
    var percent = ((height / mockupHeight) * 100);
    return ((deviceHeight * percent) / 100);
  }

  static double getWidth(var width) {
    var percent = ((width / mockupWidth) * 100);
    return ((deviceWidth * percent) / 100);
  }

  static double getSp(var sp) {
    var percent = (((sp - 0.25) / mockupHeight) * 100);
    return ((deviceHeight * percent) / 100);
  }

  static double getRadius(var radius) {
    return double.parse(radius.toString());
  }

  static printString(var v) {
    print(v);
  }

  static printLog(var v) {
    log(v);
  }
}
