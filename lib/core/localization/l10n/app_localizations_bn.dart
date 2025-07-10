// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get hello_world => 'হ্যালো বিশ্ব';

  @override
  String greeting(String name) {
    return '$name, হ্যালো!';
  }

  @override
  String get dark_mode => 'ডার্ক মোড';

  @override
  String get light_mode => 'লাইট মোড';
}
