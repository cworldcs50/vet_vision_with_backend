import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/network/request_status.dart';
import '../../controller/bookings_controller.dart';

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
                child: controller.requestStatus.value == RequestStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : items.isEmpty
                    ? const Center(child: Text("No appointments found"))
                    : ListView.separated(
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
                          final doctorName = item.doctor?.name ?? "Doctor";
                          final specialization =
                              item.doctor?.specialization ?? "Veterinarian";
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.primaryColor
                                    .withValues(alpha: 0.15),
                                child: const Icon(Icons.pets),
                              ),
                              title: Text(doctorName),
                              subtitle: Text(
                                "$specialization\n${item.dateTime}",
                              ),
                              trailing: Text(
                                item.status,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              isThreeLine: true,
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
