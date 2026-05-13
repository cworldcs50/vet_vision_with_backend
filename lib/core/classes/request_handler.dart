import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../network/request_status.dart';
import '../constants/images_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import 'adaptive_layout.dart';

class RequestHandlerView extends StatelessWidget {
  const RequestHandlerView({
    super.key,
    required this.child,
    required this.status,
    this.onRetry,
  });

  final Widget child;
  final RequestStatus? status;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    if (status == null ||
        status == RequestStatus.success ||
        status == RequestStatus.noData) {
      return child;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (status) {
      case RequestStatus.loading:
        return const StatusAnimationView(
          lottiePath: ImagesConstants.lottieLoading,
          message: "Processing your request...",
        );
      case RequestStatus.failure:
        return StatusAnimationView(
          lottiePath: ImagesConstants.lottieFailure,
          message: "Something went wrong",
          buttonText: "Try Again",
          onPressed: onRetry,
        );
      case RequestStatus.serverFailure:
        return StatusAnimationView(
          lottiePath: ImagesConstants.lottieServerFailure,
          message: "Server connection lost",
          buttonText: "Refresh",
          onPressed: onRetry,
        );
      case RequestStatus.offlineFailure:
        return StatusAnimationView(
          lottiePath: ImagesConstants.lottieOffline,
          message: "No internet connection",
          buttonText: "Retry",
          onPressed: onRetry,
        );
      default:
        return child;
    }
  }
}

class StatusAnimationView extends StatelessWidget {
  const StatusAnimationView({
    super.key,
    required this.lottiePath,
    required this.message,
    this.buttonText,
    this.onPressed,
  });

  final String lottiePath;
  final String message;
  final String? buttonText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: AppSpacing.xl),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              lottiePath,
              width: MediaQuery.sizeOf(context).width * 0.7,
              fit: BoxFit.contain,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(const ['**'], value: AppColors.primary),
                ],
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: AppSpacing.l),
            ),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
              ),
            ),
            if (buttonText != null && onPressed != null) ...[
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: AppSpacing.xl),
              ),
              SizedBox(
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 200,
                ),
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    buttonText!,
                    style: TextStyle(
                      fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

}
