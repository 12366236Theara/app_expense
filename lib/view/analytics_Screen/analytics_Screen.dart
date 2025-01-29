import 'package:app_cating/view/analytics_Screen/compoment/detailAllItem_Screen.dart';
import 'package:app_cating/view/analytics_Screen/compoment/widget_Buttom.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:app_cating/controller/getExpense_Controller.dart';
import 'package:app_cating/model/model_GetExpense.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GetExpenseController controller = Get.put(GetExpenseController());
    // Refresh data when the screen is shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchExpenses();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Analytics',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.expenses.isEmpty) {
          return const Center(child: Text('No expense data available.'));
        }

        // Prepare data for the chart
        final chartData = controller.categoryTotals.entries
            .map((entry) => ModelGetExpense(
                cATEGORY: entry.key, aMOUNT: entry.value.toInt()))
            .toList();

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Monthly Spending Trends Section
              const Text(
                '📊 Monthly Spending Trends',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 12.0),
              SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // title:ChartTitle(text: 'ege'),
                // legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<ModelGetExpense, String>>[
                  ColumnSeries<ModelGetExpense, String>(
                    dataSource: chartData,
                    xValueMapper: (ModelGetExpense data, _) => data.cATEGORY,
                    yValueMapper: (ModelGetExpense data, _) => data.aMOUNT,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              // Top Categories Section
              const Text(
                '🏷️ Top Categories',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16.0),
              // "All Items" Button to view all items
              widgetButtom(() {
                Get.to(AllItemsScreen());
              }),
              const SizedBox(height: 12.0),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.categoryTotals.length > 4
                    ? 4
                    : controller.categoryTotals.length,
                itemBuilder: (context, index) {
                  String category =
                      controller.countItemcategory.keys.elementAt(index);
                  int count = controller.countItemcategory[category]!;
                  double totalAmount =
                      controller.categoryTotals[category] ?? 0.0;
                  return Card(
                    child: ListTile(
                      title: Text(category),
                      subtitle: Text(
                          "Total Amount: \$${totalAmount.toStringAsFixed(2)}"),
                      trailing: Text("Count: $count items"),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
