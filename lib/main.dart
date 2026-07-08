import 'package:bartr_app/features/Screen_1/CategoryScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bartr',
      theme: ThemeData(useMaterial3: true),
      home: const CategoryScreen(),
    );
  }
}
