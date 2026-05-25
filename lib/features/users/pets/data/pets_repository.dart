import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import '../../../../../core/constants/caching_keys_constants.dart';
import '../../../../../core/constants/link_api.dart';
import '../../../../../core/services/app_service.dart';
import '../../../../../features/doctors/portal/appointments/data/models/animal_model.dart';

class PetsRepository {
  final Dio _dio = Dio(
    BaseOptions(headers: {'Accept': 'application/json'}),
  );

  /// Always read the latest token so we never send a stale / empty Bearer.
  Options get _authOptions {
    final token =
        Get.find<AppServices>().appSharedPrefs.getString(
          CachingKeysConstants.kUserToken,
        ) ??
        '';
    log('PetsRepository token: $token');
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  // ── Fetch all pets for the authenticated user ─────────────────────────────
  Future<List<AnimalModel>> fetchMyPets() async {
    final res = await _dio.get(AppLink.myAnimals, options: _authOptions);
    log('fetchMyPets response [${res.statusCode}]: ${res.data}');
    final raw = res.data['data'];
    final list = raw is List
        ? raw
        : (raw is Map && raw['data'] is List ? raw['data'] as List : []);
    return list
        .map((e) => AnimalModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Create a new pet ──────────────────────────────────────────────────────
  Future<Response> createPet({
    required Map<String, dynamic> fields,
    File? image,
  }) async {
    if (image != null) {
      final data = Map<String, dynamic>.from(fields);
      data['image'] = await MultipartFile.fromFile(
        image.path,
        filename: 'pet.jpg',
        contentType: DioMediaType('image', 'jpeg'),
      );
      return _dio.post(AppLink.animals,
          data: FormData.fromMap(data), options: _authOptions);
    }
    return _dio.post(AppLink.animals, data: fields, options: _authOptions);
  }

  // ── Update an existing pet ────────────────────────────────────────────────
  Future<Response> updatePet({
    required String id,
    required Map<String, dynamic> fields,
    File? image,
  }) async {
    if (image != null) {
      final data = Map<String, dynamic>.from(fields);
      data['image'] = await MultipartFile.fromFile(
        image.path,
        filename: 'pet.jpg',
        contentType: DioMediaType('image', 'jpeg'),
      );
      return _dio.post(AppLink.animalUpdate(id),
          data: FormData.fromMap(data), options: _authOptions);
    }
    return _dio.post(AppLink.animalUpdate(id),
        data: fields, options: _authOptions);
  }

  // ── Delete a pet ──────────────────────────────────────────────────────────
  Future<void> deletePet(String id) async {
    await _dio.delete(AppLink.animal(id), options: _authOptions);
  }
}
