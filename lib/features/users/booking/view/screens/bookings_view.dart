import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/network/request_status.dart';
import '../../../../../core/widgets/users_liquid_pull_to_refresh.dart';
import '../../controller/bookings_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          "My Bookings",
          style: TextStyle(
            color: Colors.black,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 18,
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: GetBuilder<BookingsController>(
        builder: (controller) {
          bool isSelected = controller.selectedTabIndex == 0;
          final items = isSelected
              ? controller.upcomingAppointments
              : controller.pastAppointments;
          return Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                  vertical: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 8,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.changeTab(0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 12,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Upcoming",
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey[700],
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 8,
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.changeTab(1),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 12,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: !isSelected
                                ? AppColors.primaryColor
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Past",
                              style: TextStyle(
                                color: !isSelected
                                    ? Colors.white
                                    : Colors.grey[700],
                                fontWeight: !isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: UsersLiquidPullToRefresh(
                  onRefresh: controller.loadAppointments,
                  child: controller.requestStatus.value == RequestStatus.loading
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 120,
                              ),
                            ),
                            Center(child: CircularProgressIndicator()),
                          ],
                        )
                      : items.isEmpty
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 16,
                            ),
                            vertical: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 16,
                            ),
                          ),
                          children: [
                            SizedBox(
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 120,
                              ),
                            ),
                            Center(child: Text('No appointments found')),
                          ],
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 16,
                            ),
                            vertical: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 16,
                            ),
                          ),
                          itemCount: items.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 12,
                            ),
                          ),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            final doctorName = item.doctor?.name ?? 'Doctor';
                            final specialization =
                                item.doctor?.specialization ?? 'Veterinarian';
                            return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColors.primaryColor
                                      .withValues(alpha: 0.15),
                                  child: const Icon(Icons.pets),
                                ),
                                title: Text(
                                  doctorName,
                                  style: TextStyle(
                                    fontSize:
                                        AdaptiveLayout.getResponsiveFontSize(
                                          context,
                                          fontSize: 16,
                                        ),
                                  ),
                                ),
                                subtitle: Text(
                                  '$specialization\n${item.dateTime}',
                                  style: TextStyle(
                                    fontSize:
                                        AdaptiveLayout.getResponsiveFontSize(
                                          context,
                                          fontSize: 12,
                                        ),
                                  ),
                                ),

                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      item.status.capitalizeFirst ??
                                          item.status,
                                      style: TextStyle(
                                        color: item.status == 'completed'
                                            ? Colors.green
                                            : AppColors.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            AdaptiveLayout.getResponsiveFontSize(
                                              context,
                                              fontSize: 10,
                                            ),
                                      ),
                                    ),
                                    if (item.status == 'completed' &&
                                        item.rating == 0) ...[
                                      SizedBox(
                                        height:
                                            AdaptiveLayout.getResponsiveFontSize(
                                              context,
                                              fontSize: 14,
                                            ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _showRatingDialog(
                                          context,
                                          controller,
                                          item.id,
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                AdaptiveLayout.getResponsiveFontSize(
                                                  context,
                                                  fontSize: 12,
                                                ),
                                            vertical:
                                                AdaptiveLayout.getResponsiveFontSize(
                                                  context,
                                                  fontSize: 4,
                                                ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.circular(
                                              AdaptiveLayout.getResponsiveFontSize(
                                                context,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            'Rate',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  AdaptiveLayout.getResponsiveFontSize(
                                                    context,
                                                    fontSize: 12,
                                                  ),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ] else if (item.status == 'completed' &&
                                        item.rating != null) ...[
                                      SizedBox(
                                        height:
                                            AdaptiveLayout.getResponsiveFontSize(
                                              context,
                                              fontSize: 4,
                                            ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size:
                                                AdaptiveLayout.getResponsiveFontSize(
                                                  context,
                                                  fontSize: 14,
                                                ),
                                          ),
                                          SizedBox(
                                            width:
                                                AdaptiveLayout.getResponsiveFontSize(
                                                  context,
                                                  fontSize: 2,
                                                ),
                                          ),
                                          Text(
                                            '${item.rating}',
                                            style: TextStyle(
                                              fontSize:
                                                  AdaptiveLayout.getResponsiveFontSize(
                                                    context,
                                                    fontSize: 12,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                                isThreeLine: true,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showRatingDialog(
    BuildContext context,
    BookingsController controller,
    String appointmentId,
  ) {
    double rating = 5.0;
    final commentCtrl = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text('Rate your visit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: 1,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (val) {
                rating = val;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: commentCtrl,
              decoration: const InputDecoration(
                hintText: 'Leave a comment (optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.submitReview(
                appointmentId,
                rating.toInt(),
                commentCtrl.text,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text('Submit', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
