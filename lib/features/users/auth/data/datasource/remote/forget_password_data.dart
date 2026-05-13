import '../../../../../../core/classes/crud.dart';
import '../../../../../../core/constants/link_api.dart';

class ForgetPasswordData {
  const ForgetPasswordData({required this.crud});

  final Crud crud;

  Future<dynamic> call({required String email}) async {
    final result = await crud.post(AppLink.forgetPassword, {"email": email});

    return result;
  }
}
