import 'dart:io';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/profile_repository.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/constants/link_api.dart';
import '../../../../core/services/app_service.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/services/authentication_service.dart';
import '../../../../core/constants/caching_keys_constants.dart';

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

  String phone = '';
  String address = '';
  String dob = '';

  // Edit Profile Form State
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController addressCtrl;
  late TextEditingController dobCtrl;
  late TextEditingController oldPasswordCtrl;
  late TextEditingController newPasswordCtrl;
  late TextEditingController confirmPasswordCtrl;
  File? pickedImage;
  bool _isPickerOpen = false;
  var updateStatus = RequestStatus.noData.obs;

  @override
  void onInit() {
    super.onInit();
    nameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    addressCtrl = TextEditingController();
    dobCtrl = TextEditingController();
    oldPasswordCtrl = TextEditingController();
    newPasswordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    loadCachedUser();
  }

  void loadCachedUser() {
    fullName =
        _sharedPrefs.getString(CachingKeysConstants.kUserFullName) ?? 'User';
    email = _sharedPrefs.getString(CachingKeysConstants.kUserEmail) ?? '';
    role = _sharedPrefs.getString(CachingKeysConstants.kUserRole) ?? 'user';
    avatarUrl =
        _sharedPrefs.getString(CachingKeysConstants.kUserAvatarUrl) ?? '';
    phone = _sharedPrefs.getString(CachingKeysConstants.kUserPhone) ?? '';
    address = _sharedPrefs.getString('userAddress') ?? '';
    dob = _sharedPrefs.getString('userDob') ?? '';
    update();
  }

  void openEditProfile() {
    nameCtrl.text = fullName;
    emailCtrl.text = email;
    phoneCtrl.text = phone;
    addressCtrl.text = address;
    dobCtrl.text = dob;
    oldPasswordCtrl.clear();
    newPasswordCtrl.clear();
    confirmPasswordCtrl.clear();
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
      final fields = <String, dynamic>{
        'name': nameCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
      };

      if (phoneCtrl.text.trim().isNotEmpty) {
        fields['phone'] = phoneCtrl.text.trim();
      }
      if (addressCtrl.text.trim().isNotEmpty) {
        fields['address'] = addressCtrl.text.trim();
      }
      if (dobCtrl.text.trim().isNotEmpty) {
        fields['date_of_birth'] = dobCtrl.text.trim();
      }
      if (oldPasswordCtrl.text.isNotEmpty && newPasswordCtrl.text.isNotEmpty) {
        fields['old_password'] = oldPasswordCtrl.text;
        fields['password'] = newPasswordCtrl.text;
        fields['password_confirmation'] = confirmPasswordCtrl.text;
      }

      final response = await _repo.updateProfile(
        fields: fields,
        avatar: pickedImage,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        final user = data['user'];

        // Build full avatar URL safely – response may omit it if no new image was uploaded
        final rawAvatarUrl = data['avatar_url']?.toString() ?? '';
        if (rawAvatarUrl.isNotEmpty) {
          final filename = rawAvatarUrl.split('/').last;
          final fullAvatarUrl =
              'http://10.0.2.2/VetVision-API/VetVision-API/storage/app/public/avatars/$filename';
          await _sharedPrefs.setString(
            CachingKeysConstants.kUserAvatarUrl,
            fullAvatarUrl,
          );
        }

        // Update local cache with returned user data
        if (user['name'] != null) {
          await _sharedPrefs.setString(CachingKeysConstants.kUserFullName, user['name']);
        }
        if (user['email'] != null) {
          await _sharedPrefs.setString(CachingKeysConstants.kUserEmail, user['email']);
        }
        if (user['phone'] != null) {
          await _sharedPrefs.setString(CachingKeysConstants.kUserPhone, user['phone']);
        }
        if (user['address'] != null) {
          await _sharedPrefs.setString('userAddress', user['address']);
        }
        if (user['date_of_birth'] != null) {
          await _sharedPrefs.setString('userDob', user['date_of_birth']);
        }

        loadCachedUser();
        updateStatus.value = RequestStatus.success;
        Get.back(); // close form
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF009689),
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
    phoneCtrl.dispose();
    addressCtrl.dispose();
    dobCtrl.dispose();
    oldPasswordCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.onClose();
  }
}
