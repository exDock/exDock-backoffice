// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/category/category_data.dart';

class CategoryEditTitle extends StatelessWidget {
  const CategoryEditTitle({
    super.key,
    required this.categorySelection,
  });

  final List<CategoryLeaf> categorySelection;

  String parentCategoriesText(List<CategoryLeaf> categorySelection) {
    final List<String> outputList = [];

    for (final CategoryLeaf categoryLeaf in categorySelection) {
      outputList.add(categoryLeaf.name.toLowerCase());
    }
    outputList.removeLast();

    return outputList.join(" > ");
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle mainTitleStyle =
        Theme.of(context).textTheme.headlineLarge ??
            const TextStyle(
              fontSize: 48,
            );
    const TextStyle parentLeavesTextStyle = TextStyle();
    if (categorySelection.isEmpty) {
      return Text(
        "No category selected",
        style: mainTitleStyle,
      );
    }

    if (categorySelection.length == 1) {
      return Text(
        categorySelection[0].name,
        style: mainTitleStyle,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          parentCategoriesText(categorySelection),
          style: parentLeavesTextStyle,
        ),
        Text(
          categorySelection.last.name,
          style: mainTitleStyle,
        ),
      ],
    );
  }
}
