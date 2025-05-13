import 'package:flutter/material.dart';

import '../../core/widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final screenMeasures = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: CommonAppBar().build(context),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_front_rounded),
                  const SizedBox(width: 10),
                  Text("Take an Image"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Divider(thickness: 2, color: colorTheme.primary),
          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(50),
          //         topRight: Radius.circular(50),
          //       ),
          //       gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           colorTheme.primary,
          //           colorTheme.primary.withValues(alpha: 0),
          //         ],
          //       ),
          //     ),
          //     height: screenMeasures.height,
          //     width: screenMeasures.width,
          //   ),
          // ),
        ],
      ),
    );
  }
}
