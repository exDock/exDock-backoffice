// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/category/category_data.dart';
import 'package:exdock_backoffice/pages/catalog/category/edit/content/category_edit_content.dart';
import 'package:exdock_backoffice/pages/catalog/category/edit/header/category_edit_header.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class CategoryEdit extends StatefulWidget {
  const CategoryEdit({super.key, required this.categorySelection});

  final List<CategoryLeaf> categorySelection;

  @override
  State<CategoryEdit> createState() => _CategoryEditState();
}

class _CategoryEditState extends State<CategoryEdit> {
  final MapNotifier changeAttributeMap = MapNotifier();

  @override
  Widget build(BuildContext context) {
    Widget categoryContent = const Center(child: Text("no category selected"));

    if (widget.categorySelection.isNotEmpty) {
      categoryContent = CategoryEditContent(
        selectedCategoryLeaf: widget.categorySelection.last,
        changeAttributeMap: changeAttributeMap,
      );
    }

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 104),
          child: categoryContent,
        ),
        CategoryEditHeader(
          categorySelection: widget.categorySelection,
          changeAttributeMap: changeAttributeMap,
          mainSetState: setState,
        ),
      ],
    );
  }
}
