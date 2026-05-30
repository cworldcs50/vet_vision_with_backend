import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/classes/adaptive_layout.dart';
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
      floatingActionButton: _AiCenterFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _CustomBottomNav(),
    );
  }
}

// ── Center AI FAB ─────────────────────────────────────────────────────────────
class _AiCenterFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/userChat'),
      child: Container(
        width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 62),
        height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 62),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.45),
              blurRadius: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 14,
              ),
              offset: Offset(
                0,
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 5),
              ),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pulsing ring
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.1),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (_, v, child) => Transform.scale(scale: v, child: child),
              onEnd: () {},
              child: Container(
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 62,
                ),
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 62,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 2,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 22,
                  ),
                ),
                Text(
                  'فيتو',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 9,
                    ),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Custom Bottom Nav ─────────────────────────────────────────────────────────
class _CustomBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 8,
          ),
          color: Colors.white,
          elevation: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 12,
          ),
          child: SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Home',
                  index: 0,
                  currentIndex: controller.currentNavIndex,
                  onTap: () => controller.changeNavIndex(0),
                ),
                _NavItem(
                  icon: Icons.calendar_today_outlined,
                  activeIcon: Icons.calendar_today,
                  label: 'Bookings',
                  index: 1,
                  currentIndex: controller.currentNavIndex,
                  onTap: () => controller.changeNavIndex(1),
                ),
                // Centre gap for FAB
                const SizedBox(width: 62),
                _NavItem(
                  icon: Icons.message_outlined,
                  activeIcon: Icons.message,
                  label: 'Messages',
                  index: 2,
                  currentIndex: controller.currentNavIndex,
                  onTap: () => controller.changeNavIndex(2),
                ),
                _NavItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Profile',
                  index: 3,
                  currentIndex: controller.currentNavIndex,
                  onTap: () => controller.changeNavIndex(3),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 12,
          ),
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.primary : Colors.grey,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 2,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 10,
                ),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? AppColors.primary : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
