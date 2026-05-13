// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controller/auth/auth_controller.dart';
// import '../../../core/classes/adaptive_layout.dart';
// import '../../auth/widgets/custom_auth_button.dart';
// import '../../auth/widgets/custom_text_form_field.dart';
// import 'step_title.dart';

// class Step1PersonalInfo extends GetView<AuthController> {
//   const Step1PersonalInfo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: controller.doctorStep1FormKey,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const StepTitle(
//               title: "Personal Information",
//               subtitle: "Let's start with your basic details",
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 20,
//               ),
//             ),
//             CustomTextFormField(
//               hint: "Dr. John Smith",
//               label: "Full Name",
//               prefixIcon: Icons.person_outline,
//               controller: controller.fullNameController,
//               validator: controller.fullNameValidator,
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 16,
//               ),
//             ),
//             CustomTextFormField(
//               hint: "doctor@example.com",
//               label: "Email Address",
//               prefixIcon: Icons.email_outlined,
//               controller: controller.emailController,
//               validator: controller.emailValidator,
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 16,
//               ),
//             ),
//             CustomTextFormField(
//               hint: "+1 (555) 123-4567",
//               label: "Phone Number",
//               prefixIcon: Icons.phone_outlined,
//               controller: controller.phoneController,
//               validator: controller.phoneValidator,
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 16,
//               ),
//             ),
//             GetBuilder<AuthController>(
//               builder:
//                   (c) => CustomTextFormField(
//                     hint: "********",
//                     label: "Password",
//                     prefixIcon: Icons.lock_outline,
//                     obscureText: c.showPassword,
//                     onPressed: c.visiblePassword,
//                     suffixIcon: c.showPasswordSuffixIcon,
//                     controller: controller.passwordController,
//                     validator: controller.passwordValidator,
//                   ),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 16,
//               ),
//             ),
//             GetBuilder<AuthController>(
//               builder:
//                   (c) => CustomTextFormField(
//                     hint: "********",
//                     label: "Confirm Password",
//                     prefixIcon: Icons.lock_outline,
//                     obscureText: c.showConfirmedPassword,
//                     onPressed: c.visibleConfirmedPassword,
//                     suffixIcon: c.showConfirmedPasswordSuffixIcon,
//                     controller: controller.confirmedPasswordController,
//                     validator: controller.confirmedPasswordValidator,
//                   ),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 30,
//               ),
//             ),
//             CustomAuthButton(
//               onPressed: () => controller.nextStep(),
//               backgroundColor: const Color(0xFF009689),
//               child: const Text(
//                 "Next",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 16,
//               ),
//             ),
//             Center(
//               child: GestureDetector(
//                 onTap: () => Get.back(),
//                 child: RichText(
//                   text: TextSpan(
//                     text: "Already have an account? ",
//                     style: TextStyle(
//                       color: Colors.black54,
//                       fontSize: AdaptiveLayout.getResponsiveFontSize(
//                         context,
//                         fontSize: 14,
//                       ),
//                     ),
//                     children: const [
//                       TextSpan(
//                         text: "Sign In",
//                         style: TextStyle(
//                           color: Color(0xFF009689),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

