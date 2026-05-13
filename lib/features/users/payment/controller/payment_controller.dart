import 'package:get/get.dart';

class PaymentController extends GetxController {
  // Arguments passed from Checkout screen
  late final String doctorName;
  late final String sessionType; // "Online" or "In-Person"
  final double serviceFee = 10.0;
  late final double consultationFee;
  // State
  String selectedPaymentMethod = "visa"; // "visa" or "arrival"

  @override
  void onInit() {
    super.onInit();

    // Fallback values if navigated directly without args
    final args =
        Get.arguments as Map<String, dynamic>? ??
        {
          "doctorName": "Dr. Ahmed Hassan",
          "sessionType": "In-Person",
          "price": 80.0,
        };

    doctorName = args["doctorName"] as String;
    sessionType = args["sessionType"] as String;
    consultationFee = args["price"] as double;

    // If online, force visa payment method
    if (sessionType.toLowerCase() == "online") {
      selectedPaymentMethod = "visa";
    }
  }

  double get totalAmount => consultationFee + serviceFee;

  void setPaymentMethod(String method) {
    if (sessionType.toLowerCase() == "online") {
      // Online sessions only allow Visa
      selectedPaymentMethod = "visa";
    } else {
      selectedPaymentMethod = method;
    }

    update();
  }

  void confirmBooking() {
    // Process payment / booking here
    Get.snackbar(
      "Booking Confirmed",
      "Your appointment with $doctorName has been booked successfully.",
      snackPosition: SnackPosition.BOTTOM,
    );
    // After confirmation, normally you'd navigate to a Success screen
    // get.offAllNamed(AppRoutesName.rHome);
  }
}
