import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';

class BaseCubit extends Cubit<BaseState> {
  BaseCubit(super.initialState);

  void toggleTheme() {
    emit((state is LightTheme) ? DarkTheme() : LightTheme());
  }
}
