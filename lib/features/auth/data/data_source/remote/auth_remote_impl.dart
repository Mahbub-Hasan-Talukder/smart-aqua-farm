import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/logger/logger.dart';
import '../../../../../core/services/auth_service/auth_service.dart';
import '../../../../../core/di/di.dart';
import '../../../domain/entity/user_entity.dart';
import 'auth_remote.dart';

class AuthRemoteImpl implements AuthRemote {
  final SupabaseClient supabaseClient;
  final authClient = getIt<AuthService>().getAuthClient();

  AuthRemoteImpl({SupabaseClient? supabaseClient})
    : supabaseClient =
          supabaseClient ?? getIt<AuthService>().getSupabaseClient();

  @override
  Future<AuthResponse> signIn(Map<String, dynamic> signInPayload) async {
    try {
      final response = await authClient.signInWithPassword(
        email: signInPayload['email'],
        password: signInPayload['password'],
      );
      return response;
    } catch (e) {
      logger.e('Error in signIn: $e');
      throw AuthException(e.toString());
    }
  }

  @override
  Future<User?> signUp(UserEntity userInfo) async {
    final res = await authClient.signUp(
      email: userInfo.email ?? '',
      password: userInfo.password ?? '',
      data: {'full_name': userInfo.name},
    );
    return res.user;
  }

  @override
  Future<void> forgetPassword(String email) async {
    await authClient.resetPasswordForEmail(email);
  }

  @override
  Future<void> resetPass(Map<String, dynamic> payload) async {
    try {
      final res = await authClient.verifyOTP(
        type: OtpType.email,
        email: payload['email'],
        token: payload['otp'],
      );
      if (res.user != null) {
        await authClient.updateUser(
          UserAttributes(password: payload['password']),
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> addUser(UserEntity userInfo) async {
    try {
      final existingUser =
          await supabaseClient
              .from('users')
              .select()
              .eq('id', userInfo.id.toString())
              .maybeSingle();

      if (existingUser == null) {
        await supabaseClient.from('users').insert({
          'id': userInfo.id,
          'email': userInfo.email,
          'name': userInfo.name,
          'profile_picture': userInfo.profilePictureUrl,
        });
      }
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getUser(String id) async {
    try {
      final response =
          await supabaseClient.from('users').select().eq('id', id).single();
      return response;
    } catch (e) {
      throw Exception('Error retrieving user data: ${e.toString()}');
    }
  }

  @override
  Future<AuthResponse> signInWithGoogle() async {
    throw UnimplementedError();
    // try {
    //   final GoogleSignIn googleSignIn = GoogleSignIn(
    //     scopes: ['email', 'profile'],
    //     serverClientId:
    //         '688864880472-65bh2k76mqijcjl0jh4d9snsgmoakf9a.apps.googleusercontent.com',
    //   );

    //   final googleUser = await googleSignIn.signIn();
    //   if (googleUser == null) throw const AuthException('Sign in cancelled');

    //   final googleAuth = await googleUser.authentication;
    //   if (googleAuth.accessToken == null || googleAuth.idToken == null) {
    //     throw const AuthException('Missing Google auth tokens');
    //   }

    //   final response = await supabaseClient.auth.signInWithIdToken(
    //     provider: OAuthProvider.google,
    //     idToken: googleAuth.idToken!,
    //     accessToken: googleAuth.accessToken!,
    //   );

    //   if (response.user == null) {
    //     throw const AuthException('Google sign-in failed');
    //   }

    //   return response;
    // } catch (e) {
    //   throw AuthException(e.toString());
    // }
  }
}
