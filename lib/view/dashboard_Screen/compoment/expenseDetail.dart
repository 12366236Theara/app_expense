import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:app_cating/controller/deleteExpense_Controller.dart';
import 'package:app_cating/view/dashboard_Screen/compoment/category_Detail.dart';

class ExpenseDetailScreen extends StatefulWidget {
  final int id;
  final String category;
  final int amount;
  final String description;
  final String date;

  const ExpenseDetailScreen({
    Key? key,
    required this.id,
    required this.category,
    required this.amount,
    required this.description,
    required this.date,
  }) : super(key: key);

  @override
  _ExpenseDetailScreenState createState() => _ExpenseDetailScreenState();
}

class _ExpenseDetailScreenState extends State<ExpenseDetailScreen> {
  final DeleteexpenseController _controller = Get.put(DeleteexpenseController());

  String _formatDate(String date) {
    try {
      return DateFormat("MMM d, yyyy").format(DateFormat("dd MMM yyyy").parse(date));
    } catch (e) {
      return "Invalid Date";
    }
  }

  void _handleDelete() {
    if (widget.id > 0) {
      _controller.deleteItem(widget.id);
      Get.back();
      Get.snackbar("Success", "Expense deleted successfully",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("Error", "Invalid expense ID",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expense Details",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryDetail(widget.category, widget.amount),
              const SizedBox(height: 20),
              _buildDetailItem(Icons.calendar_today, "Date", _formatDate(widget.date)),
              _buildDetailItem(Icons.category, "Category", widget.category),
              _buildDetailItem(
                Icons.description,
                "Description",
                widget.description.isNotEmpty ? widget.description : "No description",
              ),
              const SizedBox(height: 20),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.teal, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87)),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton("Edit", Icons.edit, Colors.blue, () {
          // TODO: Implement Edit functionality
        }),
        _buildActionButton("Delete", Icons.delete, Colors.red, _handleDelete),
      ],
    );
  }

  Widget _buildActionButton(
      String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 5,
        textStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
