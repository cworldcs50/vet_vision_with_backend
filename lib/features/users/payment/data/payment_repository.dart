import 'package:dio/dio.dart';
import '../../../../core/constants/link_api.dart';
import '../../../../core/services/app_service.dart';
import 'package:get/get.dart' hide Response;

class PaymentRepository {
  late final Dio _dio;

  PaymentRepository() {
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

  Future<Response> payForAppointment(String appointmentId) async {
    return await _dio.post('${AppLink.server}/payments/$appointmentId/pay');
  }

  Future<Response> checkPaymentStatus(String appointmentId) async {
    return await _dio.get('${AppLink.server}/payments/$appointmentId/status');
  }
}
