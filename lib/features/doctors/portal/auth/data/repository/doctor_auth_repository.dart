import 'package:dio/dio.dart';
import '../../../../../../core/constants/link_api.dart';

class DoctorAuthRepository {
  final Dio _dio = Dio();

  DoctorAuthRepository() {
    _dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Future<Response> registerStep1(Map<String, dynamic> userData) async {
    return await _dio.post(
      AppLink.signUp,
      data: userData,
    );
  }

  Future<Response> completeDoctorProfile({
    required Map<String, dynamic> profileData,
    String? imagePath,
    required String token,
  }) async {
    FormData formData = FormData.fromMap(profileData);
    
    if (imagePath != null && imagePath.isNotEmpty) {
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(imagePath, filename: imagePath.split('/').last),
      ));
    }

    return await _dio.post(
      AppLink.completeProfile,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );
  }

  Future<Response> verifyEmail(String email, String code) async {
    return await _dio.post(
      AppLink.verifyEmail,
      data: {
        'email': email,
        'code': code,
      },
    );
  }

  Future<Response> resendVerificationCode(String email) async {
    return await _dio.post(
      AppLink.forgetPassword, // Usually forgetPassword is used to resend code in this project
      data: {'email': email},
    );
  }
}
