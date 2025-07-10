import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';

class BaseCubit extends Cubit<BaseState> {
  BaseCubit(super.initialState);

  void toggleTheme() {
    emit((state is LightThemeState) ? DarkThemeState() : LightThemeState());
  }

  void changeLocale(Locale locale) {
    emit(ChangingLocaleState(locale: locale));
  }
}
