import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  Rx<String?> selectedSlot = Rx<String?>(null);
  RxString selectedSessionType = "online".obs;
  final TextEditingController notesController = TextEditingController();

  void setSessionType(String type) {
    selectedSessionType.value = type;
  }

  void setSlot(String slot) {
    selectedSlot.value = slot;
  }

  void proceedToPayment() {
    // Collect data and proceed
    Get.toNamed(
      '/payment', // AppRoutesName.rPayment
      arguments: {
        "doctorName":
            "Dr. Michael Chen", // In a real app this would come from previous screen args or API
        "sessionType": selectedSessionType.value,
        "price": selectedSessionType.value.toLowerCase() == "online"
            ? 40.0
            : 80.0,
      },
    );
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }
}
