import '../../../core/routes/app_routes_name.dart';
import 'auth_role.dart';

class AuthModuleRouter {
  static String roleSelectionRoute(AuthRole role) =>
      AppRoutesName.rRoleSelection;

  static String signInRoute(AuthRole role) => AppRoutesName.rSignIn;

  static String signUpRoute(AuthRole role) => AppRoutesName.rSignUp;

  static String homeRoute(AuthRole role) {
    if (role.isDoctor) return AppRoutesName.rDoctorSignIn;
    return AppRoutesName.rSignIn;
  }
}
