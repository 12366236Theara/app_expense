import 'package:app_cating/service/deleteExpense_Service.dart';
import 'package:app_cating/controller/getExpense_Controller.dart';
import 'package:app_cating/view/main_Screen/main_Screen.dart';
import 'package:get/get.dart';

class DeleteexpenseController extends GetxController {
  late DeleteexpenseService _deleteexpenseService;
  final GetExpenseController _getExpenseController =
      Get.find(); // ind the GetExpenseController

  @override
  void onInit() {
    _deleteexpenseService = DeleteexpenseService();
    super.onInit();
  }

  var isLoading = false.obs;
  var deleteSuccess = false.obs;

  Future<void> deleteItem(int itemId) async {
    print("delete===============================$itemId");
    try {
      isLoading.value = true;
      final success = await _deleteexpenseService.deleteItem(itemId);

      if (success) {
        deleteSuccess.value = true;

        // Fetch updated expenses after deleting an item
        _getExpenseController.fetchExpenses();

        Get.snackbar("Success", "Expense deleted successfully!",
            snackPosition: SnackPosition.TOP);

        Get.offAll(MainScreen()); // Navigate after successful delete
      } else {
        deleteSuccess.value = false;
        // Get.snackbar("Error", "Failed to delete expense");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong. Try again.");
    }
    update();
  }
}
