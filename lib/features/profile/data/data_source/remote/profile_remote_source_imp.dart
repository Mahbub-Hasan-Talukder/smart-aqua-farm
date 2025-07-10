import '../../../../../core/di/di.dart';
import '../../../../../core/services/auth_service/auth_service.dart';
import 'profile_remote_source.dart';

class ProfileRemoteSourceImp implements ProfileRemoteSource {
  final _authClient = getIt<AuthService>().getAuthClient();
  final _supabaseClient = getIt<AuthService>().getSupabaseClient();
  @override
  Future<Map<String, dynamic>> fetchProfile() async {
    final user = _authClient.currentUser;
    if (user == null) throw Exception('User not found');
    return await _supabaseClient
        .from('users')
        .select()
        .eq('id', user.id)
        .single();
  }

  @override
  Future<void> editProfile(Map<String, dynamic> newUserData) async {
    final user = _authClient.currentUser;
    if (user == null) throw Exception('User not found');
    await _supabaseClient.from('users').update(newUserData).eq('id', user.id);
  }
}
