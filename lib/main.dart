import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/local/hive_services.dart';
import 'core/services/firebase_service/firebase_setup.dart';
import 'core/di/di.dart';
import 'core/logger/logger.dart';
import 'core/services/auth_service/auth_service.dart';
import 'smart_aqua_farm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    setupLocator();
    Bloc.observer = AppBlocObserver();
    await getIt<HiveServices>().init();
    await getIt<AuthService>().init();
    await getIt<FirebaseCrashLyticsSetup>().init();
  } catch (e, s) {
    logger.e(e.toString());
    logger.e(s.toString());
  }
  runApp(MyApp());
}
