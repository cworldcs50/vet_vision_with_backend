import '../../../../../../core/classes/crud.dart';
import '../../../../../../core/constants/link_api.dart';

class SignInWithEmailAndPassword {
  const SignInWithEmailAndPassword({required this.crud});

  final Crud crud;

  Future<dynamic> call({
    required String email,
    required String password,
  }) async {
    final result = await crud.post(AppLink.login, {
      "email": email,
      "password": password,
    });

    return result;
  }
}
