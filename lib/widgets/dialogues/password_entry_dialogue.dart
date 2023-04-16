import 'package:coconut_chronicles/core/storage/encryption.dart';
import 'package:flutter/material.dart';

class PasswordEntryDialogue extends StatefulWidget {
  const PasswordEntryDialogue({Key? key}) : super(key: key);

  @override
  State<PasswordEntryDialogue> createState() => _PasswordEntryDialogueState();
}

class _PasswordEntryDialogueState extends State<PasswordEntryDialogue> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter password'),
      content: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            maxLength: Encryption.encryptionKeyLength,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }

              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }

              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            obscureText: true,
            maxLength: Encryption.encryptionKeyLength,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Confirm password',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(_passwordController.text);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
