import 'onboarding_body.dart';
import 'package:flutter/material.dart';
import '../../data/static/on_boarding_data.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({
    super.key,
    required this.next,
    required this.onPageChanged,
    required this.pageController,
  });

  final void Function() next;
  final PageController pageController;
  final void Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: kOnBoardingData.length,
      physics: const ClampingScrollPhysics(),
      scrollBehavior: const ScrollBehavior(),
      controller: pageController,
      onPageChanged: (index) => onPageChanged(index),
      itemBuilder:
          (context, index) => CustomOnBoardingBody(
            next: next,
            title: kOnBoardingData[index].title,
            imgPath: kOnBoardingData[index].imgUrl,
            description: kOnBoardingData[index].description,
          ),
    );
  }
}
