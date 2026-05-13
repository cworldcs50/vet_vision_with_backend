import '../../../../../../core/classes/crud.dart';
import '../../../../../../core/constants/link_api.dart';

class VerificationCodeData {
  const VerificationCodeData({required this.api});

  final Crud api;

  Future<dynamic> verifyEmail(String email, String code) async {
    final result = await api.post(AppLink.verifyEmail, {
      "email": email,
      "code": code,
    });

    return result;
  }
}
