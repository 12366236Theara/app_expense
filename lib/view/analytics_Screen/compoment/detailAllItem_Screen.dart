import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_cating/controller/getExpense_Controller.dart';

class AllItemsScreen extends StatelessWidget {
  const AllItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GetExpenseController controller = Get.put(GetExpenseController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Items',
          style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.expenses.isEmpty) {
          return const Center(child: Text('No expense data available.'));
        }

        return ListView.builder(
          itemCount: controller.categoryTotals.length,
          itemBuilder: (context, index) {
            String category =
                controller.countItemcategory.keys.elementAt(index);
            int count = controller.countItemcategory[category]!;
            double totalAmount = controller.categoryTotals[category] ?? 0.0;

            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
              child: Card(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  leading: Icon(
                    Icons.category,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                  title: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.monetization_on,
                            color: Colors.green,
                            size: 20,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Total Amount: \$${totalAmount.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            Icons.list,
                            color: Colors.orange,
                            size: 20,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Count: $count items",
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
