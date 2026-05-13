import 'package:get/get.dart';
import '../../../../core/constants/caching_keys_constants.dart';
import '../../../../core/constants/link_api.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/services/app_service.dart';
import '../../../../core/services/authentication_service.dart';

class ProfileController extends GetxController {
  final _sharedPrefs = Get.find<AppServices>().appSharedPrefs;
  final _crud = Get.find<AppServices>().crud;
  final _authService = AuthenticationService();

  String fullName = '';
  String email = '';
  String role = '';

  @override
  void onInit() {
    super.onInit();
    loadCachedUser();
  }

  void loadCachedUser() {
    fullName =
        _sharedPrefs.getString(CachingKeysConstants.kUserFullName) ?? 'User';
    email = _sharedPrefs.getString(CachingKeysConstants.kUserEmail) ?? '';
    role = _sharedPrefs.getString(CachingKeysConstants.kUserRole) ?? 'user';
    update();
  }

  Future<void> logout() async {
    await _crud.post(AppLink.logout, {}, {'Accept': 'application/json'});
    await _authService.logout();
    Get.offAllNamed(AppRoutesName.rSignIn);
  }
}
