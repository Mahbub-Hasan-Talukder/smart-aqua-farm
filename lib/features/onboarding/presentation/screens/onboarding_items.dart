import 'package:flutter/material.dart';

import '../../../../core/extensions/app_extension.dart';
import 'onboarding_info.dart';

class OnboardingItems {
  static List<OnboardingInfo> getItem(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    List<OnboardingInfo> items = [
      OnboardingInfo(
        title: Text(
          'Easy Fish Diseases Detection',
          style: textTheme.textBaseMedium,
        ),
        descriptions: Text(
          'Eearly fish disease detection is a crutial task for healthy fish farming. This app helps to detect fish disease by just taking photo',
          style: textTheme.textSmRegular,
          textAlign: TextAlign.center,
        ),
        imagePath: "assets/gifs/gif1.gif",
      ),

      OnboardingInfo(
        title: Text('Get Disease Information', style: textTheme.textBaseMedium),
        descriptions: Text(
          'This app provides detailed information about the detected fish disease, including symptoms, causes, and treatment options.',
          style: textTheme.textSmRegular,
          textAlign: TextAlign.center,
        ),
        imagePath: "assets/gifs/gif2.gif",
      ),
    ];
    return items;
  }
}
