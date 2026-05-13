import 'package:get/get.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/classes/base_request_controller.dart';

class VerifyCodeForgetPasswordController extends BaseRequestController {
  late final String email;
  late String verificationCode;

  @override
  void onInit() {
    verificationCode = "";
    email = Get.arguments['email'] ?? '';
    super.onInit();
  }

  void goToResetPassword() {
    if (verificationCode.length < 6) {
      showError("Error", "Please enter the full 6-digit code");
      return;
    }

    // Since Laravel requires both the code and new password at the same time,
    // we don't verify the code here. We just pass it to the Reset Password screen.
    Get.toNamed(
      AppRoutesName.rResetPassword,
      arguments: {"email": email, "code": verificationCode},
    );
  }
}
