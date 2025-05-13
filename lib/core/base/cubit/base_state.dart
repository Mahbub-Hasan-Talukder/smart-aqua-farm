import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BaseState extends Equatable {
  final ThemeMode themeMode = ThemeMode.system;
  @override
  List<Object?> get props => [themeMode];
}

class LightTheme extends BaseState {
  @override
  ThemeMode get themeMode => ThemeMode.light;
}

class DarkTheme extends BaseState {
  @override
  ThemeMode get themeMode => ThemeMode.dark;
}
