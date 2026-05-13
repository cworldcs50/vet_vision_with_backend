import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_home_body.dart';
import '../../messages/view/screens/messages_view.dart';
import '../controller/home_controller.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../booking/view/screens/bookings_view.dart';
import '../../settings/view/screens/profile_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: GetBuilder<HomeController>(
        builder: (controller) {
          switch (controller.currentNavIndex) {
            case 0:
              return const CustomHomeBody();
            case 1:
              return const BookingsView();
            case 2:
              return const MessagesView();
            case 3:
              return const ProfileView();
            default:
              return const CustomHomeBody();
          }
        },
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (controller) {
          return BottomNavigationBar(
            currentIndex: controller.currentNavIndex,
            onTap: controller.changeNavIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_outlined),
                activeIcon: Icon(Icons.calendar_today),
                label: "Bookings",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message_outlined),
                activeIcon: Icon(Icons.message),
                label: "Messages",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          );
        },
      ),
    );
  }
}
