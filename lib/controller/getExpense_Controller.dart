import 'package:get/get.dart';
import 'package:app_cating/service/getExpense_Service.dart';
import 'package:app_cating/model/model_GetExpense.dart';

class GetExpenseController extends GetxController {
  var isLoading = true.obs; // Reactive loading indicator
  var expenses = <ModelGetExpense>[].obs; // Reactive list of expenses
  var categoryTotals = <String, double>{}.obs; // Totals grouped by CATEGORY
  var countItemcategory =
      <String, int>{}.obs; // Count of items grouped by CATEGORY
  var countDate = <String>{}.obs; // Count of items grouped by CATEGORY

  late final GetexpenseService _getexpenseService;

  @override
  void onInit() {
    _getexpenseService = GetexpenseService();
    fetchExpenses();
    super.onInit();
  }

  // Fetch expenses and calculate category totals
  Future<void> fetchExpenses() async {
    try {
      isLoading(true); // Show loading indicator
      final data = await _getexpenseService.getExpense();

      // Assign fetched expenses to the reactive list
      expenses.assignAll(data);

      // Calculate totals grouped by CATEGORY
      Map<String, double> totals = {};
      Map<String, int> counts =
          {}; // Map to store count of items in each category
      Map<String, int> dateAll = {}; //

      for (var expense in expenses) {
        String category = expense.cATEGORY ?? "Unknown";
        double amount = (expense.aMOUNT ?? 0).toDouble();
        String date = expense.dATE ?? "Unknown";
        dateAll[date] = (dateAll[date] ?? 0) + 1;
        // Update totals for each category
        totals[category] = (totals[category] ?? 0) + amount;
        // Update the count of items for each category
        counts[category] = (counts[category] ?? 0) + 1;
      }
      countDate.assignAll(dateAll.keys);
      // Update category totals and counts
      categoryTotals.assignAll(totals); // Update totals
      countItemcategory.assignAll(counts); // Update item counts

      // Debugging Logs
      print("Category totals updated: $categoryTotals");
      print("Item counts updated: $countItemcategory");
    } catch (e) {
      print("Error: ${e.toString()}");
    } finally {
      isLoading(false); // Hide loading indicator
    }
  }
}
