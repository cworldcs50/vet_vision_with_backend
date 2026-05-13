import 'package:get/get.dart';

import '../../../../modules/auth/auth_module_router.dart';
import '../../../../modules/auth/auth_role.dart';

class RoleSelectionController extends GetxController {
  void selectRole(bool isDoctor) {
    final selectedRole = isDoctor ? AuthRole.doctor : AuthRole.user;
    Get.toNamed(
      AuthModuleRouter.signInRoute(selectedRole),
      arguments: {'role': selectedRole.value},
    );
  }
}
