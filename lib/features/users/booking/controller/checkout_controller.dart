import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/network/request_status.dart';
import '../../payment/data/payment_repository.dart';

class CheckoutController extends GetxController {
  final PaymentRepository _paymentRepo = PaymentRepository();

  Rx<String?> selectedSlot = Rx<String?>(null);
  RxString selectedSessionType = "online".obs;
  final TextEditingController notesController = TextEditingController();

  // Arguments
  String appointmentId = '';
  String doctorName = '';
  double price = 0.0;

  var paymentStatus = RequestStatus.noData.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      appointmentId = args['appointmentId'] ?? '';
      doctorName = args['doctorName'] ?? '';
      selectedSessionType.value = args['sessionType'] ?? 'online';
      price = args['price'] ?? 0.0;
    }
  }

  void setSessionType(String type) {
    selectedSessionType.value = type;
  }

  void setSlot(String slot) {
    selectedSlot.value = slot;
  }

  Future<void> proceedToPayment() async {
    if (appointmentId.isEmpty) {
      Get.snackbar('Error', 'Invalid appointment ID');
      return;
    }

    paymentStatus.value = RequestStatus.loading;

    try {
      final response = await _paymentRepo.payForAppointment(appointmentId);

      if (response.statusCode == 200 && response.data['status'] == true) {
        final paymentUrl = response.data['data']['payment_url'];
        
        paymentStatus.value = RequestStatus.success;

        Get.toNamed('/paymentWebview', arguments: {
          'paymentUrl': paymentUrl,
        });
      } else {
        paymentStatus.value = RequestStatus.failure;
        Get.snackbar('Error', response.data['message']?.toString() ?? 'Payment failed');
      }
    } catch (e) {
      paymentStatus.value = RequestStatus.failure;
      Get.snackbar('Error', 'Something went wrong while initiating payment.');
    }
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }
}
