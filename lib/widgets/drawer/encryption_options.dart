import 'package:coconut_chronicles/core/storage/encryption.dart';
import 'package:coconut_chronicles/widgets/dialogues/confirmation_dialogue_builder.dart';
import 'package:coconut_chronicles/widgets/dialogues/password_entry_dialogue.dart';
import 'package:flutter/material.dart';

class EncryptionOptions extends StatefulWidget {
  const EncryptionOptions({Key? key}) : super(key: key);

  @override
  State<EncryptionOptions> createState() => _EncryptionOptionsState();
}

class _EncryptionOptionsState extends State<EncryptionOptions> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: Encryption.isEncryptionEnabled(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return SwitchListTile(
              title: const Text('Encrypted data'),
              value: data,
              onChanged: Encryption.supportedPlatform
                  ? (value) => value ? _trySetEncryptionKey() : _tryClearEncryptionKey()
                  : null,
            );
          }

          return Container();
        });
  }

  _trySetEncryptionKey() async {
    var key = await showDialog<String?>(
      context: context,
      builder: (context) => const PasswordEntryDialogue(),
    );

    if (key == null) {
      return false;
    }

    await Encryption.setEncryptionKey(key);
    setState(() {});
  }

  _tryClearEncryptionKey() async {
    var clearConfirmation = await ConfirmationDialogueBuilder.showClearEncryptionKey(context);
    if (clearConfirmation) {
      await Encryption.clearEncryptionKey();
      setState(() {});
    }
  }
}
