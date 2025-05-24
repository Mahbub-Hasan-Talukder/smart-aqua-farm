import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    try {
      return await _signInWithGoogleNative();
    } catch (e) {
      logger.e('Error in signInWithGoogle: $e');
      throw AuthException(e.toString());
    }
  }

  Future<AuthResponse> _signInWithGoogleNative() async {
    final webClientId =
        dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? 'no-web-client-id-found';
    final iosClientId =
        dotenv.env['GOOGLE_IOS_CLIENT_ID'] ?? 'no-ios-client-id-found';

    final googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw const AuthException('Google sign-in cancelled');
    }

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      throw const AuthException('Missing Google authentication tokens');
    }

    return await authClient.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }
}
