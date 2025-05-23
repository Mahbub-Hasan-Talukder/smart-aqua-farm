import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/alerts.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/di/di.dart';
import '../../../../core/navigation/routes.dart';
import '../onboarding_cubit/onboarding_cubit.dart';
import '../widgets/onboarding_nav.dart';
import 'onboarding_items.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final pageController = PageController();
  final _onBoardingCubit = getIt<OnboardingCubit>();

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = OnboardingItems.getItem(context);
    return Scaffold(
      appBar: CommonAppBar(title: 'Welcome').build(context),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child:
            isLastPage
                ? getStarted()
                : OnboardingNav(pageController: pageController, items: items),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged:
              (index) => setState(() => isLastPage = items.length - 1 == index),
          itemCount: items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(items[index].imagePath),
                const SizedBox(height: 15),
                items[index].title,
                const SizedBox(height: 15),
                items[index].descriptions,
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).primaryColor,
      ),
      width: MediaQuery.sizeOf(context).width * .9,
      height: 55,
      child: TextButton(
        onPressed: () async {
          _onBoardingCubit.setOnboardingCompleted();
        },
        child: BlocConsumer<OnboardingCubit, OnboardingState>(
          bloc: _onBoardingCubit,
          listener: (context, state) {
            if (state is OnboardingError) {
              AppAlerts.showSnackBar(
                context: context,
                message: state.message,
                isError: true,
              );
            }
            if (state is OnboardingLoaded) {
              context.go(MyRoutes.signInRoute);
            }
          },
          builder: (context, state) {
            if (state is OnboardingLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                  strokeWidth: 2,
                ),
              );
            }
            return const Text(
              "Get started",
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
