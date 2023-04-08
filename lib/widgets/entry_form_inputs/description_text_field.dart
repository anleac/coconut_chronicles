import 'package:coconut_chronicles/core/helpers/validator_helper.dart';
import 'package:flutter/material.dart';

class DescriptionTextField extends StatefulWidget {
  final ValueChanged<String> onDescriptionChange;
  const DescriptionTextField({Key? key, required this.onDescriptionChange}) : super(key: key);

  @override
  State<DescriptionTextField> createState() => _DescriptionTextFieldState();
}

class _DescriptionTextFieldState extends State<DescriptionTextField> {
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Description of the day',
      ),
      maxLines: null,
      controller: _bodyController,
      minLines: 10,
      onChanged: (value) => widget.onDescriptionChange(value),
      textAlignVertical: TextAlignVertical.top,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      validator: (value) => ValidatorHelper.emptyTextValidator(value),
    );
  }
}
