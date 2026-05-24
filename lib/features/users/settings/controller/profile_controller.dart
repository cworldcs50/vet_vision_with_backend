import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/caching_keys_constants.dart';
import '../../../../core/constants/link_api.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/services/app_service.dart';
import '../../../../core/services/authentication_service.dart';
import '../data/profile_repository.dart';

class ProfileController extends GetxController {
  final _sharedPrefs = Get.find<AppServices>().appSharedPrefs;
  final _crud = Get.find<AppServices>().crud;
  final _authService = AuthenticationService();
  final ProfileRepository _repo = ProfileRepository();
  final _imagePicker = ImagePicker();

  String fullName = '';
  String email = '';
  String role = '';
  String avatarUrl = '';

  // Edit Profile Form State
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  File? pickedImage;
  bool _isPickerOpen = false;
  var updateStatus = RequestStatus.noData.obs;

  @override
  void onInit() {
    super.onInit();
    nameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    loadCachedUser();
  }

  void loadCachedUser() {
    fullName =
        _sharedPrefs.getString(CachingKeysConstants.kUserFullName) ?? 'User';
    email = _sharedPrefs.getString(CachingKeysConstants.kUserEmail) ?? '';
    role = _sharedPrefs.getString(CachingKeysConstants.kUserRole) ?? 'user';
    avatarUrl = _sharedPrefs.getString(CachingKeysConstants.kUserAvatarUrl) ?? '';
    update();
  }

  void openEditProfile() {
    nameCtrl.text = fullName;
    emailCtrl.text = email;
    pickedImage = null;
    updateStatus.value = RequestStatus.noData;
    update();
    // Create EditProfileView and navigate to it
    Get.toNamed('/editProfile');
  }

  Future<void> pickImage() async {
    if (_isPickerOpen) return;
    _isPickerOpen = true;
    try {
      final xFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 800,
        maxHeight: 800,
      );
      if (xFile != null) {
        pickedImage = File(xFile.path);
        update();
      }
    } finally {
      _isPickerOpen = false;
    }
  }

  Future<void> submitProfileUpdate() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    updateStatus.value = RequestStatus.loading;

    try {
      final fields = {
        'name': nameCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
      };

      final response = await _repo.updateProfile(
        fields: fields,
        avatar: pickedImage,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        final user = data['user'];
        final newAvatarUrl = data['avatar_url'] ?? '';

        // Update local cache
        await _sharedPrefs.setString(CachingKeysConstants.kUserFullName, user['name']);
        await _sharedPrefs.setString(CachingKeysConstants.kUserEmail, user['email']);
        await _sharedPrefs.setString(CachingKeysConstants.kUserAvatarUrl, newAvatarUrl);
        
        loadCachedUser();
        updateStatus.value = RequestStatus.success;
        Get.back(); // close form
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          backgroundColor: const Color(0xFF009689),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        updateStatus.value = RequestStatus.failure;
        Get.snackbar(
          'Error',
          'Could not update profile',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      log('UPDATE PROFILE ERROR: $e');
      updateStatus.value = RequestStatus.failure;
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> refreshProfile() async {
    loadCachedUser();
    await Future<void>.delayed(Duration.zero);
  }

  Future<void> logout() async {
    await _crud.post(AppLink.logout, {}, {'Accept': 'application/json'});
    await _authService.logout();
    Get.offAllNamed(AppRoutesName.rSignIn);
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.onClose();
  }
}
