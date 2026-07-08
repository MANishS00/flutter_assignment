import 'package:bartr_app/constants/AppButton.dart';
import 'package:bartr_app/constants/AppColors.dart';
import 'package:bartr_app/constants/AppText.dart';
import 'package:bartr_app/constants/GapExtension.dart';
import 'package:bartr_app/features/Screen_1/CategoryScreen.dart';
import 'package:bartr_app/features/Screen_4/view_model/matching_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MatchingViewModel(),
      child: const MatchingView(),
    );
  }
}

class MatchingView extends StatelessWidget {
  const MatchingView({super.key});

  void _goHome(BuildContext context, MatchingViewModel viewModel) {
    viewModel.goHome(
      onShowMessage: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Request Successfully Sent 🎉"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      onNavigate: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const CategoryScreen()),
          (route) => false,
        );
      },
    );
  }

  Future<void> _cancelRequest(BuildContext context) async {
    final cancel = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                    size: 36,
                  ),
                ),

                20.gap,

                AppText(
                  text: "Cancel Request?",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),

                12.gap,

                AppText(
                  text:
                      "Are you sure you want to cancel finding a helper?\nYour request will not be sent.",
                  textAlign: TextAlign.center,
                  color: Colors.grey.shade600,
                ),

                28.gap,

                Row(
                  children: [
                    Expanded(
                      child: AppButton.outline(
                        text: "Keep Search",
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                    ),

                    12.gap,

                    Expanded(
                      child: AppButton(
                        text: "Cancel",
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (cancel == true && context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MatchingViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: AppText(
            key: ValueKey(viewModel.isSearching),
            text: viewModel.isSearching ? "Finding Helper" : "Helper Found",
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            child: viewModel.isSearching
                ? _searchingView(context, viewModel)
                : _matchedView(context, viewModel),
          ),
        ),
      ),
    );
  }

  Widget _searchingView(BuildContext context, MatchingViewModel viewModel) {
    return Padding(
      key: const ValueKey("search"),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),

          SizedBox(
            height: 230,
            child: Lottie.asset("assets/lottie/Search.json", repeat: true),
          ),
          25.gap,
          AppText(
            text: "Finding Nearby Helpers",
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          12.gap,

          AppText(
            text:
                "We're notifying nearby helpers.\nThis usually takes less than a minute.",
            textAlign: TextAlign.center,
            color: Colors.grey.shade600,
            fontSize: 15,
          ),

          30.gap,

          LinearProgressIndicator(
            minHeight: 8,
            borderRadius: BorderRadius.circular(20),
            backgroundColor: Colors.grey.shade300,
            color: AppColors.primaryColor,
          ),

          25.gap,

          const Spacer(),

          AppButton.outline(
            text: "Cancel Request",
            onPressed: () => _cancelRequest(context),
          ),
        ],
      ),
    );
  }

  Widget _matchedView(BuildContext context, MatchingViewModel viewModel) {
    return Padding(
      key: const ValueKey("matched"),
      padding: const EdgeInsets.all(24),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeOutBack,
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, child) {
          return Opacity(
            opacity: value.clamp(0.0, 1.0),
            child: Transform.translate(
              offset: Offset(0, 120 * (1 - value)),
              child: Transform.scale(
                scale: 0.85 + (0.15 * value),
                child: child,
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(
                      Icons.person,
                      size: 42,
                      color: AppColors.whiteColor,
                    ),
                  ),

                  15.gap,

                  AppText(
                    text: " Rajesh Kumar ",
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),

                  8.gap,
                  AppText(
                    text: " +91 9876543210 ",
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  9.gap,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.orange.shade400),
                      5.gap,
                      AppText(text: "4.8", fontWeight: FontWeight.bold),
                      15.gap,
                      const Icon(Icons.work_outline, size: 18),
                      const SizedBox(width: 5),
                      AppText(text: "23 Jobs"),
                    ],
                  ),

                  15.gap,

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(.08),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on, color: AppColors.primaryColor),
                        6.gap,
                        AppText(
                          text: "1.2 km Away",
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            35.gap,

            SizedBox(
              width: double.infinity,
              child: AppButton(
                text: "Continue",
                onPressed: () => _goHome(context, viewModel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
