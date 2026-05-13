import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/services/app_service.dart';
import '../../../../../core/routes/app_routes_name.dart';
import '../../../../../core/constants/caching_keys_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 15),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 10.0,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("Settings"),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_sharp),
                  ),
                ],
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 15,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.public, color: Colors.tealAccent),
                  SizedBox(
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 15,
                    ),
                  ),
                  const Text("Language"),
                ],
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 15,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  minimumSize: Size(
                    double.infinity,
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 50),
                  ),
                ),
                child: const Text("English"),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 8,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  minimumSize: Size(
                    double.infinity,
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 50),
                  ),
                ),
                child: const Text("Arabic"),
              ),

              TextButton.icon(
                onPressed: () async {
                  final SharedPreferences sharedPrefs =
                      Get.find<AppServices>().appSharedPrefs;
                  await sharedPrefs.setBool(
                    CachingKeysConstants.kIsAuthedUser,
                    false,
                  );
                  await Get.offAllNamed(AppRoutesName.rSignIn);
                },
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft,
                  minimumSize: Size(
                    double.infinity,
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 50),
                  ),
                  iconColor: Colors.red,
                  foregroundColor: Colors.red,
                  shape: const RoundedRectangleBorder(),
                ),
                icon: const Icon(Icons.exit_to_app),
                label: const Text("Sign Out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
