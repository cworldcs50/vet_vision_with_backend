import 'package:get/get.dart';
import '../../features/users/auth/view/screens/forget_password.dart';
import '../../features/users/auth/view/screens/reset_password_view.dart';
import '../../features/users/auth/view/screens/role_selection.dart';
import '../../features/users/auth/view/screens/sign_in_view.dart';
import '../../features/users/auth/view/screens/sign_up_view.dart';
import '../../features/users/auth/view/screens/success_sign_in.dart';
import '../../features/users/auth/view/screens/verification_code_view.dart';
import '../../features/users/auth/view/screens/verify_code_forget_password_view.dart';
import '../../features/users/booking/view/screens/book_appointment.dart';
import '../../features/users/booking/view/screens/checkout.dart';
import '../../features/users/booking/view/screens/doctor_profile.dart';
import '../../features/users/home/view/home_view.dart';
import '../../features/users/payment/view/payment_view.dart';
import 'app_routes_name.dart';
import 'on_boarding_middleware.dart';
import '../../features/splash/view/logo.dart';
import '../../features/on_boarding/view/onboarding_view.dart';
import '../../features/doctors/portal/doctor_portal_main_view.dart';

List<GetPage> kAppPages = [
  GetPage(
    name: AppRoutesName.rSignIn,
    page: () => const SignInView(),
    // middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutesName.rSignUp,
    page: () => const SignUpView(),
    // middlewares: [AuthMiddleware()],
  ),
  GetPage(
    name: AppRoutesName.rRoleSelection,
    page: () => const RoleSelection(),
  ),
  GetPage(
    page: () => const Logo(),
    name: AppRoutesName.rLogo,
    middlewares: [OnBoardingMiddleware()],
  ),
  GetPage(name: AppRoutesName.rHome, page: () => const HomeView()),
  GetPage(name: AppRoutesName.rOnBoarding, page: () => const OnboardingView()),
  GetPage(name: AppRoutesName.rSuccessAuth, page: () => const SuccessSignIn()),
  GetPage(
    name: AppRoutesName.rVerifyCodeSignUp,
    page: () => const VerifyCodeSignUpView(),
  ),
  GetPage(
    name: AppRoutesName.rVerifyCodeForgetPassword,
    page: () => const VerifyCodeForgetPasswordView(),
  ),
  GetPage(
    page: () => const ForgetPasswordView(),
    name: AppRoutesName.rForgetPassword,
  ),
  GetPage(
    page: () => const ResetPasswordView(),
    name: AppRoutesName.rResetPassword,
  ),
  GetPage(
    page: () => const BookAppointment(),
    name: AppRoutesName.rBookAppointment,
  ),
  // GetPage(
  //   page: () => const HealthRecords(),
  //   name: AppRoutesName.rHealthRecords,
  // ),
  GetPage(
    page: () => const DoctorProfile(),
    name: AppRoutesName.rDoctorDetails,
  ),
  GetPage(name: AppRoutesName.rCheckout, page: () => const Checkout()),
  GetPage(name: AppRoutesName.rPayment, page: () => const PaymentView()),
  // GetPage(
  //   name: AppRoutesName.rDoctorSignIn,
  //   page: () => const DoctorLoginView(),
  // ),
  // GetPage(
  //   name: AppRoutesName.rDoctorSignUp,
  //   page: () => const DoctorRegistrationView(),
  // ),
  GetPage(
    name: AppRoutesName.rDoctorPortal,
    page: () => const DoctorPortalMainView(),
  ),
];
