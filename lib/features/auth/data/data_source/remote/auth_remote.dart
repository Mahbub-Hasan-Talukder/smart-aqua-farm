import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../domain/entity/user_entity.dart';

abstract class AuthRemote {
  Future<User?> signUp(UserEntity userInfo);
  Future<AuthResponse> signIn(Map<String, dynamic> signInPayload);
  Future<AuthResponse> signInWithGoogle();
  Future<void> forgetPassword(String email);
  Future<void> resetPass(Map<String, dynamic> payload);
  Future<void> addUser(UserEntity userInfo);
  Future<Map<String, dynamic>> getUser(String id);
}
