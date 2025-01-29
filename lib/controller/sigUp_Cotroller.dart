import 'package:app_cating/service/sigup_Service.dart';
import 'package:app_cating/view/login_screen/login_Screen.dart';

import 'package:get/get.dart';

class SigupCotroller extends GetxController {
  late final SigupService _service;
  var isLoarding = false.obs;

  @override
  void onInit() {
    super.onInit();
    _service = SigupService(); // Initialize it here
  }

  Future<void> siup(
    String email,
    String password,
    String username,
    String confirmPassword,
  ) async {
    isLoarding.value = true;

    try {
      print("login: =================$email");
      final result =
          await _service.postSigUp(email, username, password, confirmPassword);
      print("===============================$email");
      print('Success $result');
      Get.off(() => LoginScreen());
    } catch (e) {
      print("Failed to sigUP  ${e.toString()}");
      // You can customize how the error is displayed or logged here
    } finally {
      isLoarding.value = false;
    }
  }
}
