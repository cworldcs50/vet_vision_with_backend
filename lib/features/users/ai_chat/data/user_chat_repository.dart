import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/constants/caching_keys_constants.dart';
import '../../../../core/services/app_service.dart';
import 'package:get/get.dart' hide Response;

const String _agentBaseUrl = 'https://zeyadddd-vetvision-agents.hf.space';

class UserChatRepository {
  late final Dio _dio;

  UserChatRepository() {
    final token =
        Get.find<AppServices>().appSharedPrefs.getString(
          CachingKeysConstants.kUserToken,
        ) ??
        '';

    _dio = Dio(
      BaseOptions(
        baseUrl: _agentBaseUrl,
        headers: {
          'Accept': 'text/event-stream',
          'Content-Type': 'application/json',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
        responseType: ResponseType.stream,
        receiveTimeout: const Duration(minutes: 3),
        connectTimeout: const Duration(seconds: 30),
      ),
    );
  }

  /// Streams the user agent response token by token.
  /// Yields each text chunk as it arrives.
  /// Returns the thread_id when done via the onDone callback.
  Stream<String> streamChat({
    required String message,
    String? threadId,
    bool reset = false,
    void Function(String threadId)? onDone,
    void Function(String error)? onError,
  }) {
    final controller = StreamController<String>();

    _streamRequest(
      path: '/chat',
      body: {'message': message, 'thread_id': ?threadId, 'reset': reset},
      controller: controller,
      onDone: onDone,
      onError: onError,
    );

    return controller.stream;
  }

  void _streamRequest({
    required String path,
    required Map<String, dynamic> body,
    required StreamController<String> controller,
    void Function(String threadId)? onDone,
    void Function(String error)? onError,
  }) async {
    try {
      final response = await _dio.post<ResponseBody>(
        path,
        data: jsonEncode(body),
      );
      final stream = response.data!.stream;

      final buffer = StringBuffer();

      await for (final chunk in stream) {
        final raw = utf8.decode(chunk);
        buffer.write(raw);

        // SSE events end with double newline
        final events = buffer.toString().split('\n\n');
        // Keep incomplete event in buffer
        buffer.clear();
        buffer.write(events.last);

        for (int i = 0; i < events.length - 1; i++) {
          final event = events[i];
          for (final line in event.split('\n')) {
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
                  onError?.call(json['content']?.toString() ?? 'Unknown error');
                }
              } catch (_) {
                // skip malformed
              }
            }
          }
        }
      }

      await controller.close();
    } on DioException catch (e) {
      controller.addError(e);
      await controller.close();
    }
  }
}
