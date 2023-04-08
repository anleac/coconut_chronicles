import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:flutter/material.dart';

class EntryListTitle extends StatelessWidget {
  final EntryModel entry;
  final VoidCallback onTap;

  const EntryListTitle({Key? key, required this.entry, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(entry.safeTitle, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(entry.safeDate),
      onTap: onTap,
    );
  }
}
