import 'package:get/get.dart';

class MessagesController extends GetxController {
  Future<void> refreshMessagesList() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    update();
  }
}
