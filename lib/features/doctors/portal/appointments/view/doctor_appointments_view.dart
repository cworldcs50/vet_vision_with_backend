import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../doctor_portal_controller.dart';
import '../../../widgets/appointments_list.dart';
import '../../../widgets/search_and_filter_section.dart';

class DoctorAppointmentsView extends GetView<DoctorPortalController> {
  const DoctorAppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => controller.fetchAppointments(),
      color: const Color(0xFF009689),
      child: Column(
        children: const [
          SearchAndFilterSection(),
          Expanded(child: AppointmentsList()),
        ],
      ),
    );
  }
}
