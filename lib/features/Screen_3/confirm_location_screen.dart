import 'package:bartr_app/constants/AppButton.dart';
import 'package:bartr_app/constants/AppColors.dart';
import 'package:bartr_app/constants/AppText.dart';
import 'package:bartr_app/constants/GapExtension.dart';
import 'package:bartr_app/features/Screen_4/MatchingScreen.dart';
import 'package:flutter/material.dart';

class ConfirmLocationScreen extends StatelessWidget {
  final String category;
  final String description;
  final List<String> images;

  const ConfirmLocationScreen({
    super.key,
    required this.category,
    required this.description,
    required this.images,
  });

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: AppText(
          text: "Confirm Location",
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 22,
        ),
        centerTitle: true,
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: SizedBox(
          height: 55,
          child: AppButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MatchingScreen()),
              );
            },
            text: 'Confirm & Send',
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "Verify where you need help",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),

            8.gap,

            AppText(
              text: "Please confirm your location before sending the request.",
              color: Colors.grey.shade600,
              fontSize: 13,
            ),

            28.gap,

            _card(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                  ),
                  16.gap,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "Current Location",
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        5.gap,
                        AppText(
                          text: "Hingna Road",
                          color: Colors.grey.shade600,
                        ),
                        AppText(
                          text: "Nagpur MH 441110",
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: AppColors.primaryColor),
                ],
              ),
            ),

            28.gap,

            AppText(
              text: "Request Summary",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),

            16.gap,
            _card(
              child: Column(
                children: [
                  _summaryTile(
                    icon: Icons.category_outlined,
                    title: "Category",
                    value: category,
                  ),
                  const Divider(height: 28),
                  _summaryTile(
                    icon: Icons.notes_outlined,
                    title: "Description",
                    value: description,
                  ),
                  const Divider(height: 28),
                  _summaryTile(
                    icon: Icons.photo_library_outlined,
                    title: "Photos",
                    value: "${images.length} Attached",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primaryColor),
          16.gap,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: title, color: Colors.grey, fontSize: 13),
                4.gap,
                AppText(
                  text: value,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
