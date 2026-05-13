import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import '../functions/is_online.dart';
import 'package:http/http.dart' as http;
import '../network/request_status.dart';
import '../constants/caching_keys_constants.dart';
import '../services/app_service.dart';
import 'failure_model.dart';

class Crud {
  // ─── helpers ────────────────────────────────────────────────────────────────

  /// Reads the cached Sanctum token from SharedPreferences and returns the
  /// standard headers every request needs.
  Map<String, String> _buildHeaders({bool withAuth = true}) {
    final headers = <String, String>{'Accept': 'application/json'};
    if (withAuth) {
      try {
        final prefs = Get.find<AppServices>().appSharedPrefs;
        final token = prefs.getString(CachingKeysConstants.kUserToken) ?? '';
        if (token.isNotEmpty) {
          headers['Authorization'] = 'Bearer $token';
        }
      } catch (_) {
        // AppServices not ready yet (e.g. during init) — skip token
      }
    }
    return headers;
  }

  // ─── GET ────────────────────────────────────────────────────────────────────

  Future<Either<FailureModel, Map>> get(String url) async {
    try {
      if (await isOnline()) {
        final response = await http.get(
          Uri.parse(url),
          headers: _buildHeaders(),
        );

        log('[Crud GET] $url → ${response.statusCode}');
        final parsed = _tryParseJsonMap(response.body);

        if (response.statusCode >= 200 && response.statusCode < 300) {
          return Right(parsed ?? const <String, dynamic>{});
        }

        log('[Crud GET Error] $url → ${response.statusCode}: ${response.body}');
        return Left(
          FailureModel(
            message: parsed?["message"]?.toString() ?? "Server error (${response.statusCode})",
            status: RequestStatus.serverFailure,
          ),
        );
      } else {
        return const Left(
          FailureModel(
            message: "No internet connection",
            status: RequestStatus.offlineFailure,
          ),
        );
      }
    } catch (e) {
      log('[Crud GET Exception] $e');
      return Left(
        FailureModel(
          message: "Unexpected error: $e",
          status: RequestStatus.failure,
        ),
      );
    }
  }

  Map<String, dynamic>? _tryParseJsonMap(String body) {
    if (body.isEmpty) return null;
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {}
    return null;
  }

  /// Transport succeeded (HTTP response received). Use [result['status']]
  /// from ApiResponseTrait for business success vs validation/auth errors.
  void _attachTransportStatus(Map responseBody, int statusCode) {
    responseBody['request_status'] = RequestStatus.success;
    responseBody['_http_status'] = statusCode;
  }

  // ─── POST ───────────────────────────────────────────────────────────────────

  Future<Map> post(
    String url,
    Map dataForm, [
    Map<String, String>? extraHeaders,
  ]) async {
    try {
      if (await isOnline()) {
        final headers = _buildHeaders()..addAll(extraHeaders ?? {});

        final response = await http.post(
          Uri.parse(url),
          body: dataForm.map((k, v) => MapEntry(k.toString(), v.toString())),
          headers: headers,
        );

        log('[Crud POST] $url → ${response.statusCode}: ${response.body}');

        final parsed = _tryParseJsonMap(response.body);
        if (parsed != null) {
          _attachTransportStatus(parsed, response.statusCode);
          return parsed;
        }

        return {
          'request_status': RequestStatus.serverFailure,
          'status': false,
          'message': 'Invalid server response',
          'data': null,
          '_http_status': response.statusCode,
        };
      } else {
        return {'request_status': RequestStatus.offlineFailure};
      }
    } catch (e) {
      log('[Crud POST Exception] $e');
      return {'request_status': RequestStatus.failure};
    }
  }

  // ─── PUT ────────────────────────────────────────────────────────────────────

  Future<Map> put(String url, Map dataForm) async {
    try {
      if (await isOnline()) {
        final response = await http.put(
          Uri.parse(url),
          body: dataForm.map((k, v) => MapEntry(k.toString(), v.toString())),
          headers: _buildHeaders(),
        );

        log('[Crud PUT] $url → ${response.statusCode}: ${response.body}');

        final parsed = _tryParseJsonMap(response.body);
        if (parsed != null) {
          _attachTransportStatus(parsed, response.statusCode);
          return parsed;
        }

        return {
          'request_status': RequestStatus.serverFailure,
          'status': false,
          'message': 'Invalid server response',
          'data': null,
          '_http_status': response.statusCode,
        };
      } else {
        return {'request_status': RequestStatus.offlineFailure};
      }
    } catch (e) {
      log('[Crud PUT Exception] $e');
      return {'request_status': RequestStatus.failure};
    }
  }

  // ─── DELETE ─────────────────────────────────────────────────────────────────

  Future<Map> delete(String url) async {
    try {
      if (await isOnline()) {
        final response = await http.delete(
          Uri.parse(url),
          headers: _buildHeaders(),
        );

        log('[Crud DELETE] $url → ${response.statusCode}: ${response.body}');

        final parsed = _tryParseJsonMap(response.body);
        if (parsed != null) {
          _attachTransportStatus(parsed, response.statusCode);
          return parsed;
        }

        return {
          'request_status': RequestStatus.serverFailure,
          'status': false,
          'message': 'Invalid server response',
          'data': null,
          '_http_status': response.statusCode,
        };
      } else {
        return {'request_status': RequestStatus.offlineFailure};
      }
    } catch (e) {
      log('[Crud DELETE Exception] $e');
      return {'request_status': RequestStatus.failure};
    }
  }

  // ─── MULTIPART POST (for image uploads) ─────────────────────────────────────

  /// Sends a multipart/form-data POST.
  /// [fields]    — regular text fields
  /// [filePath]  — absolute path to the local file (nullable)
  /// [fileField] — the form field name the server expects (e.g. "image", "avatar")
  Future<Map> postMultipart(
    String url, {
    Map<String, String> fields = const {},
    String? filePath,
    String fileField = 'image',
    Map<String, String> additionalFiles = const {},
  }) async {
    try {
      if (await isOnline()) {
        final request = http.MultipartRequest('POST', Uri.parse(url));

        // Auth + accept headers
        request.headers.addAll(_buildHeaders());

        // Text fields
        request.fields.addAll(fields);

        // File
        if (filePath != null && filePath.isNotEmpty) {
          request.files.add(
            await http.MultipartFile.fromPath(fileField, filePath),
          );
        }

        for (final e in additionalFiles.entries) {
          if (e.value.isNotEmpty) {
            request.files.add(
              await http.MultipartFile.fromPath(e.key, e.value),
            );
          }
        }

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        log('[Crud MULTIPART] $url → ${response.statusCode}: ${response.body}');

        final parsed = _tryParseJsonMap(response.body);
        if (parsed != null) {
          _attachTransportStatus(parsed, response.statusCode);
          return parsed;
        }

        return {
          'request_status': RequestStatus.serverFailure,
          'status': false,
          'message': 'Invalid server response',
          'data': null,
          '_http_status': response.statusCode,
        };
      } else {
        return {'request_status': RequestStatus.offlineFailure};
      }
    } catch (e) {
      log('[Crud MULTIPART Exception] $e');
      return {'request_status': RequestStatus.failure};
    }
  }
}
