import 'package:get/get.dart';
import '../../../../core/routes/app_routes_name.dart';

class BookAppointmentController extends GetxController {
  RxInt selectedTabIndex = 0.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void bookAppointment() {
    Get.toNamed(AppRoutesName.rCheckout);
  }
}
