import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../doctor_portal_controller.dart';
import '../../../widgets/appointments_list.dart';
import '../../../widgets/search_and_filter_section.dart';

class DoctorAppointmentsView extends GetView<DoctorPortalController> {
  const DoctorAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await controller.fetchAppointments(),
      color: AppColors.accent,
      child: Column(
        children: const [
          SearchAndFilterSection(),
          Expanded(child: AppointmentsList()),
        ],
      ),
    );
  }
}
