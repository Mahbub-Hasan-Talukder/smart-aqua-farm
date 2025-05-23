import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../onboarding_cubit/onboarding_cubit.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/di/di.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _onboardingCubit = getIt<OnboardingCubit>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      _onboardingCubit.getOnboardingStatus();
    });
  }

  @override
  void dispose() {
    _onboardingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _buildBody());
  }

  Center _buildBody() {
    return Center(child: _bodyElements());
  }

  Column _bodyElements() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocConsumer<OnboardingCubit, OnboardingState>(
          bloc: _onboardingCubit,
          listener: (context, state) {
            if (state is OnboardingLoaded) {
              if (!state.onboardComplete) {
                context.go(MyRoutes.onboard);
              } else {
                _onboardingCubit.checkSignInStatus();
              }
            } else if (state is LoggedInStatus) {
              if (state.isSignedIn) {
                context.go(MyRoutes.home);
              } else {
                context.go(MyRoutes.signInRoute);
              }
            }
          },
          builder: (context, state) {
            if (state is OnboardingError) {
              return Center(child: Text(state.message));
            }
            return CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            );
          },
        ),
      ],
    );
  }
}
