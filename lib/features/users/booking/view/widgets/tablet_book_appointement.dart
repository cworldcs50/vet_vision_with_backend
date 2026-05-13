import 'custom_doctor_card.dart';
import 'package:flutter/material.dart';

class TabletBookAppointment extends StatelessWidget {
  const TabletBookAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) => const CustomDoctorCard(),
    );
  }
}
