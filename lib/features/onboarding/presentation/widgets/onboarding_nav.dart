import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../screens/onboarding_info.dart';

class OnboardingNav extends StatelessWidget {
  const OnboardingNav({
    super.key,
    required this.pageController,
    required this.items,
  });

  final PageController pageController;
  final List<OnboardingInfo> items;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Skip Button
        TextButton(
          onPressed: () => pageController.jumpToPage(items.length - 1),
          child: const Text("Skip"),
        ),

        //Indicator
        SmoothPageIndicator(
          controller: pageController,
          count: items.length,
          onDotClicked:
              (index) => pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn,
              ),
          effect: WormEffect(
            dotHeight: 12,
            dotWidth: 12,
            activeDotColor: Theme.of(context).primaryColor,
          ),
        ),

        //Next Button
        TextButton(
          onPressed:
              () => pageController.nextPage(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn,
              ),
          child: const Text("Next"),
        ),
      ],
    );
  }
}
