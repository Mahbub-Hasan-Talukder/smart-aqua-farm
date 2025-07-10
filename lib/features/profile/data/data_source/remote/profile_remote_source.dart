abstract class ProfileRemoteSource {
  Future<Map<String, dynamic>> fetchProfile();
  Future<void> editProfile(Map<String, dynamic> newUserData);
}
