import 'dart:io';

import 'package:bartr_app/constants/AppButton.dart';
import 'package:bartr_app/constants/AppColors.dart';
import 'package:bartr_app/constants/AppText.dart';
import 'package:bartr_app/constants/GapExtension.dart';
import 'package:bartr_app/features/Screen_1/CategoryModel.dart';
import 'package:bartr_app/features/Screen_2/view_model/describe_view_model.dart';
import 'package:bartr_app/features/Screen_3/confirm_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DescribeScreen extends StatelessWidget {
  final CategoryModel category;

  const DescribeScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DescribeViewModel(category: category),
      child: const DescribeView(),
    );
  }
}

class DescribeView extends StatelessWidget {
  const DescribeView({super.key});

  void showImagePickerSheet(BuildContext context, DescribeViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                20.gap,

                AppText(
                  text: "Upload Image",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                8.gap,

                AppText(
                  text: "Choose how you'd like to add a photo.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                ),

                28.gap,

                Row(
                  children: [
                    Expanded(
                      child: AppButton.outline(
                        text: "Gallery",
                        icon: Icons.photo_library_outlined,
                        onPressed: () {
                          Navigator.pop(context);
                          viewModel.pickFromGallery(
                            onError: (message) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(message)));
                            },
                          );
                        },
                      ),
                    ),

                    14.gap,

                    Expanded(
                      child: AppButton(
                        text: "Camera",
                        icon: Icons.camera_alt,
                        onPressed: () {
                          Navigator.pop(context);
                          viewModel.pickFromCamera(
                            onError: (message) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(message)));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                10.gap,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DescribeViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: AppText(
          text: viewModel.category.title,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 22,
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: "Describe Your Problem",
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  10.gap,
                  AppText(
                    text:
                        "Provide enough details so nearby helpers understand exactly what you need.",
                    fontSize: 13,
                  ),
                ],
              ),
              24.gap,
              buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Description",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    15.gap,
                    TextField(
                      controller: viewModel.descriptionController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText:
                            "Example:\nMy kitchen tap is leaking continuously...",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              24.gap,

              GestureDetector(
                onTap: viewModel.startRecording,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),

                  decoration: BoxDecoration(
                    color: viewModel.isRecording
                        ? Colors.red.shade50
                        : Colors.blue.shade50,

                    borderRadius: BorderRadius.circular(50),

                    border: Border.all(
                      color: viewModel.isRecording ? Colors.red : Colors.blue,
                    ),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedScale(
                        scale: viewModel.isRecording ? 1.2 : 1,
                        duration: const Duration(milliseconds: 500),
                        child: Icon(
                          viewModel.isRecording ? Icons.mic : Icons.mic_none,
                          color: viewModel.isRecording
                              ? Colors.red
                              : Colors.blue,
                        ),
                      ),

                      10.gap,

                      AppText(
                        text: viewModel.isRecording
                            ? "Recording..."
                            : "Start Recording",
                        fontWeight: FontWeight.w600,
                        color: viewModel.isRecording ? Colors.red : Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),

              24.gap,

              buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppText(
                      text: "Photos",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    15.gap,
                    AppButton.outline(
                      text: "Add Photos",
                      onPressed: () => showImagePickerSheet(context, viewModel),
                    ),

                    if (viewModel.selectedImages.isNotEmpty) ...[
                      20.gap,
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.selectedImages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                        itemBuilder: (_, index) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  File(viewModel.selectedImages[index].path),
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: InkWell(
                                  onTap: () => viewModel.removeImageAt(index),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.close,
                                      size: 14,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
              100.gap,
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: SizedBox(
          height: 56,
          child: AppButton(
            text: "Continue",
            onPressed: () {
              if (!viewModel.canContinue) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please give description.")),
                );
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConfirmLocationScreen(
                    category: viewModel.category.title,
                    description: viewModel.descriptionController.text.trim(),
                    images: viewModel.selectedImages
                        .map((e) => e.path)
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
