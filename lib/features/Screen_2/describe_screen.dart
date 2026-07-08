import 'dart:io';

import 'package:bartr_app/constants/AppButton.dart';
import 'package:bartr_app/constants/AppColors.dart';
import 'package:bartr_app/constants/AppText.dart';
import 'package:bartr_app/constants/GapExtension.dart';
import 'package:bartr_app/features/Screen_1/CategoryModel.dart';
import 'package:bartr_app/features/Screen_3/confirm_location_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DescribeScreen extends StatefulWidget {
  final CategoryModel category;

  const DescribeScreen({super.key, required this.category});

  @override
  State<DescribeScreen> createState() => _DescribeScreenState();
}

class _DescribeScreenState extends State<DescribeScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  List<XFile> selectedImages = [];
  bool isRecording = false;

  Future<void> pickFromGallery() async {
    final images = await picker.pickMultiImage(imageQuality: 80);

    if (images.isNotEmpty) {
      setState(() {
        selectedImages = images.take(3).toList();
      });

      if (images.length > 3 && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("You can upload a maximum of 3 images."),
          ),
        );
      }
    }
  }

  Future<void> pickFromCamera() async {
    if (selectedImages.length >= 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You can upload a maximum of 3 images.")),
      );
      return;
    }

    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        selectedImages.add(image);
      });
    }
  }

  void showImagePickerSheet() {
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          pickFromGallery();
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
                          pickFromCamera();
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

  Future<void> startRecording() async {
    if (isRecording) return;
    setState(() {
      isRecording = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    _descriptionController.text =
        "I need help fixing a leaking tap in my kitchen.";
    setState(() {
      isRecording = false;
    });
  }

  bool get canContinue => _descriptionController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    _descriptionController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Widget buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
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
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: AppText(
          text: widget.category.title,
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
                      controller: _descriptionController,
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
                onTap: startRecording,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),

                  decoration: BoxDecoration(
                    color: isRecording
                        ? Colors.red.shade50
                        : Colors.blue.shade50,

                    borderRadius: BorderRadius.circular(50),

                    border: Border.all(
                      color: isRecording ? Colors.red : Colors.blue,
                    ),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedScale(
                        scale: isRecording ? 1.2 : 1,
                        duration: const Duration(milliseconds: 500),
                        child: Icon(
                          isRecording ? Icons.mic : Icons.mic_none,
                          color: isRecording ? Colors.red : Colors.blue,
                        ),
                      ),

                      10.gap,

                      AppText(
                        text: isRecording ? "Recording..." : "Start Recording",
                        fontWeight: FontWeight.w600,
                        color: isRecording ? Colors.red : Colors.blue,
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
                      onPressed: showImagePickerSheet,
                    ),

                    if (selectedImages.isNotEmpty) ...[
                      20.gap,
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: selectedImages.length,
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
                                  File(selectedImages[index].path),
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedImages.removeAt(index);
                                    });
                                  },
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
              if (!canContinue) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please give description.")),
                );
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConfirmLocationScreen(
                    category: widget.category.title,
                    description: _descriptionController.text.trim(),
                    images: selectedImages.map((e) => e.path).toList(),
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
