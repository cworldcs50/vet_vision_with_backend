// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controller/auth/auth_controller.dart';
// import '../../../core/classes/adaptive_layout.dart';

// class StepIndicator extends GetView<AuthController> {
//   const StepIndicator({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(3, (index) {
//         return Obx(() {
//           bool isActive = controller.currentDoctorStep.value > index;
//           return Container(
//             width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 40),
//             height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
//             margin: EdgeInsets.symmetric(
//               horizontal: AdaptiveLayout.getResponsiveFontSize(
//                 context,
//                 fontSize: 4,
//               ),
//             ),
//             decoration: BoxDecoration(
//               color: isActive ? Colors.white : Colors.white24,
//               borderRadius: BorderRadius.circular(
//                 AdaptiveLayout.getResponsiveFontSize(context, fontSize: 2),
//               ),
//             ),
//           );
//         });
//       }),
//     );
//   }
// }
