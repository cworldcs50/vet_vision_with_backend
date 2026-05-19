import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../../../../../../core/constants/link_api.dart';
import '../../../../../../core/services/app_service.dart';
import '../../../../../../core/constants/caching_keys_constants.dart';

class DoctorDashboardRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppLink.server,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  String get _token =>
      getx.Get.find<AppServices>().appSharedPrefs.getString(
        CachingKeysConstants.kUserToken,
      ) ??
      "";

  Future<Response> getAnalytics() async {
    return await _dio.get(
      '/doctor/analytics',
      options: Options(headers: {'Authorization': 'Bearer $_token'}),
    );
  }

  Future<Response> getTodayAppointments() async {
    return await _dio.get(
      '/doctor/appointments',
      queryParameters: {'date': 'today'},
      options: Options(headers: {'Authorization': 'Bearer $_token'}),
    );
  }

  Future<Response> getAllAppointments() async {
    return await _dio.get(
      '/doctor/appointments',
      options: Options(headers: {'Authorization': 'Bearer $_token'}),
    );
  }

  Future<Response> getProfile() async {
    return await _dio.get(
      '/doctor/profile',
      options: Options(headers: {'Authorization': 'Bearer $_token'}),
    );
  }

  Future<Response> updateAppointmentStatus(String id, String status) async {
    return await _dio.put(
      '/appointments/$id/status',
      data: {'status': status},
      options: Options(headers: {'Authorization': 'Bearer $_token'}),
    );
  }

  Future<Response> updateDoctorProfile(Map<String, dynamic> profileData, {String? imagePath}) async {
    final Map<String, dynamic> data = Map.from(profileData);
    if (imagePath != null) {
      data['image'] = await MultipartFile.fromFile(imagePath, filename: 'profile.jpg');
    }
    final formData = FormData.fromMap(data);
    return await _dio.post(
      '/doctor/update-profile',
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
    );
  }

  Future<Response> setAvailability(List<Map<String, dynamic>> availability) async {
    return await _dio.post(
      '/doctor/availability',
      data: {'availabilities': availability},
      options: Options(headers: {'Authorization': 'Bearer $_token'}),
    );
  }
}
