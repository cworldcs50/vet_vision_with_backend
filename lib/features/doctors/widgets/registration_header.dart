// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controller/auth/auth_controller.dart';
// import '../../../core/classes/adaptive_layout.dart';
// import 'step_indicator.dart';

// class RegistrationHeader extends GetView<AuthController> {
//   const RegistrationHeader({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(
//               AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
//             ),
//             decoration: const BoxDecoration(
//               color: Colors.white24,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.medical_services_outlined,
//               color: Colors.white,
//               size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 40),
//             ),
//           ),
//           SizedBox(
//             height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
//           ),
//           Text(
//             "Join as a Doctor",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 24,
//               ),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(
//             height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 5),
//           ),
//           Obx(
//             () => Text(
//               "Step ${controller.currentDoctorStep.value} of 3",
//               style: TextStyle(
//                 color: Colors.white70,
//                 fontSize: AdaptiveLayout.getResponsiveFontSize(
//                   context,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 15),
//           ),
//           const StepIndicator(),
//         ],
//       ),
//     );
//   }
// }
