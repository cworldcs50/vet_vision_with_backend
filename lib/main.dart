import 'vet_vision.dart';
import 'package:flutter/material.dart';
import 'core/services/app_service.dart';
import 'package:device_preview/device_preview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(
    DevicePreview(
      enabled: false, // show preview only in debug mode
      builder: (context) => const VetVision(),
    ),
  );
}
