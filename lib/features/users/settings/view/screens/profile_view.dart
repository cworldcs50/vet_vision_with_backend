import 'package:get/get.dart';
import '../widgets/custom_section.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/app_routes_name.dart';
import '../widgets/custom_setting_option.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/widgets/users_liquid_pull_to_refresh.dart';
import '../../controller/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 18,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) => UsersLiquidPullToRefresh(
          onRefresh: controller.refreshProfile,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 24,
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      controller.avatarUrl.isNotEmpty
                          ? CircleAvatar(
                              radius: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 40,
                              ),
                              backgroundColor: AppColors.primaryColor
                                  .withValues(alpha: 0.1),
                              child: ClipOval(
                                child: Image.network(
                                  controller.avatarUrl,
                                  fit: BoxFit.cover,
                                  width:
                                      AdaptiveLayout.getResponsiveFontSize(
                                        context,
                                        fontSize: 40,
                                      ) *
                                      2,
                                  height:
                                      AdaptiveLayout.getResponsiveFontSize(
                                        context,
                                        fontSize: 40,
                                      ) *
                                      2,
                                  loadingBuilder: (context, child, progress) =>
                                      progress == null
                                      ? child
                                      : const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.primaryColor,
                                        ),
                                  errorBuilder: (context, error, stack) => Icon(
                                    Icons.person,
                                    size: AdaptiveLayout.getResponsiveFontSize(
                                      context,
                                      fontSize: 40,
                                    ),
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 40,
                              ),
                              backgroundColor: AppColors.primaryColor
                                  .withValues(alpha: 0.1),
                              child: Icon(
                                Icons.person,
                                color: AppColors.primaryColor,
                                size: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                      SizedBox(
                        height: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        controller.fullName,
                        style: TextStyle(
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 20,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 4,
                        ),
                      ),
                      Text(
                        controller.email,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(
                        height: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: controller.openEditProfile,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 24,
                            ),
                            vertical: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 8,
                            ),
                          ),
                        ),
                        child: const Text("Edit Profile"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                CustomSection(
                  title: "General",
                  items: [
                    CustomSettingOption(
                      icon: Icons.pets,
                      title: "My Pets",
                      onTap: () => Get.toNamed(AppRoutesName.rMyPets),
                    ),
                    const CustomSettingOption(
                      icon: Icons.favorite_border,
                      title: "Favorite Doctors",
                    ),
                    const CustomSettingOption(
                      icon: Icons.payment,
                      title: "Payment Methods",
                    ),
                  ],
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                CustomSection(
                  title: "Settings",
                  items: [
                    CustomSettingOption(
                      icon: Icons.notifications_none,
                      title: "Notifications",
                    ),
                    CustomSettingOption(
                      icon: Icons.security,
                      title: "Security",
                    ),
                    CustomSettingOption(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                    ),
                    CustomSettingOption(
                      title: "Logout",
                      icon: Icons.logout,
                      iconColor: Colors.red,
                      textColor: Colors.red,
                      onTap: controller.logout,
                    ),
                  ],
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
