import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../portal/appointments/data/models/doctor_appointment_model.dart';
import '../doctor_portal_controller.dart';
import 'info_icon_text.dart';
import '../../../core/classes/adaptive_layout.dart';

class AppointmentCardDetailed extends StatelessWidget {
  final DoctorAppointmentModel appointment;

  const AppointmentCardDetailed({super.key, required this.appointment});

  // Helper: convert month number to abbreviated name
  String _monthName(int m) => const [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][m];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        ),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 8,
            ),
            offset: Offset(
              0,
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 2),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row: avatar + name + status badge ─────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 40,
                    ),
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 40,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF009689).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        appointment.patientName.isNotEmpty
                            ? appointment.patientName[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          color: const Color(0xFF009689),
                          fontWeight: FontWeight.bold,
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.patientName,
                        style: TextStyle(
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 14,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "${appointment.petName} • ${appointment.petType}",
                        style: TextStyle(
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 12,
                          ),
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Status badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 8,
                  ),
                  vertical: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 4,
                  ),
                ),
                decoration: BoxDecoration(
                  color: appointment.status == 'completed'
                      ? Colors.blue.withValues(alpha: 0.1)
                      : appointment.status == 'cancelled'
                      ? Colors.red.withValues(alpha: 0.1)
                      : const Color(0xFF009689).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
                  ),
                ),
                child: Text(
                  appointment.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 10,
                    ),
                    fontWeight: FontWeight.bold,
                    color: appointment.status == 'completed'
                        ? Colors.blue
                        : appointment.status == 'cancelled'
                        ? Colors.red
                        : const Color(0xFF009689),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),

          // ── Date & time row ───────────────────────────────────────────────
          Row(
            children: [
              InfoIconText(
                icon: Icons.calendar_today_outlined,
                // Fix: real date from model, not hardcoded mock
                text:
                    "${appointment.date.day} ${_monthName(appointment.date.month)} ${appointment.date.year}",
              ),
              SizedBox(
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 20,
                ),
              ),
              InfoIconText(icon: Icons.access_time, text: appointment.time),
            ],
          ),

          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),

          // ── Type & payment row ────────────────────────────────────────────
          Row(
            children: [
              InfoIconText(
                icon: appointment.isOnline
                    ? Icons.videocam_outlined
                    : Icons.location_on_outlined,
                text: appointment.isOnline ? "Online" : "In-Person",
              ),
              SizedBox(
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 20,
                ),
              ),
              InfoIconText(
                icon: Icons.payment,
                text: appointment.isPaid ? "Paid" : "Pay on arrival",
                textColor: appointment.isPaid ? Colors.green : Colors.orange,
              ),
            ],
          ),

          // ── Notes section ─────────────────────────────────────────────────
          if (appointment.notes.isNotEmpty) ...[
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notes:",
                    style: TextStyle(
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 10,
                      ),
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    appointment.notes,
                    style: TextStyle(
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 11,
                      ),
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // ── Action buttons (only for upcoming / pending appointments) ─────
          if (appointment.status == 'upcoming') ...[
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 12,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Get.find<DoctorPortalController>()
                        .updateAppointmentStatus(appointment.id, 'cancelled'),
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                    ),
                    label: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(
                        vertical: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 8,
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
                  child: ElevatedButton.icon(
                    onPressed: () => Get.find<DoctorPortalController>()
                        .updateAppointmentStatus(appointment.id, 'completed'),
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                    ),
                    label: const Text(
                      "Complete",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF009689),
                      padding: EdgeInsets.symmetric(
                        vertical: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
