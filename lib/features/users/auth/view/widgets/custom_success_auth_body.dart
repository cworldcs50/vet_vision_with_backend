import 'package:flutter/widgets.dart';

class CustomSuccessAuthBody extends StatelessWidget {
  const CustomSuccessAuthBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("🎉", style: TextStyle()),
        Text("Welcome to VetVision!", style: TextStyle()),
        Text(
          "You're now signed in! The main app experience would start here.",
          style: TextStyle(),
        ),
      ],
    );
  }
}
