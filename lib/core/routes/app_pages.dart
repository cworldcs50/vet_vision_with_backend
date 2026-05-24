import 'package:get/get.dart';
import '../../features/doctors/portal/auth/view/screens/doctor_login_view.dart';
import '../../features/doctors/portal/auth/view/screens/doctor_verify_code_view.dart';
import '../../features/doctors/portal/auth/view/screens/step1_personal_info.dart';
import '../../features/doctors/portal/auth/view/screens/step2_professional_details.dart';
import '../../features/doctors/portal/auth/view/screens/step3_practice_details.dart';
import '../../features/doctors/portal/auth/view/screens/step4_location_view.dart';
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
import '../../features/users/pets/view/screens/my_pets_view.dart';
import '../../features/users/pets/view/screens/pet_form_view.dart';
import '../../features/users/settings/view/screens/edit_profile_view.dart';
import '../../features/users/payment/view/payment_webview.dart';
import '../../features/users/ai_chat/view/user_chat_view.dart';
import '../../features/users/cv_scan/view/cv_scan_view.dart';
import '../../features/doctors/ai_copilot/view/copilot_chat_view.dart';
import 'app_routes_name.dart';
import 'on_boarding_middleware.dart';
import '../../features/splash/view/logo.dart';
import '../../features/on_boarding/view/onboarding_view.dart';
import '../../features/doctors/portal/doctor_portal_main_view.dart';

List<GetPage> kAppPages = [
  GetPage(
    name: AppRoutesName.rRoleSelection,
    page: () => const RoleSelection(),
  ),
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
  GetPage(
    page: () => const DoctorProfile(),
    name: AppRoutesName.rDoctorDetails,
  ),
  GetPage(name: AppRoutesName.rCheckout, page: () => const Checkout()),
  GetPage(name: AppRoutesName.rPayment, page: () => const PaymentView()),
  GetPage(name: AppRoutesName.rMyPets, page: () => const MyPetsView()),
  GetPage(name: '/myPetsForm', page: () => const PetFormView()),
  GetPage(
    name: AppRoutesName.rDoctorSignIn,
    page: () => const DoctorLoginView(),
  ),
  GetPage(
    name: AppRoutesName.rDoctorAuthStep1,
    page: () => const Step1PersonalInfo(),
  ),
  GetPage(
    name: AppRoutesName.rDoctorAuthStep2,
    page: () => const Step2ProfessionalDetails(),
  ),
  GetPage(
    name: AppRoutesName.rDoctorAuthStep3,
    page: () => const Step3PracticeDetails(),
  ),
  GetPage(
    name: AppRoutesName.rDoctorAuthStep4,
    page: () => const Step4LocationView(),
  ),
  GetPage(
    name: AppRoutesName.rDoctorVerifyCode,
    page: () => const DoctorVerifyCodeView(),
  ),
  GetPage(
    name: AppRoutesName.rDoctorPortal,
    page: () => const DoctorPortalMainView(),
  ),
  GetPage(
    name: '/editProfile',
    page: () => const EditProfileView(),
  ),
  GetPage(
    name: '/paymentWebview',
    page: () => const PaymentWebView(),
  ),
  GetPage(
    name: '/userChat',
    page: () => const UserChatView(),
  ),
  GetPage(
    name: '/cvScan',
    page: () => const CvScanView(),
  ),
  GetPage(
    name: '/copilotChat',
    page: () => const CopilotChatView(),
  ),
];
