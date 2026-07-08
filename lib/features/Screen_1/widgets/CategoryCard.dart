import 'package:bartr_app/constants/AppColors.dart';
import 'package:bartr_app/constants/AppText.dart';
import 'package:bartr_app/constants/GapExtension.dart';
import 'package:bartr_app/features/Screen_1/CategoryModel.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryCard({super.key, required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(45),
      elevation: 2,
      shadowColor: Colors.black12,
      child: Ink(
        decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(28)),
        child: InkWell(
          borderRadius: BorderRadius.circular(45),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.primaryColor.withOpacity(.1),
                  child: Icon(category.icon, size: 34, color: AppColors.primaryColor),
                ),
                18.gap,
                AppText(text: category.title, textAlign: TextAlign.center, fontSize: 17, fontWeight: FontWeight.w600),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
