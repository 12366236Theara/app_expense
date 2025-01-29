import 'dart:convert';

import 'package:app_cating/const/const_BaseURL.dart';
import 'package:app_cating/model/model_SigUp.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class SigupService {
  Future<ModelSigUp> postSigUp(String email, String username, String password,
      String confirmPassword) async {
    try {
      print("Posting Signup Request for $email");

      final response = await http.post(
        Uri.parse(ConstBaseURL.URL_SIGNUP),
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        }),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 30));
      print("Response: ${response.statusCode}, Body: ${response.body}");
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return ModelSigUp.fromJson(data);
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar("Error", errorData['message']);
        throw Exception(errorData['message'] ?? "Failed to sign up");
      }
    } catch (e) {
      throw Exception("Error during signup: $e");
    }
  }
}
