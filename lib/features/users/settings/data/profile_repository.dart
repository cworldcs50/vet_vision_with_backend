import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../core/constants/link_api.dart';
import '../../../../core/services/app_service.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class ProfileRepository {
  late final Dio _dio;

  ProfileRepository() {
    final token =
        Get.find<AppServices>().appSharedPrefs.getString(
              'userToken', // CachingKeysConstants.kUserToken
            ) ?? '';

    _dio = Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Response> updateProfile({
    required Map<String, dynamic> fields,
    File? avatar,
  }) async {
    if (avatar != null) {
      fields['avatar'] = await MultipartFile.fromFile(
        avatar.path,
        filename: 'avatar.jpg',
      );
      final formData = FormData.fromMap(fields);
      return await _dio.post(AppLink.updateProfile, data: formData);
    } else {
      return await _dio.post(AppLink.updateProfile, data: fields);
    }
  }
}
