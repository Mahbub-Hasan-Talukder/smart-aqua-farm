import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/reset_pass_screen.dart';
import '../../features/library/presentation/screens/dis_details.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/forget_pass_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/auth/presentation/screens/signin_screen.dart';
import '../../features/dummy_screens/profile.dart';
import 'error_page.dart';
import 'nav_bar.dart';
import 'routes.dart';
import '../../features/home/presentation/screen/home.dart';
import '../../features/library/presentation/screens/library.dart';

class MyRouterConfig {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static void refresh() {
    router.go(MyRoutes.profile);
  }

  static final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    observers: [MyRouterObserver()],
    errorBuilder: (context, state) {
      return const ErrorPage();
    },

    initialLocation: MyRoutes.splashRoute,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: MyRoutes.home,
                builder: (context, state) {
                  return const HomeScreen();
                },
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: MyRoutes.library,
                builder: (context, state) {
                  return LibraryScreen();
                },
                routes: [
                  GoRoute(
                    path: MyRoutes.diseasesDetails,
                    builder: (context, state) {
                      final diseaseName = state.extra as String?;
                      return DisDetailsScreen(
                        diseaseName: diseaseName ?? 'No name provided',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: MyRoutes.profile,
                builder: (context, state) {
                  return const ProfileScreen();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: MyRoutes.splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: MyRoutes.signInRoute,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: MyRoutes.signUpRoute,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: MyRoutes.forgotPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
        routes: [
          GoRoute(
            path: MyRoutes.otpRoute,
            builder: (context, state) {
              final email = state.extra as String?;
              return ResetPassScreen(email: email ?? 'No email provided');
            },
          ),
        ],
      ),
      GoRoute(
        path: MyRoutes.onboard,
        builder: (context, state) => const OnboardingView(),
      ),
    ],
  );
}

class MyRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _updateBackButtonBehavior(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _updateBackButtonBehavior(previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _updateBackButtonBehavior(newRoute);
  }

  Future<void> _updateBackButtonBehavior(Route? route) async {}
}
