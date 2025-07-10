import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BaseState extends Equatable {
  final ThemeMode themeMode;
  final Locale locale;

  const BaseState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('en'),
  });

  @override
  List<Object?> get props => [themeMode, locale];
}

class LightThemeState extends BaseState {
  const LightThemeState({super.locale}) : super(themeMode: ThemeMode.light);
}

class DarkThemeState extends BaseState {
  const DarkThemeState({super.locale}) : super(themeMode: ThemeMode.dark);
}

class ChangingLocaleState extends BaseState {
  const ChangingLocaleState({super.themeMode, super.locale});
}
