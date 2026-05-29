import 'dart:developer';
import 'package:get/get.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../data/payment_repository.dart';

class PaymentController extends GetxController {
  // ── Args passed from BookAppointmentController ─────────────────────────────
  late final String appointmentId;
  late final String doctorName;
  late final String sessionType; // "online" | "in-person"
  late final double consultationFee;
  late final String doctorImage;

  // ── Fees ───────────────────────────────────────────────────────────────────
  final double serviceFee = 10.0;
  double get totalAmount => consultationFee + serviceFee;

  // ── Payment state ──────────────────────────────────────────────────────────
  String selectedPaymentMethod = "visa"; // "visa" | "arrival"
  Rx<RequestStatus> paymentStatus = RequestStatus.noData.obs;

  final PaymentRepository _paymentRepo = PaymentRepository();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>? ??
        {
          "appointmentId": "",
          "doctorName": "Doctor",
          "sessionType": "online",
          "price": 0.0,
        };

    appointmentId = args["appointmentId"]?.toString() ?? '';
    doctorName = args["doctorName"] as String? ?? 'Doctor';
    sessionType = args["sessionType"] as String? ?? 'online';
    consultationFee = (args["price"] as num?)?.toDouble() ?? 0.0;
    doctorImage = args["doctorImage"] as String? ?? 'assets/images/doctor.png';

    // Online sessions always pay by card
    if (sessionType.toLowerCase() == "online") {
      selectedPaymentMethod = "visa";
    }
  }

  void setPaymentMethod(String method) {
    if (sessionType.toLowerCase() == "online") {
      selectedPaymentMethod = "visa";
    } else {
      selectedPaymentMethod = method;
    }
    update();
  }

  // ── Confirm & pay ──────────────────────────────────────────────────────────
  Future<void> confirmBooking() async {
    // Pay on arrival — no online payment needed, just confirm
    if (selectedPaymentMethod == "arrival") {
      Get.snackbar(
        "Booking Confirmed",
        "Your appointment with $doctorName is reserved. Pay on arrival.",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAllNamed(AppRoutesName.rHome);
      return;
    }

    // Card payment — call backend
    if (appointmentId.isEmpty) {
      Get.snackbar('Error', 'Invalid appointment ID.');
      return;
    }

    paymentStatus.value = RequestStatus.loading;
    update();

    try {
      final response = await _paymentRepo.payForAppointment(appointmentId);

      if (response.statusCode == 200 && response.data['status'] == true) {
        paymentStatus.value = RequestStatus.success;

        final paymentUrl = response.data['data']?['payment_url'];
        if (paymentUrl != null && paymentUrl.toString().isNotEmpty) {
          // Navigate to webview for online card payment
          Get.toNamed('/paymentWebview', arguments: {
            'paymentUrl': paymentUrl.toString(),
          });
        } else {
          // Payment processed directly
          Get.snackbar(
            "Payment Successful",
            "Your appointment with $doctorName has been confirmed.",
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.offAllNamed(AppRoutesName.rHome);
        }
      } else {
        paymentStatus.value = RequestStatus.failure;
        final msg = response.data['message']?.toString() ?? 'Payment failed.';
        Get.snackbar('Payment Error', msg, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      log('PAYMENT ERROR: $e');
      paymentStatus.value = RequestStatus.failure;
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    update();
  }

  Future<void> refreshPaymentState() async {
    await Future<void>.delayed(Duration.zero);
    update();
  }
}
