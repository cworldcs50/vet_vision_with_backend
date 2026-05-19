import 'app_binding.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'core/routes/app_pages.dart';
import 'core/constants/app_constants.dart';
import 'core/routes/app_routes_name.dart';
// import 'core/theme/app_theme.dart';

class VetVision extends StatelessWidget {
  const VetVision({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: kAppPages,
      // theme: AppTheme.lightTheme,
      initialBinding: AppBinding(),
      title: AppConstants.kAppTitle,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutesName.rRoleSelection,
    );
  }
}
