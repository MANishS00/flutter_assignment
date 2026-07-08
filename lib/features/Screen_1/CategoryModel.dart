import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final IconData icon;

  const CategoryModel({required this.title, required this.icon});
}

const List<CategoryModel> categories = [
  CategoryModel(title: "Plumbing", icon: Icons.plumbing),
  CategoryModel(title: "Electrical", icon: Icons.electrical_services),
  CategoryModel(title: "Locksmith", icon: Icons.key),
  CategoryModel(title: "Tutoring", icon: Icons.school),
  CategoryModel(title: "Errands", icon: Icons.shopping_bag),
  CategoryModel(title: "Welder", icon: Icons.construction),
  CategoryModel(title: "Other", icon: Icons.more_horiz),
];
