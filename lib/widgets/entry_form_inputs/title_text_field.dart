import 'package:coconut_chronicles/core/helpers/validator_helper.dart';
import 'package:flutter/material.dart';

class TitleTextField extends StatefulWidget {
  final ValueChanged<String> onTitleChange;
  const TitleTextField({Key? key, required this.onTitleChange}) : super(key: key);

  @override
  State<TitleTextField> createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends State<TitleTextField> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Captivating title',
      ),
      controller: _titleController,
      onChanged: (value) => widget.onTitleChange(value),
      validator: (value) => ValidatorHelper.emptyTextValidator(value),
    );
  }
}
