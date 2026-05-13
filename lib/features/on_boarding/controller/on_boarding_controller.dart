import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';
import '../data/static/on_boarding_data.dart';
import '../../../core/services/app_service.dart';
import '../../../core/routes/app_routes_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/caching_keys_constants.dart';

class OnBoardingController extends GetxController {
  int currentPageIndex = 0;
  late final PageController pageController;
  late final SharedPreferences _sharedPrefs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    _sharedPrefs = Get.find<AppServices>().appSharedPrefs;
  }

  Future<void> skip() async {
    await _sharedPrefs.setBool(CachingKeysConstants.kVisited, true);
    await Get.offAllNamed(AppRoutesName.rRoleSelection);
  }

  Future<void> next() async {
    if (currentPageIndex == kOnBoardingData.length - 1) {
      log("Current page index: $currentPageIndex");
      log("on boarding models length: ${kOnBoardingData.length - 1}");
      await skip();
      return;
    }

    if (pageController.hasClients) {
      await pageController.animateToPage(
        currentPageIndex + 1,
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 1200),
      );
    }

    update();
  }

  void onPageChanged(int index) {
    currentPageIndex = index;
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
