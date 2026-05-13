import 'package:get/get.dart';
// import 'supabase_service.dart';
// import '../constants/secret_constants.dart';
// import '../../data/models/supabase_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/crud.dart';
import 'service_locator.dart';

class AppServices extends GetxService {
  late final SharedPreferences appSharedPrefs;
  late final Crud crud;

  Future<AppServices> init() async {
    appSharedPrefs = await SharedPreferences.getInstance();
    crud = sl<Crud>();
    return this;
  }
}

Future<void> initServices() async {
  ServiceLocator.init();
  await Get.putAsync(() => AppServices().init());
}
