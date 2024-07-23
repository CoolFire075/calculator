import 'package:flutter/material.dart';

class AppStyles {
  static const buttonStyle = ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(Colors.white24),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    ),
  );

  static const String divisionAssetName = 'assets/icons/ic_division.svg';
  static const numberColor = Colors.white;
  static const iconColor = Colors.white24;
  static const actionColor = Colors.orange;
  static const numberSize = 60.0;
}
