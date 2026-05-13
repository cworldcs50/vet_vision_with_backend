import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/services/app_service.dart';
import '../../../../../core/routes/app_routes_name.dart';
import '../../../../../core/constants/caching_keys_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessSignIn extends StatelessWidget {
  const SuccessSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                "🎉",
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Text(
              "Welcome to VetVision!",
              style: TextStyle(
                color: const Color(0XFF009689),
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
            ),
            const Flexible(
              child: Text(
                "You're now signed in! The main app experience would start here.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0XFF4A5565)),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                final SharedPreferences sharedPrefs =
                    Get.find<AppServices>().appSharedPrefs;
                await sharedPrefs.setBool(
                  CachingKeysConstants.kIsAuthedUser,
                  true,
                );
                await Get.offAllNamed(AppRoutesName.rHome);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              child: Text(
                "Let's Start!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
