import '../../../../../../core/classes/crud.dart';
import '../../../../../../core/constants/link_api.dart';

abstract class IAuthRemoteDataSource {
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> signUp({
    required String name,
    required String role,
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String code,
  });

  Future<Map<String, dynamic>> forgetPassword({required String email});

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  });
}

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  const AuthRemoteDataSource({required this.crud});

  final Crud crud;

  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final result = await crud.post(AppLink.login, {
      'email': email,
      'password': password,
    });
    return Map<String, dynamic>.from(result);
  }

  @override
  Future<Map<String, dynamic>> signUp({
    required String name,
    required String role,
    required String email,
    required String password,
  }) async {
    final result = await crud.post(AppLink.signUp, {
      'name': name,
      'role': role,
      'email': email,
      'password': password,
    });
    return Map<String, dynamic>.from(result);
  }

  @override
  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String code,
  }) async {
    final result = await crud.post(AppLink.verifyEmail, {
      'email': email,
      'code': code,
    });
    return Map<String, dynamic>.from(result);
  }

  @override
  Future<Map<String, dynamic>> forgetPassword({required String email}) async {
    final result = await crud.post(AppLink.forgetPassword, {'email': email});
    return Map<String, dynamic>.from(result);
  }

  @override
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    final result = await crud.post(AppLink.resetPassword, {
      'code': code,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });
    return Map<String, dynamic>.from(result);
  }
}
