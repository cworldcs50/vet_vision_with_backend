import 'package:get/get.dart';
import 'core/services/service_locator.dart';
import 'features/splash/controller/logo_controller.dart';
import 'features/users/booking/controller/bookings_controller.dart';
import 'features/users/home/controller/home_controller.dart';
import 'features/users/auth/controller/sign_up_controller.dart';
import 'features/users/auth/controller/sign_in_controller.dart';
import 'features/users/auth/controller/verify_code_sign_up.dart';
import 'features/users/booking/controller/checkout_controller.dart';
import 'features/users/messages/controller/messages_controller.dart';
import 'features/on_boarding/controller/on_boarding_controller.dart';
import 'features/users/home/data/repository/home_data_repository.dart';
import 'features/users/booking/controller/book_appointment_controller.dart';
import 'features/users/payment/controller/payment_controller.dart';
import 'features/users/settings/controller/profile_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LogoController());
    Get.lazyPut(() => HomeController(repository: sl<IHomeRepository>()));
    Get.lazyPut(() => OnBoardingController());
    Get.lazyPut(() => BookAppointmentController());
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => CheckoutController(), fenix: true);
    Get.lazyPut(() => BookingsController(), fenix: true);
    Get.lazyPut(() => MessagesController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => PaymentController(), fenix: true);
    Get.lazyPut(() => VerifyCodeSignUpImp(), fenix: true);
  }
}
