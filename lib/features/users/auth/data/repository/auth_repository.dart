import '../datasource/remote/auth_remote_data_source.dart';

abstract class IAuthRepository {
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

class AuthRepository implements IAuthRepository {
  const AuthRepository({required this.remoteDataSource});

  final IAuthRemoteDataSource remoteDataSource;

  @override
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) => remoteDataSource.signIn(email: email, password: password);

  @override
  Future<Map<String, dynamic>> signUp({
    required String name,
    required String role,
    required String email,
    required String password,
  }) => remoteDataSource.signUp(
    name: name,
    role: role,
    email: email,
    password: password,
  );

  @override
  Future<Map<String, dynamic>> verifyEmail({
    required String email,
    required String code,
  }) => remoteDataSource.verifyEmail(email: email, code: code);

  @override
  Future<Map<String, dynamic>> forgetPassword({required String email}) =>
      remoteDataSource.forgetPassword(email: email);

  @override
  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  }) => remoteDataSource.resetPassword(
    email: email,
    code: code,
    password: password,
    passwordConfirmation: passwordConfirmation,
  );
}
