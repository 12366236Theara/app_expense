import 'dart:convert';
import 'package:app_cating/token/toekn.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:app_cating/const/const_BaseURL.dart';
import 'package:app_cating/model/model_Login.dart';

class LoginService {
  Future<ModelLogin> postLogin(String email, password) async {
    print("Posting ================$email");
    final respnse = await http.post(
      Uri.parse(ConstBaseURL.URL_LOGIN),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    ).timeout(
      Duration(
        seconds: 100,
      ),
    );

    if (respnse.statusCode == 200) {
      final data = jsonDecode(respnse.body);
      String token = data['token'];
      await Toekn.saveToken(token);
      print(data);

      return ModelLogin.fromJson(data);
    } else {
      final errorData = jsonDecode(respnse.body);
      Get.snackbar("Error", errorData['message']);
      throw Exception(errorData['message'] ?? "Failed to sign up");
    }
  }
}
