import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' show DioException, Response;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:image_picker/image_picker.dart';
import '../../../../core/network/request_status.dart';
import '../../../../features/doctors/portal/appointments/data/models/animal_model.dart';
import '../data/pets_repository.dart';

class MyPetsController extends GetxController {
  // ── State ────────────────────────────────────────────────────────────────────
  RxList<AnimalModel> pets = <AnimalModel>[].obs;
  Rx<RequestStatus> status = RequestStatus.loading.obs;
  Rx<RequestStatus> formStatus = RequestStatus.noData.obs;
  AnimalModel? editingPet; // null = adding new pet

  // ── Form fields ──────────────────────────────────────────────────────────────
  File? pickedImage;
  bool _isPickerOpen = false;
  String selectedGender = 'male';
  late TextEditingController ageCtrl;
  late TextEditingController nameCtrl;
  late TextEditingController breedCtrl;
  late TextEditingController weightCtrl;
  late TextEditingController speciesCtrl;
  final formKey = GlobalKey<FormState>();

  // ── Repository ────────────────────────────────────────────────────────────────
  final _imagePicker = ImagePicker();
  final PetsRepository _repo = PetsRepository();

  @override
  void onInit() async {
    super.onInit();
    _initControllers();
    await fetchPets();
  }

  void _initControllers() {
    nameCtrl = TextEditingController();
    speciesCtrl = TextEditingController();
    breedCtrl = TextEditingController();
    ageCtrl = TextEditingController();
    weightCtrl = TextEditingController();
  }

  // ── Fetch ─────────────────────────────────────────────────────────────────────

  Future<void> fetchPets() async {
    status.value = RequestStatus.loading;
    try {
      final List<AnimalModel> list = await _repo.fetchMyPets();
      pets.value = list;
      status.value = list.isEmpty
          ? RequestStatus.noData
          : RequestStatus.success;
    } on DioException catch (e) {
      log('FETCH PETS HTTP ERROR: ${e.response?.statusCode}');
      log('FETCH PETS RESPONSE BODY: ${e.response?.data}');
      log('FETCH PETS URL: ${e.requestOptions.uri}');
      status.value = RequestStatus.failure;
    } catch (e) {
      log('FETCH PETS ERROR: $e');
      status.value = RequestStatus.failure;
    }
  }

  // ── Form navigation ───────────────────────────────────────────────────────────

  void openAddForm() {
    editingPet = null;
    _clearForm();
    Get.toNamed('/myPetsForm');
  }

  void openEditForm(AnimalModel pet) {
    editingPet = pet;
    nameCtrl.text = pet.name;
    speciesCtrl.text = pet.species;
    breedCtrl.text = pet.breed;
    ageCtrl.text = pet.age.toString();
    weightCtrl.text = pet.weight.toString();
    selectedGender = pet.gender.toLowerCase();
    pickedImage = null;
    formStatus.value = RequestStatus.noData;
    update();
    Get.toNamed('/myPetsForm');
  }

  void _clearForm() {
    nameCtrl.clear();
    speciesCtrl.clear();
    breedCtrl.clear();
    ageCtrl.clear();
    weightCtrl.clear();
    selectedGender = 'male';
    pickedImage = null;
    formStatus.value = RequestStatus.noData;
    update();
  }

  void setGender(String g) {
    selectedGender = g;
    update();
  }

  Future<void> pickImage() async {
    if (_isPickerOpen) return;
    _isPickerOpen = true;
    try {
      final xFile = await _imagePicker.pickImage(
        maxWidth: 800, // Resize width
        maxHeight: 800, // Resize height
        imageQuality: 30, // More aggressive compression
        source: ImageSource.gallery,
      );
      if (xFile != null) {
        pickedImage = File(xFile.path);
        update();
      }
    } finally {
      _isPickerOpen = false;
    }
  }

  // ── Submit ─────────────────────────────────────────────────────────────────────

  Future<void> submitForm() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    formStatus.value = RequestStatus.loading;

    final fields = {
      'gender': selectedGender,
      'name': nameCtrl.text.trim(),
      'breed': breedCtrl.text.trim(),
      'species': speciesCtrl.text.trim(),
      'age': int.tryParse(ageCtrl.text.trim()) ?? 0,
      'weight': double.tryParse(weightCtrl.text.trim()) ?? 0.0,
    };

    try {
      Response<dynamic> res;
      if (editingPet == null) {
        res = await _repo.createPet(fields: fields, image: pickedImage);
      } else {
        res = await _repo.updatePet(
          id: editingPet!.id,
          fields: fields,
          image: pickedImage,
        );
      }

      if (res.statusCode == 200 || res.statusCode == 201) {
        formStatus.value = RequestStatus.success;
        final petName = nameCtrl.text;
        final isNew = editingPet == null;
        Get.back();
        await fetchPets();
        Get.snackbar(
          isNew ? 'Pet Added' : 'Pet Updated',
          isNew ? '$petName has been added!' : '$petName has been updated!',
          backgroundColor: const Color(0xFF009689),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        formStatus.value = RequestStatus.failure;
        Get.snackbar(
          'Error',
          'Unexpected response. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log('SUBMIT PET ERROR: $e');
      try {
        log('RESPONSE DATA: ${(e as dynamic).response?.data}');
      } catch (_) {}
      formStatus.value = RequestStatus.failure;
      Get.snackbar(
        'Error',
        'Could not save pet. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ── Delete ─────────────────────────────────────────────────────────────────────

  Future<void> deletePet(AnimalModel pet) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Pet'),
        content: Text('Are you sure you want to remove ${pet.name}?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await _repo.deletePet(pet.id);
      await fetchPets();
      Get.snackbar(
        'Removed',
        '${pet.name} has been removed.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      log('DELETE PET ERROR: $e');
      Get.snackbar(
        'Error',
        'Could not delete pet.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // ── Dispose ───────────────────────────────────────────────────────────────────

  @override
  void onClose() {
    nameCtrl.dispose();
    speciesCtrl.dispose();
    breedCtrl.dispose();
    ageCtrl.dispose();
    weightCtrl.dispose();
    super.onClose();
  }
}
