import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../../../../core/constants/caching_keys_constants.dart';
import '../../../../core/services/app_service.dart';
import 'package:get/get.dart' hide Response;

const String _agentBaseUrl = 'https://zeyadddd-vetvision-agents.hf.space';

class CopilotRepository {
  late final Dio _streamDio;
  late final Dio _jsonDio;

  CopilotRepository() {
    final token =
        Get.find<AppServices>().appSharedPrefs.getString(
              CachingKeysConstants.kUserToken,
            ) ??
            '';

    final headers = {
      'Content-Type': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Bearer $token',
    };

    _streamDio = Dio(BaseOptions(
      baseUrl: _agentBaseUrl,
      headers: {...headers, 'Accept': 'text/event-stream'},
      responseType: ResponseType.stream,
      receiveTimeout: const Duration(minutes: 3),
      connectTimeout: const Duration(seconds: 30),
    ));

    _jsonDio = Dio(BaseOptions(
      baseUrl: _agentBaseUrl,
      headers: {...headers, 'Accept': 'application/json'},
      receiveTimeout: const Duration(minutes: 2),
      connectTimeout: const Duration(seconds: 30),
    ));
  }

  /// SSE streaming chat for the Vet Copilot
  Stream<String> streamCopilot({
    required String message,
    void Function(String threadId)? onDone,
    void Function(String error)? onError,
  }) {
    final controller = StreamController<String>();

    _doStream(
      path: '/copilot/chat',
      body: {'message': message},
      controller: controller,
      onDone: onDone,
      onError: onError,
    );

    return controller.stream;
  }

  void _doStream({
    required String path,
    required Map<String, dynamic> body,
    required StreamController<String> controller,
    void Function(String)? onDone,
    void Function(String)? onError,
  }) async {
    try {
      final response =
          await _streamDio.post<ResponseBody>(path, data: jsonEncode(body));
      final buffer = StringBuffer();

      await for (final chunk in response.data!.stream) {
        final raw = utf8.decode(chunk);
        buffer.write(raw);

        final events = buffer.toString().split('\n\n');
        buffer.clear();
        buffer.write(events.last);

        for (int i = 0; i < events.length - 1; i++) {
          for (final line in events[i].split('\n')) {
            if (line.startsWith('data: ')) {
              final data = line.substring(6).trim();
              if (data.isEmpty || data == '[DONE]') continue;
              try {
                final json = jsonDecode(data) as Map<String, dynamic>;
                if (json['type'] == 'token') {
                  controller.add(json['content']?.toString() ?? '');
                } else if (json['type'] == 'done') {
                  onDone?.call(json['thread_id']?.toString() ?? '');
                } else if (json['type'] == 'error') {
                  onError?.call(json['content']?.toString() ?? 'Error');
                }
              } catch (_) {}
            }
          }
        }
      }
      await controller.close();
    } catch (e) {
      controller.addError(e);
      await controller.close();
    }
  }

  /// Generate a PDF report via the copilot
  Future<Map<String, dynamic>> generateReport({
    required String animalName,
    required String animalType,
    required String ownerName,
    required double weightKg,
    required String diagnosis,
    required String treatment,
    String doctorName = 'Vet Vision Doctor',
    String doctorNotes = '',
  }) async {
    final response = await _jsonDio.post<Map<String, dynamic>>(
      '/copilot/generate-report',
      data: {
        'animal_name': animalName,
        'animal_type': animalType,
        'owner_name': ownerName,
        'weight_kg': weightKg,
        'diagnosis': diagnosis,
        'treatment': treatment,
        'doctor_name': doctorName,
        'doctor_notes': doctorNotes,
      },
    );
    return response.data ?? {};
  }

  /// Download a PDF report as raw bytes
  Future<Uint8List> downloadReport(String filename) async {
    final response = await Dio(BaseOptions(
      baseUrl: _agentBaseUrl,
      responseType: ResponseType.bytes,
    )).get<Uint8List>('/copilot/reports/$filename');
    return response.data!;
  }

  /// Get patient history by animal ID
  Future<Map<String, dynamic>> getPatientHistory(String animalId) async {
    final response = await _jsonDio
        .get<Map<String, dynamic>>('/copilot/patient/$animalId');
    return response.data ?? {};
  }
}
