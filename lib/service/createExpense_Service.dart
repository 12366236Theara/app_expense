import 'dart:convert';

import 'package:app_cating/const/const_BaseURL.dart';
import 'package:app_cating/model/model_CreateExpense.dart';
import 'package:app_cating/token/toekn.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class CreateexpenseService {
  Future<ModelCreateExpense> createService(
      String amount, String category, String date, note) async {
    final token = await Toekn.getToken();
    print(token);
    final response = await http.post(
      Uri.parse(
        ConstBaseURL.URL_ADDEXPENSE,
      ),
      body: jsonEncode(
        {
          "amount": amount,
          "category": category,
          "date": date,
          "notes": note,
        },
      ),
      headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      final resutf = await jsonDecode(response.body);
      return ModelCreateExpense.fromJson(resutf);
    } else {
      final errorData = jsonDecode(response.body);
      Get.snackbar("Error", errorData['message']);
      throw Exception(errorData['message'] ?? "Failed to add expense");
    }
  }
}
