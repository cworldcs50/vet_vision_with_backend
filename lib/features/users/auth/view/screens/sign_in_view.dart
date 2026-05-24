import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controller/sign_in_controller.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/network/request_status.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/constants/images_constants.dart';
import '../widgets/responsive_and_adaptive_sign_in/mobile_sign_in_layout.dart';
import '../widgets/responsive_and_adaptive_sign_in/tablet_sign_in_layout.dart';
import '../widgets/responsive_and_adaptive_sign_in/desktop_sign_in_layout.dart';

// NOTE: This must be a StatefulWidget (not GetView/StatelessWidget) so that
// the GlobalKey<FormState> is owned by the widget State, not the controller.
// A GlobalKey stored in a GetX controller survives route teardown and causes
// "Duplicate GlobalKey detected" crashes during Get.offAllNamed transitions.
class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  // The key is created here (in State) so it is disposed with this widget.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(
    debugLabel: 'signInFormKey',
  );

  late final SignInController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<SignInController>();
    // Inject the key into the controller so signIn() can call validate().
    _controller.signInFormKey = _formKey;
  }

  @override
  void dispose() {
    // Only clear the reference if the controller is still holding THIS widget's key.
    // This prevents the old route from nulling out the new route's key during transitions.
    if (_controller.signInFormKey == _formKey) {
      _controller.signInFormKey = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDoctor = _controller.selectedRole.isDoctor;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.xxxl,
                  ),
                ),
                // Logo Section
                Container(
                  width: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 100,
                  ),
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 100,
                  ),
                  padding: EdgeInsets.all(
                    AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: AppSpacing.s,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(
                      AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: AppSpacing.radiusL,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    ImagesConstants.kLogo,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.l,
                  ),
                ),
                Text(
                  "Vet Vision",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.textLight,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 32,
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.xs,
                  ),
                ),
                Text(
                  isDoctor
                      ? "Welcome Doctor! Sign in to continue."
                      : "Welcome back! Sign in to continue.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textLight.withValues(alpha: 0.8),
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.xxl,
                  ),
                ),
                // Form Section
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: AppSpacing.l,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: AppSpacing.l,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(
                      AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: AppSpacing.radiusXl,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: AdaptiveLayout(
                      mobileLayout: (context) => MobileSignInView(),
                      tabletLayout: (context) => TabletSignInView(),
                      desktopLayout: (context) => DesktopSignInView(),
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: AppSpacing.xxl,
                  ),
                ),
              ],
            ),
          ),
          // Loading overlay
          Obx(() {
            if (_controller.requestStatus.value == RequestStatus.loading) {
              return Container(
                color: Colors.black38,
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.textLight),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
