import 'package:bartr_app/constants/AppColors.dart';
import 'package:bartr_app/constants/AppText.dart';
import 'package:bartr_app/constants/GapExtension.dart';
import 'package:bartr_app/features/Screen_1/CategoryModel.dart';
import 'package:bartr_app/features/Screen_1/widgets/CategoryCard.dart';
import 'package:bartr_app/features/Screen_2/describe_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: AppText(text: "Our Services", color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 22),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(22)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: "Need Professional Help?", fontSize: 24, fontWeight: FontWeight.bold),
                  10.gap,
                  AppText(text: "Choose the category that best matches your service request.", fontSize: 15),
                ],
              ),
            ),

            20.gap,

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                  childAspectRatio: .92,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 400 + (index * 100)),
                    tween: Tween(begin: 30.0, end: 0.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, value),
                        child: Opacity(opacity: 1 - value / 30, child: child),
                      );
                    },
                    child: GestureDetector(
                      child: CategoryCard(
                        category: category,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => DescribeScreen(category: category)));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
