import 'package:app_cating/controller/getExpense_Controller.dart';
import 'package:app_cating/view/dashboard_Screen/compoment/expenseDetail.dart';

import 'package:app_cating/view/dashboard_Screen/compoment/line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart'; // For pie_chart package

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GetExpenseController _getExpenseController =
      Get.put(GetExpenseController());

  @override
  void initState() {
    super.initState();
    _getExpenseController.fetchExpenses();
  }

  String? selectedCategory = 'All'; // Selected category for filtering

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple, // Darker app bar color
        title: Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Obx(
        () {
          if (_getExpenseController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_getExpenseController.expenses.isEmpty) {
            return const Center(child: Text('No expense data available.'));
          }

          final dataMap = _getExpenseController.categoryTotals;
          final colorList = generateColors(dataMap);
          final dateMap = _getExpenseController.countDate;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Total Expenses Card
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Card(
                        elevation: 0.1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Expenses",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "\$${dataMap.values.fold(0.0, (double sum, double value) => sum + value).toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Pie Chart for Expenses by Category
                    Text(
                      "Expenses by Category",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: PieChart(
                            chartValuesOptions: ChartValuesOptions(
                              showChartValues: false,
                              showChartValuesOutside: true,
                            ),
                            dataMap: dataMap,
                            chartType: ChartType.disc,
                            chartRadius:
                                MediaQuery.of(context).size.width / 1.5,
                            colorList: colorList,
                          ),
                        ),
                        line(),
                        // Category Filter Dropdown
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Category Filter",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              DropdownButton<String>(
                                alignment: Alignment.center,
                                iconSize: 40,
                                borderRadius: BorderRadius.circular(10),
                                value: selectedCategory,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCategory = newValue;
                                  });
                                },
                                isExpanded: true,
                                // style: TextStyle(
                                //   decorationColor: Colors.black,
                                // ),
                                icon: Icon(Icons.arrow_drop_down),
                                items: ['All', ...dateMap].map((category) {
                                  return DropdownMenuItem(
                                    value: category,
                                    child: Text(
                                      category,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 26),
                        // Recent Expenses List
                        Text(
                          "Recent Expenses",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 26),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _getExpenseController.expenses.length,
                          itemBuilder: (context, index) {
                            final expense =
                                _getExpenseController.expenses[index];

                            if (selectedCategory != null &&
                                selectedCategory != "All" &&
                                expense.dATE != selectedCategory) {
                              return SizedBox.shrink();
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(ExpenseDetailScreen(
                                    category: expense.cATEGORY ?? '',
                                    amount: expense.aMOUNT ?? 0,
                                    description: expense.nOTES ?? '',
                                    date: expense.dATE ?? '',
                                    id: expense.iD ?? 0,
                                  ));
                                },
                                child: Card(
                                  color:
                                      Colors.deepPurpleAccent.withOpacity(0.5),
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(12),
                                    leading: Icon(Icons.category,
                                        color: Colors.amber[
                                            200]), // Professional blue for icon
                                    title: Text(
                                      "${expense.cATEGORY} -  \$${expense.aMOUNT?.toStringAsFixed(2)}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors
                                            .black87, // Dark text for title
                                      ),
                                    ),
                                    subtitle: Text(
                                      expense.dATE ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.grey[
                                            1000], // Lighter grey for subtitle
                                      ),
                                    ),
                                    trailing: Icon(Icons.delete,
                                        color: Colors.red[
                                            600]), // Soft red for delete icon
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Color> generateColors(Map<String, double> dataMap) {
    List<double> values = dataMap.values.toList();
    final double minValue = values.reduce((a, b) => a < b ? a : b);
    final double maxValue = values.reduce((a, b) => a > b ? a : b);

    return values.map((value) {
      if (value == minValue) return Colors.red;
      if (value == maxValue) return Colors.indigo;
      return Colors.blueGrey;
    }).toList();
  }
}
