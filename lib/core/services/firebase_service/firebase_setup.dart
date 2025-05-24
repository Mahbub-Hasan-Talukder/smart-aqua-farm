abstract class FirebaseCrashLyticsSetup {
  /// This method initializes Firebase with -
  /// * [FirebaseOptions] for the current platform.
  /// * Initializes Firebase Crashlytics for error reporting.
  /// * Sets up error handling for Flutter errors and platform errors.
  /// * This method should be called before using any Firebase services in the app.
  /// * It is recommended to call this method in the main function of the app.
  /// * It is also recommended to call this method before using any Firebase services in the app.
  Future<void> init();
}
