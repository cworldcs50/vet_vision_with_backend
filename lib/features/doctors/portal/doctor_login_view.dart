// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controller/auth/auth_controller.dart';
// import '../../../core/classes/adaptive_layout.dart';
// import '../../../core/constants/images_constants.dart';
// import '../../../core/routes/app_routes_name.dart';
// import '../../auth/widgets/custom_text_form_field.dart';
// import '../../auth/widgets/custom_auth_button.dart';
// import '../widgets/social_login_button.dart';

// class DoctorLoginView extends GetView<AuthController> {
//   const DoctorLoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF009689),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: AdaptiveLayout.getResponsiveFontSize(
//               context,
//               fontSize: 24,
//             ),
//             vertical: AdaptiveLayout.getResponsiveFontSize(
//               context,
//               fontSize: 60,
//             ),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(
//                   AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
//                 ),
//                 decoration: const BoxDecoration(
//                   color: Colors.white24,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.medical_services_outlined,
//                   color: Colors.white,
//                   size: AdaptiveLayout.getResponsiveFontSize(
//                     context,
//                     fontSize: 40,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: AdaptiveLayout.getResponsiveFontSize(
//                   context,
//                   fontSize: 16,
//                 ),
//               ),
//               Text(
//                 "Doctor Login",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: AdaptiveLayout.getResponsiveFontSize(
//                     context,
//                     fontSize: 24,
//                   ),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: AdaptiveLayout.getResponsiveFontSize(
//                   context,
//                   fontSize: 8,
//                 ),
//               ),
//               Text(
//                 "Access your doctor portal",
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: AdaptiveLayout.getResponsiveFontSize(
//                     context,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: AdaptiveLayout.getResponsiveFontSize(
//                   context,
//                   fontSize: 30,
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(
//                   AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(
//                     AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
//                   ),
//                 ),
//                 child: Form(
//                   key: controller.authFormKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomTextFormField(
//                         hint: "doctor@example.com",
//                         label: "Email Address",
//                         prefixIcon: Icons.email_outlined,
//                         controller: controller.emailController,
//                         validator: controller.emailValidator,
//                       ),
//                       SizedBox(
//                         height: AdaptiveLayout.getResponsiveFontSize(
//                           context,
//                           fontSize: 16,
//                         ),
//                       ),
//                       GetBuilder<AuthController>(
//                         builder:
//                             (c) => CustomTextFormField(
//                               hint: "********",
//                               label: "Password",
//                               obscureText: c.showPassword,
//                               onPressed: c.visiblePassword,
//                               prefixIcon: Icons.lock_outline,
//                               suffixIcon: c.showPasswordSuffixIcon,
//                               controller: controller.passwordController,
//                               validator: controller.passwordValidator,
//                             ),
//                       ),
//                       SizedBox(
//                         height: AdaptiveLayout.getResponsiveFontSize(
//                           context,
//                           fontSize: 8,
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: AdaptiveLayout.getResponsiveFontSize(
//                                   context,
//                                   fontSize: 20,
//                                 ),
//                                 height: AdaptiveLayout.getResponsiveFontSize(
//                                   context,
//                                   fontSize: 20,
//                                 ),
//                                 child: Checkbox(
//                                   value: true,
//                                   onChanged: (v) {},
//                                   activeColor: const Color(0xFF009689),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: AdaptiveLayout.getResponsiveFontSize(
//                                   context,
//                                   fontSize: 8,
//                                 ),
//                               ),
//                               Text(
//                                 "Remember me",
//                                 style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize:
//                                       AdaptiveLayout.getResponsiveFontSize(
//                                         context,
//                                         fontSize: 12,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           TextButton(
//                             onPressed: () => controller.forgetPassword(),
//                             child: Text(
//                               "Forgot password?",
//                               style: TextStyle(
//                                 color: const Color(0xFF009689),
//                                 fontSize: AdaptiveLayout.getResponsiveFontSize(
//                                   context,
//                                   fontSize: 12,
//                                 ),
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: AdaptiveLayout.getResponsiveFontSize(
//                           context,
//                           fontSize: 20,
//                         ),
//                       ),
//                       CustomAuthButton(
//                         backgroundColor: const Color(0xFF009689),
//                         onPressed: () => controller.signIn(),
//                         child: const Text(
//                           "Sign In",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: AdaptiveLayout.getResponsiveFontSize(
//                           context,
//                           fontSize: 20,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Expanded(child: Divider(color: Colors.grey.shade300)),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: AdaptiveLayout.getResponsiveFontSize(
//                                 context,
//                                 fontSize: 10,
//                               ),
//                             ),
//                             child: Text(
//                               "or continue with",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: AdaptiveLayout.getResponsiveFontSize(
//                                   context,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(child: Divider(color: Colors.grey.shade300)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: AdaptiveLayout.getResponsiveFontSize(
//                           context,
//                           fontSize: 20,
//                         ),
//                       ),
//                       SocialLoginButton(
//                         iconPath: ImagesConstants.googleIcon,
//                         text: "Google",
//                         onPressed: () => controller.authWithGoogle(),
//                       ),
//                       SizedBox(
//                         height: AdaptiveLayout.getResponsiveFontSize(
//                           context,
//                           fontSize: 12,
//                         ),
//                       ),
//                       SocialLoginButton(
//                         icon: Icons.facebook,
//                         iconColor: const Color(0xFF1877F2),
//                         text: "Facebook",
//                         onPressed: () => controller.authWithFacebook(),
//                       ),
//                       SizedBox(
//                         height: AdaptiveLayout.getResponsiveFontSize(
//                           context,
//                           fontSize: 24,
//                         ),
//                       ),
//                       Center(
//                         child: GestureDetector(
//                           onTap: () => Get.toNamed(AppRoutesName.rDoctorSignUp),
//                           child: RichText(
//                             text: TextSpan(
//                               text: "Don't have an account? ",
//                               style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: AdaptiveLayout.getResponsiveFontSize(
//                                   context,
//                                   fontSize: 13,
//                                 ),
//                               ),
//                               children: [
//                                 const TextSpan(
//                                   text: "Register as Doctor",
//                                   style: TextStyle(
//                                     color: Color(0xFF009689),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

