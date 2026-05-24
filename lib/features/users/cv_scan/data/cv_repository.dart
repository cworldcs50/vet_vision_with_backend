import 'dart:io';
import 'package:dio/dio.dart';

const String _cvBaseUrl = 'https://zeyadahmeedmostafa-vetvision-cv-api.hf.space';

class CvRepository {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: _cvBaseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
  ));

  Future<Map<String, dynamic>> predictCattle(File image) =>
      _predict('/predict/cattle', image);

  Future<Map<String, dynamic>> predictCat(File image) =>
      _predict('/predict/cat', image);

  Future<Map<String, dynamic>> predictChicken(File image) =>
      _predict('/predict/chicken', image);

  Future<Map<String, dynamic>> _predict(String path, File image) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        image.path,
        filename: 'scan.jpg',
      ),
    });
    final response = await _dio.post<Map<String, dynamic>>(path, data: formData);
    return response.data ?? {};
  }
}
