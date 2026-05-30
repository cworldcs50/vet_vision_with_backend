import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import '../../../../core/classes/adaptive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../controller/user_chat_controller.dart';
import '../model/chat_message.dart';

class UserChatView extends StatelessWidget {
  const UserChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserChatController(), permanent: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF5FFFE),
      appBar: _buildAppBar(controller, context),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(controller, context)),
          _buildInputBar(controller, context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(UserChatController controller, BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Text(
              '🐾',
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'فيتو',
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 17,
                  ),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Pet AI Assistant',
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 11,
                  ),
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          tooltip: 'New Chat',
          onPressed: () {
            Get.dialog(
              AlertDialog(
                title: const Text('New Chat'),
                content: const Text('Start a fresh conversation?'),
                actions: [
                  TextButton(onPressed: Get.back, child: const Text('Cancel')),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () {
                      Get.back();
                      controller.resetChat();
                    },
                    child: const Text(
                      'Start New',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
        ),
      ],
    );
  }

  Widget _buildMessageList(
    UserChatController controller,
    BuildContext context,
  ) {
    return Obx(() {
      final msgs = controller.messages;
      return ListView.builder(
        controller: controller.scrollController,
        padding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 16,
          ),
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        ),
        itemCount: msgs.length + (controller.isTyping.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == msgs.length) {
            return const _TypingIndicator();
          }
          final msg = msgs[index];
          return msg.role == MessageRole.user
              ? _UserBubble(message: msg)
              : _AiBubble(message: msg);
        },
      );
    });
  }

  Widget _buildInputBar(UserChatController controller, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        right: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
        top: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        bottom:
            MediaQuery.of(context).padding.bottom +
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 10,
            ),
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Obx(() {
        final isTyping = controller.isTyping.value;
        return Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5FFFE),
                  borderRadius: BorderRadius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
                  ),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: TextField(
                  controller: controller.textController,
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: controller.sendMessage,
                  decoration: InputDecoration(
                    hintText: 'اسأل عن حيوانك الأليف...',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 14,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 18,
                      ),
                      vertical: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: isTyping
                  ? null
                  : () =>
                        controller.sendMessage(controller.textController.text),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 48,
                ),
                height: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 48,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isTyping ? Colors.grey.shade300 : AppColors.primary,
                  boxShadow: isTyping
                      ? []
                      : [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 8,
                            ),
                            offset: const Offset(0, 3),
                          ),
                        ],
                ),
                child: Icon(
                  isTyping ? Icons.hourglass_empty_rounded : Icons.send_rounded,
                  color: Colors.white,
                  size: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

// ── User Bubble ───────────────────────────────────────────────────────────────
class _UserBubble extends StatelessWidget {
  final ChatMessage message;
  const _UserBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
                vertical: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
                  ),
                  topRight: Radius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
                  ),
                  bottomLeft: Radius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
                  ),
                  bottomRight: Radius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 8,
                    ),
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14.5,
                  ),
                  height: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primaryLight,
            child: Icon(
              Icons.person,
              color: AppColors.primary,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}

// ── AI Bubble ─────────────────────────────────────────────────────────────────
class _AiBubble extends StatelessWidget {
  final ChatMessage message;
  const _AiBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32),
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 6,
                  ),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '🐾',
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
                vertical: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 12,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
                  ),
                  topRight: Radius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
                  ),
                  bottomLeft: Radius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
                  ),
                  bottomRight: Radius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 8,
                    ),
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.1),
                ),
              ),
              child: message.text.isEmpty
                  ? SizedBox(
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 20,
                      ),
                      height: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 20,
                      ),
                      child: CircularProgressIndicator(
                        strokeWidth: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 2,
                        ),
                        color: AppColors.primary,
                      ),
                    )
                  : MarkdownBody(
                      data: message.text,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 14.5,
                          ),
                          color: Color(0xFF1A1C1E),
                          height: 1.6,
                        ),
                        strong: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        listBullet: const TextStyle(color: AppColors.primary),
                        code: const TextStyle(
                          backgroundColor: Color(0xFFE0F2F1),
                          color: AppColors.primaryDark,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Typing Indicator ──────────────────────────────────────────────────────────
class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
      ),
      child: Row(
        children: [
          Container(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32),
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '🐾',
                style: TextStyle(
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 16,
              ),
              vertical: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 14,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
                ),
                topRight: Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
                ),
                bottomLeft: Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
                ),
                bottomRight: Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 8,
                  ),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                return AnimatedBuilder(
                  animation: _animController,
                  builder: (_, _) {
                    final delay = i * 0.3;
                    final value = ((_animController.value + delay) % 1.0);
                    final size = 6.0 + (value * 4);
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 3,
                        ),
                      ),
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(
                          alpha: 0.5 + value * 0.5,
                        ),
                        shape: BoxShape.circle,
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
