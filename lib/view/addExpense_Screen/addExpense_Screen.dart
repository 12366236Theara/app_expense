import 'package:app_cating/controller/createExpense_Controller.dart';
import 'package:app_cating/view/addExpense_Screen/compoment/amountInput.dart';
import 'package:app_cating/view/addExpense_Screen/compoment/categoryDropdown.dart';
import 'package:app_cating/view/addExpense_Screen/compoment/datePickerInput.dart';
import 'package:app_cating/view/addExpense_Screen/compoment/descriptionInput.dart';
import 'package:app_cating/widget/buttom_custem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final CreateexpenseController _controller =
      Get.put(CreateexpenseController());
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _customCategoryController =
      TextEditingController();
  bool _showCustomCategoryInput = false;
  String _selectedCategory = 'Food';
  DateTime _selectedDate = DateTime.now();

  final List<String> _categories = [
    'Food',
    'Transport',
    'Shopping',
    'Entertainment',
    'Bills',
    'Others',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('dd MMM yyyy').format(_selectedDate);
      });
    }
  }

  void _submitExpense() {
    if (_formKey.currentState!.validate()) {
      String categary = _selectedCategory;
      if (_selectedCategory == 'Others') {
        categary = _customCategoryController.text;
      }
      final amount = _amountController.text;
      final date = _dateController.text;
      final note = _descriptionController.text;
      final categarys = categary;
      _controller.createExpense(amount, categarys, date, note);
    }
  }

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd MMM yyyy').format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],  // Lighter background color for a clean feel
      appBar: AppBar(
        title: const Text(
          'Add Expense',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,  // Deep Purple app bar for consistency
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Amount Input
              AmountInput(controller: _amountController),
              const SizedBox(height: 16),
              // Description Input
              DescriptionInput(controller: _descriptionController),
              const SizedBox(height: 16),
              // Category Dropdown
              CategoryDropdown(
                selectedCategory: _selectedCategory,
                categories: _categories,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                    _showCustomCategoryInput = newValue == 'Others';
                  });
                },
                showCustomCategoryInput: _showCustomCategoryInput,
                customCategoryController: _customCategoryController,
              ),
              const SizedBox(height: 16),
              // Date Picker
              DatePickerInput(
                controller: _dateController,
                selectedDate: _selectedDate,
                onTap: _selectDate,
              ),
              const SizedBox(height: 24),

              // Submit Button
              Obx(
                () => Center(
                  child: buttomCustem(
                    _controller.isLoading.value
                        ? Colors.grey
                        : Color(0xFF5C6BC0),  // More vibrant color for the button
                    _controller.isLoading.value ? "Submitting..." : "Submit Expense",
                    _controller.isLoading.value ? null : _submitExpense,
                    textColor: Colors.white,
                    gradient: _controller.isLoading.value
                        ? null
                        : LinearGradient(
                            colors: [Colors.blueAccent, Colors.purpleAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
