import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../../../../../../core/constants/link_api.dart';
import '../../../../../../core/services/app_service.dart';
import '../../../../../../core/constants/caching_keys_constants.dart';

class DoctorDashboardRepository {
  late final Dio _dio;

  DoctorDashboardRepository() {
    _dio = Dio(
      BaseOptions(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Fix C — 401 interceptor: force logout on token expiry instead of crashing
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            // Lazy import to avoid circular dependency at construction time
            try {
              getx.Get.find<AppServices>().appSharedPrefs.remove(
                CachingKeysConstants.kUserToken,
              );
            } catch (_) {}
            // Navigate to role selection if the controller is registered
            if (getx.Get.isRegistered(tag: 'DoctorPortalController') ||
                getx.Get.isRegistered()) {
              try {
                getx.Get.offAllNamed('/roleSelection');
              } catch (_) {}
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  String get _token =>
      getx.Get.find<AppServices>().appSharedPrefs.getString(
        CachingKeysConstants.kUserToken,
      ) ??
      "";

  Options get _authOptions =>
      Options(headers: {'Authorization': 'Bearer $_token'});

  // ── Analytics ─────────────────────────────────────────────────────────────

  Future<Response> getAnalytics() async {
    return await _dio.get(AppLink.doctorAnalytics, options: _authOptions);
  }

  // ── Appointments ──────────────────────────────────────────────────────────

  Future<Response> getTodayAppointments() async {
    return await _dio.get(
      AppLink.doctorAppointments,
      queryParameters: {'date': 'today'},
      options: _authOptions,
    );
  }

  Future<Response> getAllAppointments() async {
    return await _dio.get(AppLink.doctorAppointments, options: _authOptions);
  }

  /// Fix D — Safe list extraction that handles both paginated and flat shapes.
  /// Call from the controller instead of doing raw map access there.
  static List<Map<String, dynamic>> extractAppointmentList(
    Map<String, dynamic> responseData,
  ) {
    final data = responseData['data'];
    if (data is Map && data.containsKey('data')) {
      final inner = data['data'];
      if (inner is List) return inner.cast<Map<String, dynamic>>();
    }
    if (data is List) return data.cast<Map<String, dynamic>>();
    return [];
  }

  Future<Response> updateAppointmentStatus(String id, String status) async {
    return await _dio.put(
      AppLink.updateAppointmentStatus(id),
      data: {'status': status},
      options: _authOptions,
    );
  }

  // ── Profile ───────────────────────────────────────────────────────────────

  Future<Response> getProfile() async {
    return await _dio.get(
      AppLink.doctorProfile, // Fix A — use constant, not raw string
      options: _authOptions,
    );
  }

  /// Fix B — Laravel multipart PUT method spoofing via `_method: PUT`.
  Future<Response> updateDoctorProfile(
    Map<String, dynamic> profileData, {
    String? imagePath,
  }) async {
    final Map<String, dynamic> data = Map.from(profileData);
    
    // If no image, send as JSON to preserve strict data types (int, double)
    if (imagePath == null) {
      return await _dio.post(
        AppLink.doctorUpdateProfile,
        data: data,
        options: _authOptions,
      );
    }

    // If image exists, use FormData (converts all types to strings)
    data['image'] = await MultipartFile.fromFile(
      imagePath,
      filename: 'profile.jpg',
      contentType: DioMediaType('image', 'jpeg'),
    );
    final formData = FormData.fromMap(data);
    
    return await _dio.post(
      AppLink.doctorUpdateProfile,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $_token',
        },
      ),
    );
  }

  // ── Availability ──────────────────────────────────────────────────────────

  Future<Response> setAvailability(
    List<Map<String, dynamic>> availability,
  ) async {
    return await _dio.post(
      AppLink.setAvailability,
      data: {'availabilities': availability},
      options: _authOptions,
    );
  }
}
