import 'package:app_cating/service/createExpense_Service.dart';
import 'package:app_cating/view/main_Screen/main_Screen.dart';
import 'package:get/get.dart';

class CreateexpenseController extends GetxController {
  var isLoading = false.obs;
  late final CreateexpenseService _createexpenseService =
      CreateexpenseService();

  Future<void> createExpense(
      String amount, String category, String date, String note) async {
    update(); // To notify listeners about the loading state
    try {
      isLoading.value = true;
      final result = await _createexpenseService.createService(
          amount, category, date, note);
      // Assuming `result` contains success information, like a success message
      Get.offAll(MainScreen()); // Navigate to MainScreen
      // Save expense logic here
      Get.snackbar("Success", "Expense created successfully!",
          snackPosition: SnackPosition.TOP);
      print("Expense created successfully: $result");
    } catch (e) {
      Get.snackbar("Error", "Failed to create expense.",
          snackPosition: SnackPosition.BOTTOM);
      print("Error creating expense: ${e.toString()}");
    } finally {
      isLoading.value = false;
      update(); // Notify listeners about the updated state
    }
  }
}
