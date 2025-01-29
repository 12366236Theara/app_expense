import 'package:flutter/material.dart';

class buttomCustem extends StatelessWidget {
  final Color color; // Solid color
  final String text; // Button text
  final VoidCallback? onPressed; // Click action
  final Color textColor; // Text color
  final bool isLoading; // Loading state

  const buttomCustem(
    this.color,
    this.text,
    this.onPressed, {
    this.textColor = Colors.white,
    this.isLoading = false, // Default is false
    super.key,
    LinearGradient? gradient,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // Disable button if loading
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(color), // Use solid color
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(textColor),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
