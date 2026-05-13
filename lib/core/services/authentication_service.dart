import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../features/users/auth/data/datasource/remote/register_user_with_email_and_password.dart';
import '../../features/users/auth/data/datasource/remote/sign_in_with_email_and_password.dart';
import '../../features/users/auth/data/datasource/remote/sign_in_with_facebook.dart';
import '../../features/users/auth/data/datasource/remote/sign_in_with_google.dart';
import '../../features/users/auth/data/datasource/remote/forget_password_data.dart';
import '../../features/users/auth/data/datasource/remote/reset_password_data.dart';
import '../../features/users/auth/data/datasource/remote/verification_code_data.dart';
import 'app_service.dart';

class AuthenticationService {
  static final AuthenticationService _instance = AuthenticationService._();
  AuthenticationService._();
  factory AuthenticationService() => _instance;

  final _crud = Get.find<AppServices>().crud;
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
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      return await SignInWithGoogle(crud: _crud)(
        provider: 'google',
        email: googleUser.email,
        providerId: googleUser.id,
        avatar: googleUser.photoUrl,
        name: googleUser.displayName ?? 'Google User',
      );
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

        return await SignInWithFacebook(crud: _crud)(
          provider: 'facebook',
          providerId: userData['id'],
          name: userData['name'] ?? 'Facebook User',
          avatar: userData['picture']?['data']?['url'],
          email: userData['email'] ?? '${userData['id']}@facebook.com',
        );
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
    return await RegisterUserWithEmailAndPassword(crud: _crud)(
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
    return await SignInWithEmailAndPassword(crud: _crud)(
      email: email,
      password: password,
    );
  }

  Future<dynamic> forgetPassword(String email) async {
    return await ForgetPasswordData(crud: _crud)(email: email);
  }

  Future<dynamic> verifyCode(String email, String code) async {
    return await VerificationCodeData(api: _crud).verifyEmail(email, code);
  }

  Future<dynamic> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    return await ResetPasswordData(crud: _crud)(
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
