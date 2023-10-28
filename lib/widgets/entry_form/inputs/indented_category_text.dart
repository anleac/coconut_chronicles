import 'package:flutter/material.dart';

class IndentedCategoryText extends StatelessWidget {
  final double topIndentation;
  final double leftIndentation;
  final String text;

  const IndentedCategoryText({super.key, this.leftIndentation = 8, this.topIndentation = 0, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: leftIndentation, top: topIndentation),
        child: Text(text, style: Theme.of(context).textTheme.titleSmall));
  }
}
