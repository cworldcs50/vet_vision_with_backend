import '../../../../../../core/classes/crud.dart';
import '../../../../../../core/constants/link_api.dart';

class RegisterUserWithEmailAndPassword {
  RegisterUserWithEmailAndPassword({required this.crud});
  final Crud crud;

  Future<dynamic> call({
    required String name,
    required String role,
    required String email,
    required String password,
  }) async {
    final result = await crud.post(AppLink.signUp, {
      "role": role,
      "name": name,
      "email": email,
      "password": password,
    });

    return result;
  }
}
