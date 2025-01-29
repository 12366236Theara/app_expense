import 'package:shared_preferences/shared_preferences.dart';

class Toekn {
  static Future<void> saveToken(String token) async {
    print("===========================tk $token");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSaved = await prefs.setString('token', token);
    if (isSaved) {
      print("Token saved successfully: $token");
    } else {
      print("Failed to save token");
    }
  }

  // Retrieve the saved token
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Retrieve token
  }

  // Remove the token (e.g., for logout)
  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Remove token
    print("Token removed successfully");
  }
}
