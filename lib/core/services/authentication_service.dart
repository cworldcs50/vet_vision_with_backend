import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../features/users/auth/data/repository/auth_repository.dart';
import 'app_service.dart';
import 'service_locator.dart';

class AuthenticationService {
  static final AuthenticationService _instance = AuthenticationService._();
  AuthenticationService._();
  factory AuthenticationService() => _instance;

  final IAuthRepository _repository = sl<IAuthRepository>();
  static bool _isGoogleInitialized = false;
  static const String _googleServerClientId =
      "338932894986-j6nqsj1mes7sgdju77p833il80nclgj1.apps.googleusercontent.com";

  Future<void> _ensureGoogleSignInInitialized() async {
    if (_isGoogleInitialized) return;
    if (_googleServerClientId.isEmpty) {
      throw Exception(
        "Missing GOOGLE_SERVER_CLIENT_ID. Run with "
        "--dart-define=GOOGLE_SERVER_CLIENT_ID=<web-client-id>",
      );
    }

    await GoogleSignIn.instance.initialize(
      serverClientId: _googleServerClientId,
    );
    _isGoogleInitialized = true;
  }

  Future<dynamic> authWithGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();
      await GoogleSignIn.instance
          .authenticate();
      return {
        'status': false,
        'message':
            'Social auth requires backend callback support and is not available in this mobile flow yet.',
      };
    } catch (e) {
      log("Google Sign In Error: $e");
      return {'status': false, 'message': 'Google Sign-In failed: $e'};
    }
  }

  Future<dynamic> authWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        return {
          'status': false,
          'message':
              'Social auth requires backend callback support and is not available in this mobile flow yet.',
          'data': {'provider_id': userData['id']},
        };
      } else if (result.status == LoginStatus.cancelled) {
        return {
          'status': false,
          'message': 'Facebook Sign-In canceled by user',
        };
      } else {
        return {
          'status': false,
          'message': 'Facebook Sign-In failed: ${result.message}',
        };
      }
    } catch (e) {
      log("Facebook Sign In Error: $e");
      return {'status': false, 'message': 'Facebook Sign-In failed: $e'};
    }
  }

  Future<dynamic> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    return await _repository.signUp(
      name: name,
      email: email,
      password: password,
      role: role,
    );
  }

  Future<dynamic> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _repository.signIn(
      email: email,
      password: password,
    );
  }

  Future<dynamic> forgetPassword(String email) async {
    return await _repository.forgetPassword(email: email);
  }

  Future<dynamic> verifyCode(String email, String code) async {
    return await _repository.verifyEmail(email: email, code: code);
  }

  Future<dynamic> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await _repository.resetPassword(
      email: email,
      code: code,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }

  Future<void> logout() async {
    final sharedPrefs = Get.find<AppServices>().appSharedPrefs;
    await sharedPrefs.clear();

    try {
      await GoogleSignIn.instance.signOut();
      await FacebookAuth.instance.logOut();
    } catch (e) {
      log("Error logging out of social providers: $e");
    }
  }
}
