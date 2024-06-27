import 'package:flutter/material.dart';

class AppColors {
  static Color gray800 = fromHex('#343e42');
  static Color white = fromHex('#ffffff');
  static Color gray600 = fromHex('#676e71');
  static Color blueGray5002 = fromHex('#e8eef3');
  static Color gray100 = fromHex('#f7f7f7');
  static Color yellow70033 = fromHex('#33edbc2c');
  static Color primary = fromHex('#1F41BB');
  static Color skyblueF8F9FF = fromHex('#F8F9FF');
  static Color whiteFFFFFF = fromHex('#FFFFFF');
  static Color black0A0A0A = fromHex('#0A0A0A');
  static Color secondary = fromHex('#F1F4FF');
  static Color textSecondary = fromHex('#626262');
  static Color blueshadowCBD6FF = fromHex('#CBD6FF');
  static Color scaffoldColor = Colors.white;

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

}