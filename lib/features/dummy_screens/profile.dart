import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_aqua_farm/core/di/di.dart';
import 'package:smart_aqua_farm/core/navigation/routes.dart';
import 'package:smart_aqua_farm/core/widgets/app_bar.dart';

import '../../core/services/auth_service/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authClient = getIt<AuthService>().getAuthClient();
    return Scaffold(
      appBar: CommonAppBar(title: 'Profile').build(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleLarge,
                  children: [
                    const TextSpan(
                      text: "User name: ",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text:
                          authClient.currentUser?.userMetadata?['full_name'] ??
                          'N/A',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  authClient.signOut();
                  context.go(MyRoutes.signInRoute);
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
