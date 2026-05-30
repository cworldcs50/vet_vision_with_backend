import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import '../../../../core/classes/adaptive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../features/users/ai_chat/model/chat_message.dart';
import '../controller/copilot_controller.dart';

class CopilotChatView extends StatelessWidget {
  const CopilotChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CopilotController(), permanent: false);

    return Scaffold(
      backgroundColor: const Color(
        0xFFF0F4F8,
      ), // Slightly professional grayish blue
      appBar: _buildAppBar(context, controller),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(controller, context)),
          _buildInputBar(controller, context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, CopilotController controller) {
    return AppBar(
      backgroundColor: const Color(0xFF1E3A5F), // Professional Dark Blue
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
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.medical_services,
              color: Colors.white,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
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
                'Vet Copilot',
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
                'Clinical AI Assistant',
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
          icon: const Icon(Icons.picture_as_pdf_rounded),
          tooltip: 'Generate Report',
          onPressed: () => _showGenerateReportForm(context, controller),
        ),
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          tooltip: 'Reset Chat',
          onPressed: controller.resetChat,
        ),
      ],
    );
  }

  Widget _buildMessageList(CopilotController controller, BuildContext context) {
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
          if (msg.role == MessageRole.user) {
            return _UserBubble(message: msg);
          } else {
            if (msg.text.startsWith('__PDF__:')) {
              return _PdfBubble(
                filename: msg.text.substring(8),
                controller: controller,
              );
            }
            return _AiBubble(message: msg);
          }
        },
      );
    });
  }

  Widget _buildInputBar(CopilotController controller, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                  color: const Color(0xFFF0F4F8),
                  borderRadius: BorderRadius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
                  ),
                  border: Border.all(
                    color: const Color(0xFF1E3A5F).withValues(alpha: 0.2),
                  ),
                ),
                child: TextField(
                  controller: controller.textController,
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  onSubmitted: controller.sendMessage,
                  decoration: InputDecoration(
                    hintText: 'Ask Copilot about a case...',
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
            SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 10,
              ),
            ),
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
                  color: isTyping
                      ? Colors.grey.shade300
                      : const Color(0xFF1E3A5F),
                  boxShadow: isTyping
                      ? []
                      : [
                          BoxShadow(
                            color: const Color(
                              0xFF1E3A5F,
                            ).withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                ),
                child: Icon(
                  isTyping ? Icons.more_horiz : Icons.send_rounded,
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

  void _showGenerateReportForm(
    BuildContext context,
    CopilotController controller,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
            right: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
            top: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Generate PDF Report',
                      style: TextStyle(
                        fontSize: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 18,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                _buildTextField(controller.animalNameCtrl, 'Animal Name *'),
                _buildTextField(controller.animalTypeCtrl, 'Animal Type'),
                _buildTextField(controller.ownerNameCtrl, 'Owner Name'),
                _buildTextField(
                  controller.weightCtrl,
                  'Weight (Kg)',
                  isNumber: true,
                ),
                _buildTextField(
                  controller.diagnosisCtrl,
                  'Diagnosis *',
                  maxLines: 2,
                ),
                _buildTextField(
                  controller.treatmentCtrl,
                  'Treatment *',
                  maxLines: 2,
                ),
                _buildTextField(
                  controller.notesCtrl,
                  'Doctor Notes',
                  maxLines: 2,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 24,
                  ),
                ),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 50,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A5F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      onPressed: controller.isGeneratingReport.value
                          ? null
                          : controller.generateReport,
                      child: controller.isGeneratingReport.value
                          ? SizedBox(
                              width: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 24,
                              ),
                              height: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 24,
                              ),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Generate Report',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AdaptiveLayout.getResponsiveFontSize(
                                  context,
                                  fontSize: 16,
                                ),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String label, {
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: ctrl,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1E3A5F)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
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
                color: const Color(0xFF1E3A5F),
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
                    color: const Color(0xFF1E3A5F).withValues(alpha: 0.2),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32),
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32),
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.3),
                  blurRadius: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 6,
                  ),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.medical_services,
                color: Colors.white,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
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
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 6,
                    ),
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: message.text.isEmpty
                  ? SizedBox(
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                      height: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF1E3A5F),
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
                          color: Color(0xFF1E3A5F),
                        ),
                        listBullet: const TextStyle(color: Color(0xFF1E3A5F)),
                        code: TextStyle(
                          backgroundColor: Colors.grey.shade100,
                          color: Colors.red.shade800,
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

// ── PDF Bubble ────────────────────────────────────────────────────────────────
class _PdfBubble extends StatelessWidget {
  final String filename;
  final CopilotController controller;

  const _PdfBubble({required this.filename, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32),
            height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 32),
            decoration: BoxDecoration(
              color: Colors.red.shade400,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.picture_as_pdf,
                color: Colors.white,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
          ),
          Container(
            width: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 240),
            padding: EdgeInsets.all(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 4),
                ),
                topRight: Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
                ),
                bottomLeft: Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
                ),
                bottomRight: Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
                ),
              ),
              border: Border.all(color: Colors.red.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 6,
                  ),
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report Generated',
                  style: TextStyle(
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 12,
                    ),
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 4,
                  ),
                ),
                Text(
                  filename,
                  style: TextStyle(
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 14,
                    ),
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
                Obx(() {
                  final isDownloading =
                      controller.downloadingFilename.value == filename;
                  if (isDownloading) {
                    return Center(
                      child: SizedBox(
                        width: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 24,
                        ),
                        height: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 24,
                        ),
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () => controller.downloadAndOpen(filename),
                        icon: Icon(
                          Icons.open_in_new,
                          size: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 18,
                          ),
                        ),
                        label: const Text('View'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF1E3A5F),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => controller.sharePdf(filename),
                        icon: Icon(
                          Icons.share,
                          size: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 18,
                          ),
                        ),
                        label: const Text('Share'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF1E3A5F),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Typing Indicator ──────────────────────────────────────────────────────────
class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

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
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.medical_services,
                color: Colors.white,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 16,
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
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
                ),
                bottomLeft: Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
                ),
                bottomRight: Radius.circular(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
                ),
              ),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: SizedBox(
              width: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 30,
              ),
              height: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 10,
              ),
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                color: Color(0xFF1E3A5F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
