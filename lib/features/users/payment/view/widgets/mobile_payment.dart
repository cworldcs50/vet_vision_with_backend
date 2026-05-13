import 'package:get/get.dart';
import '../../../booking/view/widgets/custom_checkout_doctor_card.dart';
import '../../../booking/view/widgets/custom_elevated_btn.dart';
import '../../controller/payment_controller.dart';
import 'custom_info_box.dart';
import 'package:flutter/material.dart';
import 'custom_order_summary_row.dart';
import 'custom_payment_method_option.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class MobilePayment extends StatelessWidget {
  const MobilePayment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      builder: (controller) {
        return SingleChildScrollView(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCheckoutDoctorCard(
                specialty: "Session",
                price: controller.consultationFee,
                doctorName: controller.doctorName,
                imgPath: "assets/images/doctor.png",
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 24,
                ),
              ),
              Text(
                "Payment Method",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
              CustomPaymentMethodOption(
                value: "visa",
                icon: Icons.credit_card,
                title: "Pay by Visa / Card",
                subtitle: "Credit or debit card",
                groupValue: controller.selectedPaymentMethod,
                onChanged: (val) => controller.setPaymentMethod(val),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
              ),
              CustomPaymentMethodOption(
                value: "arrival",
                icon: Icons.money,
                title: "Pay on Arrival",
                subtitle: "Cash at the clinic",
                groupValue: controller.selectedPaymentMethod,
                onChanged: (val) => controller.setPaymentMethod(val),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 24,
                ),
              ),
              if (controller.sessionType.toLowerCase() == "online")
                const CustomInfoBox(
                  icon: Icons.videocam_outlined,
                  text:
                      "Online sessions require payment by card before the consultation begins. You'll receive a video link after payment.",
                )
              else if (controller.selectedPaymentMethod == "arrival")
                const CustomInfoBox(
                  icon: Icons.info_outline,
                  text:
                      "Your appointment is reserved. Please arrive 10 minutes early and pay at the reception. Accepted: Cash or card at clinic.",
                ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 24,
                ),
              ),
              CustomOrderSummaryRow(
                title: "Consultation fee",
                value: "\$${controller.consultationFee.toStringAsFixed(0)}",
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 8,
                ),
              ),
              CustomOrderSummaryRow(
                title: "Service fee",
                value: "\$${controller.serviceFee.toStringAsFixed(0)}",
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 8,
                ),
              ),
              const Divider(),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 8,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    "\$${controller.totalAmount.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: const Color(0xFF009689),
                      fontWeight: FontWeight.bold,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 32,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedBtn(
                  btnTitle: controller.selectedPaymentMethod == "visa"
                      ? "Pay \$${controller.totalAmount.toStringAsFixed(0)}"
                      : "Confirm Booking",
                  onPressed: controller.confirmBooking,
                ),
              ),
              SizedBox(
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 32,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
