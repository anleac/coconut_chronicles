import 'package:flutter/material.dart';

class ValidationErrorText extends StatelessWidget {
  final String errorText;

  const ValidationErrorText({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    // Designed to mimic the error text within the TextFormField widget
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            errorText,
            style: const TextStyle(color: Color(0xFFba1a1a), fontSize: 12),
          ))
    ]);
  }
}
