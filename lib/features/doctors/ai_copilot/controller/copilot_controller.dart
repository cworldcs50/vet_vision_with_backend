import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/caching_keys_constants.dart';
import '../../../../core/services/app_service.dart';
import '../../../../../../features/users/ai_chat/model/chat_message.dart';
import '../data/copilot_repository.dart';

class CopilotController extends GetxController {
  final CopilotRepository _repo = CopilotRepository();

  final messages = <ChatMessage>[].obs;
  final isTyping = false.obs;
  final textController = TextEditingController();
  final scrollController = ScrollController();

  // Report form controllers
  final animalNameCtrl = TextEditingController();
  final animalTypeCtrl = TextEditingController();
  final ownerNameCtrl = TextEditingController();
  final weightCtrl = TextEditingController();
  final diagnosisCtrl = TextEditingController();
  final treatmentCtrl = TextEditingController();
  final notesCtrl = TextEditingController();

  final isGeneratingReport = false.obs;
  final downloadingFilename = ''.obs;

  bool _isStreaming = false;

  @override
  void onInit() {
    super.onInit();
    _loadDoctorName();
    _addWelcome();
  }

  String _doctorName = 'Doctor';

  void _loadDoctorName() {
    _doctorName =
        Get.find<AppServices>().appSharedPrefs.getString(
          CachingKeysConstants.kUserFullName,
        ) ??
        'Doctor';
  }

  void _addWelcome() {
    messages.add(
      ChatMessage.ai(
        'Hello Dr. **$_doctorName** 👨‍⚕️\n\n'
        'I\'m your **Vet Copilot**, your AI-powered clinical assistant.\n\n'
        'I can help you with:\n'
        '- Clinical diagnosis support\n'
        '- Treatment recommendations\n'
        '- Generating patient PDF reports\n'
        '- Looking up veterinary knowledge\n\n'
        'What would you like to work on today?',
      ),
    );
  }

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || _isStreaming) return;

    textController.clear();
    _isStreaming = true;

    messages.add(ChatMessage.user(trimmed));
    _scrollToBottom();

    final aiMsg = ChatMessage.ai('');
    messages.add(aiMsg);
    isTyping.value = true;
    _scrollToBottom();

    String fullResponse = '';

    try {
      final stream = _repo.streamCopilot(
        message: trimmed,
        onError: (err) {
          aiMsg.text = '⚠️ Error: $err';
          messages.refresh();
        },
      );

      await for (final token in stream) {
        fullResponse += token;
        aiMsg.text = fullResponse;
        messages.refresh();
        _scrollToBottom();
      }

      // Detect if the AI generated a PDF filename in the response
      _detectPdfInResponse(fullResponse, aiMsg);
    } catch (e) {
      aiMsg.text = '⚠️ Connection error. Please try again.';
      messages.refresh();
    } finally {
      isTyping.value = false;
      _isStreaming = false;
      _scrollToBottom();
    }
  }

  void _detectPdfInResponse(String response, ChatMessage aiMsg) {
    final regex = RegExp(r'[\w\-]+\.pdf', caseSensitive: false);
    final match = regex.firstMatch(response);
    if (match != null) {
      final filename = match.group(0)!;
      // Add a special PDF action message
      final pdfMsg = ChatMessage.ai('__PDF__:$filename');
      messages.add(pdfMsg);
      messages.refresh();
    }
  }

  Future<void> generateReport() async {
    if (animalNameCtrl.text.trim().isEmpty ||
        diagnosisCtrl.text.trim().isEmpty ||
        treatmentCtrl.text.trim().isEmpty) {
      Get.snackbar(
        'Incomplete',
        'Please fill required fields.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    isGeneratingReport.value = true;

    try {
      final result = await _repo.generateReport(
        animalName: animalNameCtrl.text.trim(),
        animalType: animalTypeCtrl.text.trim().isEmpty
            ? 'Unknown'
            : animalTypeCtrl.text.trim(),
        ownerName: ownerNameCtrl.text.trim().isEmpty
            ? 'Owner'
            : ownerNameCtrl.text.trim(),
        weightKg: double.tryParse(weightCtrl.text.trim()) ?? 0.0,
        diagnosis: diagnosisCtrl.text.trim(),
        treatment: treatmentCtrl.text.trim(),
        doctorName: _doctorName,
        doctorNotes: notesCtrl.text.trim(),
      );

      final filename =
          result['filename']?.toString() ??
          result['report_filename']?.toString() ??
          '';

      Get.back(); // close bottom sheet
      _clearReportForm();

      if (filename.isNotEmpty) {
        // Add PDF card message
        messages.add(ChatMessage.ai('__PDF__:$filename'));
        messages.refresh();
        _scrollToBottom();
        Get.snackbar(
          '✅ Report Generated',
          'Your PDF report is ready to download.',
          backgroundColor: const Color(0xFF009689),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate report. Check your connection.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isGeneratingReport.value = false;
    }
  }

  Future<void> downloadAndOpen(String filename) async {
    downloadingFilename.value = filename;
    try {
      final bytes = await _repo.downloadReport(filename);
      final path = await _savePdf(filename, bytes);
      await OpenFilex.open(path);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to download report.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      downloadingFilename.value = '';
    }
  }

  Future<void> sharePdf(String filename) async {
    downloadingFilename.value = filename;
    try {
      final bytes = await _repo.downloadReport(filename);
      final path = await _savePdf(filename, bytes);
      await SharePlus.instance.share(
        ShareParams(files: [XFile(path)], text: 'Vet Vision Patient Report'),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to share report.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      downloadingFilename.value = '';
    }
  }

  Future<String> _savePdf(String filename, Uint8List bytes) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  void _clearReportForm() {
    animalNameCtrl.clear();
    animalTypeCtrl.clear();
    ownerNameCtrl.clear();
    weightCtrl.clear();
    diagnosisCtrl.clear();
    treatmentCtrl.clear();
    notesCtrl.clear();
  }

  void resetChat() {
    _isStreaming = false;
    isTyping.value = false;
    textController.clear();
    messages.clear();
    _addWelcome();
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
    animalNameCtrl.dispose();
    animalTypeCtrl.dispose();
    ownerNameCtrl.dispose();
    weightCtrl.dispose();
    diagnosisCtrl.dispose();
    treatmentCtrl.dispose();
    notesCtrl.dispose();
    super.onClose();
  }
}
