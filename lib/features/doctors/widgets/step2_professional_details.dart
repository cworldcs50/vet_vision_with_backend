// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controller/auth/auth_controller.dart';
// import '../../../core/classes/adaptive_layout.dart';
// import '../../auth/widgets/custom_auth_button.dart';
// import '../../auth/widgets/custom_text_form_field.dart';
// import 'step_title.dart';

// class Step2ProfessionalDetails extends GetView<AuthController> {
//   const Step2ProfessionalDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: controller.doctorStep2FormKey,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const StepTitle(
//               title: "Professional Details",
//               subtitle: "Tell us about your veterinary expertise",
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 20,
//               ),
//             ),
//             CustomTextFormField(
//               hint: "e.g., Small Animal Internist",
//               label: "Specialization",
//               prefixIcon: Icons.psychology_outlined,
//               controller: controller.specializationController,
//               validator: (v) => controller.commonValidator(v, "Specialization"),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 16,
//               ),
//             ),
//             CustomTextFormField(
//               hint: "e.g., 10",
//               label: "Years of Experience",
//               prefixIcon: Icons.work_history_outlined,
//               keyboardType: TextInputType.number,
//               controller: controller.experienceController,
//               validator: (v) => controller.commonValidator(v, "Experience"),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 16,
//               ),
//             ),
//             CustomTextFormField(
//               hint: "VET-123456",
//               label: "License Number",
//               prefixIcon: Icons.badge_outlined,
//               controller: controller.licenseController,
//               validator: (v) => controller.commonValidator(v, "License Number"),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 16,
//               ),
//             ),
//             CustomTextFormField(
//               hint: "Tell us about your experience...",
//               label: "About You",
//               prefixIcon: Icons.description_outlined,
//               maxLines: 4,
//               controller: controller.bioController,
//               validator: (v) => controller.commonValidator(v, "Bio"),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 20,
//               ),
//             ),
//             Text(
//               "Profile Picture",
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
//             GetBuilder<AuthController>(
//               builder: (controller) {
//                 return GestureDetector(
//                   onTap: () => controller.pickImage(),
//                   child: Container(
//                     height: AdaptiveLayout.getResponsiveFontSize(
//                       context,
//                       fontSize: 120,
//                     ),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: BorderRadius.circular(
//                         AdaptiveLayout.getResponsiveFontSize(
//                           context,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                     child:
//                         controller.profileImage != null
//                             ? ClipRRect(
//                               borderRadius: BorderRadius.circular(
//                                 AdaptiveLayout.getResponsiveFontSize(
//                                   context,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                               child: Image.file(
//                                 File(controller.profileImage!.path),
//                                 fit: BoxFit.cover,
//                               ),
//                             )
//                             : Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Icons.cloud_upload_outlined,
//                                   size: AdaptiveLayout.getResponsiveFontSize(
//                                     context,
//                                     fontSize: 40,
//                                   ),
//                                   color: Colors.grey,
//                                 ),
//                                 Text(
//                                   "Upload profile picture",
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize:
//                                         AdaptiveLayout.getResponsiveFontSize(
//                                           context,
//                                           fontSize: 12,
//                                         ),
//                                   ),
//                                 ),
//                                 Text(
//                                   "(PNG, JPG up to 5MB)",
//                                   style: TextStyle(
//                                     color: Colors.grey.shade400,
//                                     fontSize:
//                                         AdaptiveLayout.getResponsiveFontSize(
//                                           context,
//                                           fontSize: 10,
//                                         ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                   ),
//                 );
//               },
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
//                     onPressed: () => controller.nextStep(),
//                     backgroundColor: const Color(0xFF009689),
//                     child: const Text(
//                       "Next",
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
