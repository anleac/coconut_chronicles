import 'package:coconut_chronicles/core/models/entry_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ChipCategories extends StatefulWidget {
  final List<String> categories;

  const ChipCategories({Key? key, required this.categories}) : super(key: key);

  @override
  State<ChipCategories> createState() => _ChipCategoriesState();
}

class _ChipCategoriesState extends State<ChipCategories> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EntryModel>(
        builder: (context, child, model) => Wrap(
              spacing: 8.0,
              runSpacing: 4,
              children: widget.categories
                  .map((category) => FilterChip(
                        label: Text(category),
                        shape: const StadiumBorder(),
                        selected: model.categories.contains(category),
                        onSelected: (bool value) {
                          setState(() {
                            if (value) {
                              model.addCategory(category);
                            } else {
                              model.removeCategory(category);
                            }
                          });
                        },
                      ))
                  .toList(),
            ));
  }
}
