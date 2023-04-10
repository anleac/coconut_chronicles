import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:coconut_chronicles/core/storage/entry_storage.dart';
import 'package:coconut_chronicles/widgets/dialogues/dialogue_builder.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class NewEntryOptions extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const NewEntryOptions({Key? key, required this.formKey}) : super(key: key);

  @override
  State<NewEntryOptions> createState() => _NewEntryOptionsState();
}

class _NewEntryOptionsState extends State<NewEntryOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => DialogueBuilder.showConfirmToClearDialogue(context, onConfirm: _clearData),
          child: const Text('Clear'),
        ),
        TextButton(
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              _saveEntry();
            }
          },
          child: const Text('Save'),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }

  _saveEntry() async {
    var snackContext = ScaffoldMessenger.of(context);
    await EntryStorage.saveEntry(ScopedModel.of<EntryModel>(context));
    _clearData();
    snackContext.showSnackBar(
      const SnackBar(content: Text('Saved chronicle entry')),
    );
  }

  _clearData() {
    var entry = ScopedModel.of<EntryModel>(context);
    if (entry.isNewEntry) {
      entry.clearProperties();
    }

    widget.formKey.currentState?.reset();
  }
}
