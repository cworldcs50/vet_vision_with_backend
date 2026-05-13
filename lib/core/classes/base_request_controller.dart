import 'package:get/get.dart';
import '../functions/is_online.dart';
import 'package:flutter/material.dart';
import '../../core/network/request_status.dart';
import '../theme/app_colors.dart';

class BaseRequestController extends GetxController {
  final Rx<RequestStatus> requestStatus = RequestStatus.noData.obs;

  void setStatus(RequestStatus status) => requestStatus.value = status;

  Future<bool> checkOnline() async {
    final online = await isOnline();
    if (!online) {
      setStatus(RequestStatus.offlineFailure);
    }
    return online;
  }

  void showError(String title, String message) {
    setStatus(RequestStatus.failure);
    Get.snackbar(
      title,
      message,
      titleText: Text(title, style: const TextStyle(color: Colors.white)),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void showMsg(String title, String message) {
    setStatus(RequestStatus.success);
    Get.snackbar(
      title,
      message,
      titleText: Text(title, style: const TextStyle(color: Colors.white)),
      messageText: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: AppColors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
