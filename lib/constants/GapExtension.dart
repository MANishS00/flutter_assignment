import 'package:flutter/material.dart';

extension GapExtension on num {
  SizedBox get h => SizedBox(height: toDouble());

  SizedBox get w => SizedBox(width: toDouble());

  SizedBox get gap => SizedBox(width: toDouble(), height: toDouble());
}
