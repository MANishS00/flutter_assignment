import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color whiteColor = Color(0xfff7f8fa);
  static const Color blackColor = Color.fromARGB(255, 0, 0, 0);
  static const Color primaryColor = Color(0xffe34041);
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xfffff8f8), Colors.white, Colors.white],
  );
}
