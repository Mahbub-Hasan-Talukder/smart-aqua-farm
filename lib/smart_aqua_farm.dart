import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/base/cubit/base_cubit.dart';
import 'core/base/cubit/base_state.dart';
import 'core/di/di.dart';
import 'core/navigation/router_config.dart';
import 'core/theme/theme.dart';
import 'core/localization/l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _baseCubit = getIt<BaseCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseCubit, BaseState>(
      bloc: _baseCubit,
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Smart Aqua Farm',
          theme: ThemeClass.lightTheme,
          darkTheme: ThemeClass.darkTheme,
          themeMode: state.themeMode,
          routerConfig: MyRouterConfig.router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.locale,
        );
      },
    );
  }
}
