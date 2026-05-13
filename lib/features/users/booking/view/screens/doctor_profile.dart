import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../widgets/mobile_doctor_profile.dart';
import '../widgets/tablet_doctor_profile.dart';
import '../widgets/desktop_doctor_profile.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: AdaptiveLayout(
        mobileLayout: (context) => const MobileDoctorProfile(),
        tabletLayout: (context) => const TabletDoctorProfile(),
        desktopLayout: (context) => const DesktopDoctorProfile(),
      ),
    );
  }
}
