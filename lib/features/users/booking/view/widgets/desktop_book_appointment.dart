import 'custom_doctor_card.dart';
import 'package:flutter/material.dart';

class DesktopBookAppointment extends StatelessWidget {
  const DesktopBookAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) => const CustomDoctorCard(),
    );
  }
}
