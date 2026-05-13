import '../../../../../../core/classes/crud.dart';
import '../../../../../../core/constants/link_api.dart';

class ResetPasswordData {
  const ResetPasswordData({required this.crud});

  final Crud crud;

  Future<dynamic> call({
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    final result = await crud.post(AppLink.resetPassword, {
      "email": email,
      "code": code,
      "password": password,
      "password_confirmation": passwordConfirmation,
    });

    return result;
  }
}
