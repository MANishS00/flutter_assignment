import 'dart:io';

import 'package:bartr_app/features/Screen_1/CategoryModel.dart';
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
  List<XFile> selectedImages = [];
  bool isRecording = false;
  final ImagePicker picker = ImagePicker();
  File? image;

  Future<void> pickImages() async {
    final images = await picker.pickMultiImage(imageQuality: 80);

    if (images.isNotEmpty) {
      setState(() {
        selectedImages = images;
      });
    }
  }

  Future<void> startRecording() async {
    if (isRecording) return;

    setState(() {
      isRecording = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    _descriptionController.text = "I need help fixing a leaking tap.";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(title: Text(widget.category.title)),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Describe your problem",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Provide enough detail so nearby helpers know exactly what you need.",
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 24),

            TextField(
              controller: _descriptionController,
              maxLines: 6,
              onChanged: (_) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Describe your problem...",
                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.all(18),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: startRecording,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),

                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),

                decoration: BoxDecoration(
                  color: isRecording ? Colors.red.shade50 : Colors.blue.shade50,

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

                    const SizedBox(width: 10),

                    Text(
                      isRecording ? "Recording..." : "Start Recording",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isRecording ? Colors.red : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Attachments",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(height: 12),

            OutlinedButton.icon(
              onPressed: pickImages,
              icon: const Icon(Icons.attach_file),
              label: const Text("Choose Photos"),
            ),
            if (selectedImages.isNotEmpty) ...[
              const SizedBox(height: 16),

              const Text(
                "Selected Files",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ...selectedImages
                  .take(3)
                  .map(
                    (file) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          const Icon(Icons.image, size: 18),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Text(
                              file.name,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

              if (selectedImages.length > 3)
                Padding(
                  padding: const EdgeInsets.only(left: 26),
                  child: Text(
                    "+${selectedImages.length - 3} more",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: _descriptionController.text.trim().isEmpty
                ? null
                : () {},
            child: const Text("Send Request"),
          ),
        ),
      ),
    );
  }
}
