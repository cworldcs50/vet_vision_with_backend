import '../../../../../../core/classes/crud.dart';
import '../../../../../../core/constants/link_api.dart';

class SignInWithGoogle {
  const SignInWithGoogle({required this.crud});

  final Crud crud;

  Future<dynamic> call({
    required String provider,
    required String providerId,
    required String email,
    required String name,
    String? avatar,
  }) async {
    final result = await crud.post(AppLink.socialLogin, {
      "provider": provider,
      "provider_id": providerId,
      "email": email,
      "name": name,
      "avatar": ?avatar,
    });

    return result;
  }
}
