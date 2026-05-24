import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../data/cv_repository.dart';

enum AnimalType { cattle, cat, chicken }

enum ScanStatus { idle, loading, success, failure }

class CvScanController extends GetxController {
  final CvRepository _repo = CvRepository();
  final _picker = ImagePicker();

  final selectedAnimalType = AnimalType.cat.obs;
  final scanStatus = ScanStatus.idle.obs;
  final pickedImage = Rx<File?>(null);
  final resultLabel = ''.obs;
  final resultConfidence = 0.0.obs;
  final resultDetails = <String, dynamic>{}.obs;

  bool _isPickerOpen = false;

  void selectAnimalType(AnimalType type) {
    selectedAnimalType.value = type;
    // Reset results when animal type changes
    _clearResult();
  }

  Future<void> pickImage() async {
    if (_isPickerOpen) return;
    _isPickerOpen = true;
    try {
      final xFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      if (xFile != null) {
        pickedImage.value = File(xFile.path);
        _clearResult();
      }
    } finally {
      _isPickerOpen = false;
    }
  }

  Future<void> pickImageFromCamera() async {
    if (_isPickerOpen) return;
    _isPickerOpen = true;
    try {
      final xFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      if (xFile != null) {
        pickedImage.value = File(xFile.path);
        _clearResult();
      }
    } finally {
      _isPickerOpen = false;
    }
  }

  Future<void> runScan() async {
    if (pickedImage.value == null) {
      Get.snackbar('No Image', 'Please select an image first.');
      return;
    }
    scanStatus.value = ScanStatus.loading;

    try {
      Map<String, dynamic> result;
      switch (selectedAnimalType.value) {
        case AnimalType.cattle:
          result = await _repo.predictCattle(pickedImage.value!);
          break;
        case AnimalType.cat:
          result = await _repo.predictCat(pickedImage.value!);
          break;
        case AnimalType.chicken:
          result = await _repo.predictChicken(pickedImage.value!);
          break;
      }

      log("$result");

      resultDetails.value = result;
      resultLabel.value =
          result['predicted_class']?.toString() ??
          result['prediction']?.toString() ??
          result['class']?.toString() ??
          'Unknown';
      resultConfidence.value =
          (result['confidence'] as num?)?.toDouble() ?? 0.0;
      scanStatus.value = ScanStatus.success;
    } catch (e) {
      scanStatus.value = ScanStatus.failure;
      Get.snackbar(
        'Scan Failed',
        'Could not connect to the CV model. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Pass diagnosis to فيتو chat and navigate there
  void askFeto() {
    final animal = selectedAnimalType.value.name;
    final label = resultLabel.value;
    final confidence = (resultConfidence.value * 100).toStringAsFixed(1);
    final msg =
        'My $animal was diagnosed with "$label" (confidence: $confidence%). '
        'Can you explain this condition and what I should do?';
    Get.toNamed('/userChat', arguments: {'preFill': msg});
  }

  void _clearResult() {
    resultLabel.value = '';
    resultConfidence.value = 0.0;
    resultDetails.clear();
    scanStatus.value = ScanStatus.idle;
  }

  void reset() {
    pickedImage.value = null;
    _clearResult();
  }
}
