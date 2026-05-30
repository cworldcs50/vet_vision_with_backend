import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class BookingCard extends StatelessWidget {
  final String date;
  final String doctorName;
  final String specialization;
  final String time;
  final String status;

  const BookingCard({
    super.key,
    required this.date,
    required this.doctorName,
    required this.specialization,
    required this.time,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    bool isUpcoming = status == "Upcoming";

    return Container(
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 10,
            ),
            offset: Offset(
              0,
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
            ),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 4,
                  ),
                  horizontal: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                ),
                decoration: BoxDecoration(
                  color: isUpcoming
                      ? AppColors.primaryColor.withValues(alpha: .1)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
                  ),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isUpcoming
                        ? AppColors.primaryColor
                        : Colors.grey[700],
                    fontWeight: FontWeight.w600,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Spacer(flex: 2),

          /// Doctor Info
          Row(
            children: [
              CircleAvatar(
                radius: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 20,
                ),
                backgroundColor: AppColors.primaryColor.withValues(alpha: .2),
                child: Icon(
                  Icons.person,
                  color: AppColors.primaryColor,
                  size: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 22,
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      specialization,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(flex: 2),

          const Divider(),

          const Spacer(),

          Row(
            children: [
              Icon(
                Icons.access_time,
                color: Colors.grey[600],
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),

              const Spacer(),

              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                ),
              ),

              const Spacer(),

              if (isUpcoming)
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: const BorderSide(color: AppColors.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    "Reschedule",
                    style: TextStyle(
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
