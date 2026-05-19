import '../../../../../../core/classes/crud.dart';
import '../../../../../../core/constants/link_api.dart';

class SignInWithGoogle {
  const SignInWithGoogle({required this.crud});

  final Crud crud;

  Future<dynamic> call({
    required String name,
    required String email,
    required String provider,
    required String providerId,
    String? avatar,
  }) async {
    final result = await crud.post(AppLink.socialLogin, {
      "name": name,
      "email": email,
      "provider": provider,
      "avatar": avatar ?? "",
      "provider_id": providerId,
    });

    return result;
  }
}
