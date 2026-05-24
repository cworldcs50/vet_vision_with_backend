import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../../../core/constants/caching_keys_constants.dart';
// import '../../../../core/services/app_service.dart';
import '../data/user_chat_repository.dart';
import '../model/chat_message.dart';

class UserChatController extends GetxController {
  final UserChatRepository _repo = UserChatRepository();

  final messages = <ChatMessage>[].obs;
  final isTyping = false.obs;
  final textController = TextEditingController();
  final scrollController = ScrollController();

  String? _threadId;
  bool _isStreaming = false;

  @override
  void onInit() {
    super.onInit();
    // Send a welcome message from AI
    _addWelcome();
  }

  void _addWelcome() {
    messages.add(
      ChatMessage.ai(
        'مرحباً! أنا **فيتو** 🐾، مساعدك الذكي للحيوانات الأليفة.\n\n'
        'يمكنني مساعدتك في:\n'
        '- أسئلة صحة حيوانك الأليف\n'
        '- نصائح التغذية والرعاية\n'
        '- تفسير نتائج التشخيص\n\n'
        'كيف يمكنني مساعدتك اليوم؟',
      ),
    );
  }

  // String get _userName =>
  //     Get.find<AppServices>().appSharedPrefs.getString(CachingKeysConstants.kUserFullName) ??
  //     'User';

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _isStreaming) return;

    textController.clear();
    _isStreaming = true;

    // Add user bubble
    messages.add(ChatMessage.user(trimmed));
    _scrollToBottom();

    // Add empty AI bubble to start streaming into
    final aiMsg = ChatMessage.ai('');
    messages.add(aiMsg);
    isTyping.value = true;
    _scrollToBottom();

    try {
      final stream = _repo.streamChat(
        message: trimmed,
        threadId: _threadId,
        onDone: (tid) {
          _threadId = tid;
        },
        onError: (err) {
          aiMsg.text = '⚠️ خطأ: $err';
          messages.refresh();
        },
      );

      await for (final token in stream) {
        aiMsg.text += token;
        messages.refresh();
        _scrollToBottom();
      }
    } catch (e) {
      aiMsg.text = '⚠️ حدث خطأ في الاتصال. يرجى المحاولة مرة أخرى.';
      messages.refresh();
    } finally {
      isTyping.value = false;
      _isStreaming = false;
      _scrollToBottom();
    }
  }

  void resetChat() {
    _threadId = null;
    _isStreaming = false;
    isTyping.value = false;
    textController.clear();
    messages.clear();
    _addWelcome();
  }

  /// Used to pre-fill a message (e.g. from CV scan result)
  void preFillMessage(String text) {
    textController.text = text;
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
