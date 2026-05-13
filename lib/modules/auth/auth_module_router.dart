import '../../../core/routes/app_routes_name.dart';
import 'auth_role.dart';

class AuthModuleRouter {
  static String signInRoute(AuthRole role) => AppRoutesName.rSignIn;

  static String signUpRoute(AuthRole role) => AppRoutesName.rSignUp;

  static String homeRoute(AuthRole role) {
    if (role.isDoctor) return AppRoutesName.rDoctorPortal;
    return AppRoutesName.rHome;
  }
}
