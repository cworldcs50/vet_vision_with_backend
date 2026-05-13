import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import 'custom_additional_notes.dart';
import 'custom_date_time_selector.dart';
import 'custom_elevated_btn.dart';
import 'custom_session_type_selector.dart';
import 'custom_checkout_doctor_card.dart';
import '../../controller/checkout_controller.dart';

class TabletCheckout extends GetView<CheckoutController> {
  const TabletCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutController());
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 40),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 16,
          ),
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomCheckoutDoctorCard(
              imgPath: "assets/images/doctor.png",
              doctorName: "Dr. Michael Chen",
              specialty: "Psychiatrist",
              price: 150,
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 24,
              ),
            ),

            Obx(
              () => CustomSessionTypeSelector(
                selectedType: controller.selectedSessionType.value,
                onChanged: controller.setSessionType,
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 24,
              ),
            ),

            // Date & Time
            Obx(
              () => CustomDateTimeSelector(
                selectedSlot: controller.selectedSlot.value,
                onSlotSelected: controller.setSlot,
                dateTimeSlots: const [
                  {
                    "date": "Tuesday, January 22, 2026",
                    "times": ["11:00 AM"],
                  },
                  {
                    "date": "Wednesday, January 21, 2026",
                    "times": ["9:00 AM", "4:00 PM"],
                  },
                  {
                    "date": "Friday, January 23, 2026",
                    "times": ["10:00 AM"],
                  },
                ],
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 24,
              ),
            ),

            // Additional Notes
            CustomAdditionalNotes(controller: controller.notesController),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 28,
              ),
            ),

            // Continue to Payment Button
            SizedBox(
              width: double.infinity,
              child: CustomElevatedBtn(
                btnTitle: "Proceed to Payment",
                onPressed: controller.proceedToPayment,
              ),
            ),
            SizedBox(
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
