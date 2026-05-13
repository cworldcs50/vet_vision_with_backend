// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import '../widgets/registration_header.dart';
// import '../widgets/step1_personal_info.dart';
// import '../../../core/classes/adaptive_layout.dart';
// import '../../../controller/auth/auth_controller.dart';
// import '../widgets/step2_professional_details.dart';
// import '../widgets/step3_practice_details.dart';

// class DoctorRegistrationView extends GetView<AuthController> {
//   const DoctorRegistrationView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF009689),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Column(
//         children: [
//           const RegistrationHeader(),
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(
//                     AdaptiveLayout.getResponsiveFontSize(context, fontSize: 30),
//                   ),
//                   topRight: Radius.circular(
//                     AdaptiveLayout.getResponsiveFontSize(context, fontSize: 30),
//                   ),
//                 ),
//               ),
//               padding: EdgeInsets.all(
//                 AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
//               ),
//               child: PageView(
//                 controller: controller.doctorRegistrationPageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: const [
//                   Step1PersonalInfo(),
//                   Step2ProfessionalDetails(),
//                   Step3PracticeDetails(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }