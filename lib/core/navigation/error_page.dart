import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_aqua_farm/core/navigation/routes.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404 Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page not found. Please check the URL.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.go(MyRoutes.home);
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
