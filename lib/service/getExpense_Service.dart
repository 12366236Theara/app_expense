import 'dart:convert';
import 'package:app_cating/const/const_BaseURL.dart';
import 'package:app_cating/model/model_GetExpense.dart';
import 'package:app_cating/token/toekn.dart';
import 'package:http/http.dart' as http;

class GetexpenseService {
  Future<List<ModelGetExpense>> getExpense() async {
    final token = await Toekn.getToken();
    print("---------------------------Token: $token");

    try {
      final response = await http.get(
        Uri.parse(ConstBaseURL.URL_GETEXPENSE),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> result = jsonDecode(response.body);

        // Map the dynamic list to List<ModelGetExpense>
        final expenses = result.map((json) {
          return ModelGetExpense.fromJson(json as Map<String, dynamic>);
        }).toList();

        print('Parsed expenses: $expenses');
        return expenses;
      } else {
        print('Failed to fetch expenses. Status code: ${response.statusCode}');
        return []; // Return an empty list if the status code is not 200
      }
    } catch (e) {
      print("Error while fetching expenses: $e");
      return []; // Return an empty list in case of an exception
    }
  }
}
