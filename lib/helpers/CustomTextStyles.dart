import 'package:flutter/material.dart';

class CustomTextStyles {
  static TextStyle dialogTitleBlack() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 34, 34, 34),
    );
  }

  static TextStyle mediumBlack() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Color.fromARGB(255, 34, 34, 34),
    );
  }

  static TextStyle mediumWhite() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.white
    );
  }

  static TextStyle mediumBlackBold() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 34, 34, 34),
    );
  }

  static TextStyle calendarLetters() {
    return const TextStyle(
      fontSize: 30,
      fontFamily: 'RobotoCondensed-Bold',
    );
  }

  static TextStyle calendarNumber() {
    return const TextStyle(
        fontSize: 80,
        fontFamily: 'RobotoCondensed-ExtraBoldItalic',
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold);
  }

  static TextStyle buttonsTextBlack() {
    return const TextStyle(
      fontSize: 17,
      fontFamily: 'RobotoCondensed-Medium',
      //fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 34, 34, 34),
    );
  }

  static TextStyle buttonsTextWhite() {
    return const TextStyle(
      fontSize: 18,
      fontFamily: 'RobotoCondensed-Medium',
      fontWeight: FontWeight.bold,
    );
  }
}
