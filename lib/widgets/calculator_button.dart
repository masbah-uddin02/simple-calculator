// lib/widgets/calculator_button.dart

import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEqualsButton;
  final bool isClearButton;

  const CalculatorButton({
    required this.text,
    required this.onPressed,
    this.isEqualsButton = false,
    this.isClearButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isEqualsButton ? 2 : 1, // Set flex to 2 for equals button, 1 for others
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: isEqualsButton ? Colors.green : Colors.blue, // Set green color for equals button, blue for others
          onPrimary: Colors.white, // Set text color to white
          padding: EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24.0,
            color: isEqualsButton ? Colors.white : null, // Set white color for text on equals button
          ),
        ),
      ),
    );
  }
}
