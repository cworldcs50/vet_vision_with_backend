import 'package:get/get.dart';
import 'app_routes_name.dart';
import '../services/app_service.dart';
import 'package:flutter/material.dart';
import '../constants/caching_keys_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMiddleware extends GetMiddleware {
  final SharedPreferences _sharedPrefs = Get.find<AppServices>().appSharedPrefs;

  @override
  RouteSettings? redirect(String? route) {
    if (_sharedPrefs.getBool(CachingKeysConstants.kIsAuthedUser) == true) {
      return const RouteSettings(name: AppRoutesName.rHome);
    }
    return null;
  }
}
