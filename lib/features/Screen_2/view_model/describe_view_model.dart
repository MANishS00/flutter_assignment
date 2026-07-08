import 'package:bartr_app/features/Screen_1/CategoryModel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DescribeViewModel extends ChangeNotifier {
  final CategoryModel category;
  final TextEditingController descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  List<XFile> _selectedImages = [];
  bool _isRecording = false;

  DescribeViewModel({required this.category}) {
    descriptionController.addListener(_onDescriptionChanged);
  }

  List<XFile> get selectedImages => _selectedImages;
  bool get isRecording => _isRecording;
  bool get canContinue => descriptionController.text.trim().isNotEmpty;

  void _onDescriptionChanged() {
    notifyListeners();
  }

  Future<void> pickFromGallery({required Function(String) onError}) async {
    final images = await _picker.pickMultiImage(imageQuality: 80);

    if (images.isNotEmpty) {
      _selectedImages = images.take(3).toList();
      notifyListeners();

      if (images.length > 3) {
        onError("You can upload a maximum of 3 images.");
      }
    }
  }

  Future<void> pickFromCamera({required Function(String) onError}) async {
    if (_selectedImages.length >= 3) {
      onError("You can upload a maximum of 3 images.");
      return;
    }

    final image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      _selectedImages.add(image);
      notifyListeners();
    }
  }

  void removeImageAt(int index) {
    if (index >= 0 && index < _selectedImages.length) {
      _selectedImages.removeAt(index);
      notifyListeners();
    }
  }

  Future<void> startRecording() async {
    if (_isRecording) return;
    _isRecording = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    descriptionController.text =
        "I need help fixing a leaking tap in my kitchen.";
    _isRecording = false;
    notifyListeners();
  }

  @override
  void dispose() {
    descriptionController.removeListener(_onDescriptionChanged);
    descriptionController.dispose();
    super.dispose();
  }
}
