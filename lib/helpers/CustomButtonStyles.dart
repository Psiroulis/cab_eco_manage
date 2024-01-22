import 'package:cab_economics/helpers/CustomTextStyles.dart';
import 'package:flutter/material.dart';

class CustomButtonStyles {
  static ButtonStyle customButtons(MaterialColor color) {
    return ButtonStyle(
      textStyle: MaterialStateProperty.all(
        CustomTextStyles.buttonsTextWhite(),
      ),
      backgroundColor: MaterialStateProperty.all(
        color,
      ),
      foregroundColor: MaterialStateProperty.all(
        Colors.white,
      ),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
