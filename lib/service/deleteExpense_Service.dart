import 'package:app_cating/const/const_BaseURL.dart';
import 'package:app_cating/token/toekn.dart';
import 'package:http/http.dart' as http;

class DeleteexpenseService {
  Future<bool> deleteItem(int itemId) async {
    final token = await Toekn.getToken();
    final url = Uri.parse('${ConstBaseURL.URL_DELETEEXPENSE}$itemId');
    print("Deleting =======================----------$itemId");
    print("================================$token");
    final response = await http.delete(url, headers: {
      'Authorization': 'Bearer $token',
    });
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    if (response.statusCode == 200) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      return true;
    } else {
      // Failed to delete the item
      return false;
    }
  }
}
