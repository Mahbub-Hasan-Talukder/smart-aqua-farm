// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello_world => 'Hello, World!';

  @override
  String greeting(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get dark_mode => 'Dark Mode';

  @override
  String get light_mode => 'Light Mode';
}
