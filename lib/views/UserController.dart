import 'package:get/get.dart';

class UserController extends GetxController {
  var name = ''.obs;

  void resetName() {
    name.value = '';
  }
}
