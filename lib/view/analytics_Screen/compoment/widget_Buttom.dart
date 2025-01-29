import 'package:flutter/material.dart';

Widget widgetButtom(ontap) {
  return ElevatedButton(
    onPressed: ontap,
    // Get.to(() => AllItemsScreen()); // Navigate to detailed screen

    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepPurple, // Text color
      padding: const EdgeInsets.symmetric(
          vertical: 14.0, horizontal: 24.0), // Padding for better touch target
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      elevation: 2.0, // Shadow for depth
    ),
    child: const Text(
      "View All Items",
      style: TextStyle(
        fontSize: 16.0, // Font size for better readability
        fontWeight: FontWeight.w600, // Slightly bold for emphasis
      ),
    ),
  );
}
