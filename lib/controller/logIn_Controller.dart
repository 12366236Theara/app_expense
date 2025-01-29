import 'package:app_cating/service/login_Service.dart';
import 'package:app_cating/view/main_Screen/main_Screen.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late final LoginService _loginService;
  var isLoarding = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loginService = LoginService(); // Initialize it here
  }

  

  Future<void> login(String email, String password) async {
    isLoarding.value = true;

    try {
      print("login: =================$email");
      final result = await _loginService.postLogin(email, password);
      print("===============================$email");
      print('Success $result');
      Get.offAll(() => const MainScreen());
    } catch (e) {
      print("Failed to login  ${e.toString()}");
      // You can customize how the error is displayed or logged here
    } finally {
      isLoarding.value = false;
    }
  }
}
