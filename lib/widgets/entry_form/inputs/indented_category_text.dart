import 'package:flutter/material.dart';

class IndentedCategoryText extends StatelessWidget {
  final double leftIndentation;
  final String text;

  const IndentedCategoryText({Key? key, this.leftIndentation = 8, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: leftIndentation),
        child: Text(text, style: Theme.of(context).textTheme.titleSmall));
  }
}