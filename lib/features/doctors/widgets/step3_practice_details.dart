// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controller/auth/auth_controller.dart';
// import '../../../core/classes/adaptive_layout.dart';
// import '../../auth/widgets/custom_auth_button.dart';
// import '../../auth/widgets/custom_text_form_field.dart';
// import 'consultation_type_tile.dart';
// import 'step_title.dart';

// class Step3PracticeDetails extends GetView<AuthController> {
//   const Step3PracticeDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: controller.doctorStep3FormKey,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const StepTitle(
//               title: "Practice Details",
//               subtitle: "Set up your consultation preferences",
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 20,
//               ),
//             ),
//             CustomTextFormField(
//               hint: "\$ e.g., 50",
//               label: "Session Cost (USD)",
//               prefixIcon: Icons.attach_money,
//               keyboardType: TextInputType.number,
//               controller: controller.sessionCostController,
//               validator: (v) => controller.commonValidator(v, "Session Cost"),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 20,
//               ),
//             ),
//             Text(
//               "Consultation Types *",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: AdaptiveLayout.getResponsiveFontSize(
//                   context,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 8,
//               ),
//             ),
//             Obx(
//               () => ConsultationTypeTile(
//                 title: "Online Consultation",
//                 subtitle: "Video/phone consultations",
//                 value: controller.isOnlineConsultation.value,
//                 onChanged: (v) => controller.isOnlineConsultation.value = v!,
//               ),
//             ),
//             Obx(
//               () => ConsultationTypeTile(
//                 title: "In-Person Consultation",
//                 subtitle: "At your clinic location",
//                 value: controller.isInPersonConsultation.value,
//                 onChanged: (v) => controller.isInPersonConsultation.value = v!,
//               ),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 16,
//               ),
//             ),
//             CustomTextFormField(
//               hint: "Enter your clinic address",
//               label: "Clinic Address *",
//               prefixIcon: Icons.location_on_outlined,
//               controller: controller.clinicAddressController,
//               validator: (v) => controller.commonValidator(v, "Clinic Address"),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 20,
//               ),
//             ),
//             Obx(
//               () => CheckboxListTile(
//                 value: controller.termsAccepted.value,
//                 onChanged: (v) => controller.termsAccepted.value = v!,
//                 title: Text(
//                   "I agree to the Terms and Conditions and Privacy Policy. I confirm that all information provided is accurate and I hold valid veterinary credentials.",
//                   style: TextStyle(
//                     fontSize: AdaptiveLayout.getResponsiveFontSize(
//                       context,
//                       fontSize: 12,
//                     ),
//                     color: Colors.black54,
//                   ),
//                 ),
//                 controlAffinity: ListTileControlAffinity.leading,
//                 contentPadding: EdgeInsets.zero,
//                 activeColor: const Color(0xFF009689),
//               ),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 30,
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => controller.previousStep(),
//                     style: OutlinedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(
//                         vertical: AdaptiveLayout.getResponsiveFontSize(
//                           context,
//                           fontSize: 14,
//                         ),
//                       ),
//                       side: const BorderSide(color: Color(0xFF009689)),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(
//                           AdaptiveLayout.getResponsiveFontSize(
//                             context,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ),
//                     child: const Text(
//                       "Back",
//                       style: TextStyle(color: Color(0xFF009689)),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: AdaptiveLayout.getResponsiveFontSize(
//                     context,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomAuthButton(
//                     // onPressed: () => controller.completeDoctorRegistration(),
//                     onPressed: () {},
//                     backgroundColor: const Color(0xFF009689),
//                     child: const Text(
//                       "Complete Registration",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
