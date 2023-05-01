import 'package:coconut_chronicles/constants/default_constants.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/chip_categories.dart';
import 'package:coconut_chronicles/widgets/entry_form/inputs/indented_category_text.dart';
import 'package:flutter/material.dart';

class OptionalInputs extends StatefulWidget {
  const OptionalInputs({Key? key}) : super(key: key);

  @override
  State<OptionalInputs> createState() => _OptionalInputsState();
}

class _OptionalInputsState extends State<OptionalInputs> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return const ListTile(
                title: Text('Optional data'),
              );
            },
            isExpanded: _isExpanded,
            canTapOnHeader: true,
            body: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: const [
                    IndentedCategoryText(text: 'Categories'),
                    SizedBox(height: 8),
                    ChipCategories(categories: DefaultConstants.defaultChipSuggestions),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
