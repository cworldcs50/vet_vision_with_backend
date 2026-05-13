import '../portal/appointments/data/models/doctor_appointment_model.dart';
import 'info_icon_text.dart';
import 'package:flutter/material.dart';
import '../../../core/classes/adaptive_layout.dart';

class AppointmentCardDetailed extends StatelessWidget {
  final DoctorAppointmentModel appointment;

  const AppointmentCardDetailed({super.key, required this.appointment});

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
                        appointment.patientName[0],
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
                  color:
                      appointment.status == "completed"
                          ? Colors.blue.withValues(alpha: 0.1)
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
                    color:
                        appointment.status == "completed"
                            ? Colors.blue
                            : const Color(0xFF009689),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          ),
          Row(
            children: [
              const InfoIconText(
                icon: Icons.calendar_today_outlined,
                text: "Mar 25, 2026", // Mock date format
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
          Row(
            children: [
              InfoIconText(
                icon:
                    appointment.isOnline
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
        ],
      ),
    );
  }
}
