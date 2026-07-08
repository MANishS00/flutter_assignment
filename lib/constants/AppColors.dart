import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color whiteColor = Color(0xfff7f8fa);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Color(0xfffff8f8), Colors.white, Colors.white],
  );
}
