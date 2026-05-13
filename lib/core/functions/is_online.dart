import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  List<ConnectivityResult> connectivityResult =
      await Connectivity().checkConnectivity();

  return connectivityResult.first != ConnectivityResult.none;
}

Future<bool> checkInternetAccess() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (_) {
    return false;
  }
}

Future<bool> isOnline() async =>
    await checkConnection() && await checkInternetAccess();
