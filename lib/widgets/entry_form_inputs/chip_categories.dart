import 'package:flutter/material.dart';

class ChipCategories extends StatefulWidget {
  final List<String> categories;
  final Function(String category) onSelected;
  final Function(String category) onDeselected;

  const ChipCategories({Key? key, required this.categories, required this.onSelected, required this.onDeselected})
      : super(key: key);

  @override
  State<ChipCategories> createState() => _ChipCategoriesState();
}

class _ChipCategoriesState extends State<ChipCategories> {
  final Set<String> _selectedFilters = <String>{};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4,
      children: widget.categories
          .map((category) => FilterChip(
                label: Text(category),
                shape: const StadiumBorder(),
                selected: _selectedFilters.contains(category),
                onSelected: (bool value) {
                  setState(() {
                    if (value) {
                      _selectedFilters.add(category);
                      widget.onSelected(category);
                    } else {
                      _selectedFilters.remove(category);
                      widget.onDeselected(category);
                    }
                  });
                },
              ))
          .toList(),
    );
  }
}
