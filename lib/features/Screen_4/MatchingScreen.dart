import 'dart:async';

import 'package:bartr_app/features/Screen_1/CategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MatchingScreen extends StatefulWidget {
  const MatchingScreen({super.key});

  @override
  State<MatchingScreen> createState() => _MatchingScreenState();
}

class _MatchingScreenState extends State<MatchingScreen> {
  bool _isSearching = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;

      setState(() {
        _isSearching = false;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _goHome() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Request Successfully Sent 🎉"),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const CategoryScreen()),
        (route) => false,
      );
    });
  }

  Future<void> _cancelRequest() async {
    final cancel = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Cancel Request?"),
          content: const Text(
            "Are you sure you want to cancel finding a Helper?",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );

    if (cancel == true && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),
      appBar: AppBar(title: const Text("Finding Helper"), centerTitle: true),
      body: SafeArea(
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            child: _isSearching ? _searchingView() : _matchedView(),
          ),
        ),
      ),
    );
  }

  Widget _searchingView() {
    return Padding(
      key: const ValueKey("search"),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),

          SizedBox(
            height: 250,
            child: Lottie.asset("assets/lottie/Search.json", repeat: true),
          ),

          const SizedBox(height: 20),

          const Text(
            "Finding Nearby Helpers",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Text(
            "Notifying nearby Helpers...",
            style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
          ),

          const SizedBox(height: 8),

          Text(
            "This usually takes only a few seconds.",
            style: TextStyle(color: Colors.grey.shade500),
          ),

          const Spacer(),

          OutlinedButton(
            onPressed: _cancelRequest,
            child: const Text("Cancel"),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _matchedView() {
    return Center(
      key: const ValueKey("matched"),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 600),
          tween: Tween(begin: 0, end: 1),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 80 * (1 - value)),
              child: Opacity(opacity: value, child: child),
            );
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "🎉 Helper Found",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Sarah Johnson",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 8),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.orange),

                      SizedBox(width: 6),

                      Text(
                        "4.8",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(width: 10),

                      Text("23 Jobs"),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.red),

                      SizedBox(width: 4),

                      Text("1.2 km Away"),
                    ],
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _goHome,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(52),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Continue"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
