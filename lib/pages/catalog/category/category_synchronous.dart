// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:kumi_popup_window/kumi_popup_window.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/category/category_data.dart';
import 'package:exdock_backoffice/pages/catalog/category/edit/category_edit.dart';
import 'package:exdock_backoffice/pages/catalog/category/selection_bar/edit_category_structure_popup.dart';
import 'package:exdock_backoffice/pages/catalog/category/selection_bar/sub_category_row.dart';
import 'package:exdock_backoffice/pages/catalog/category/selection_bar/top_category_row.dart';

class CategorySynchronous extends StatefulWidget {
  const CategorySynchronous({
    super.key,
    required this.categoryTree,
    this.selectedId,
  });

  final CategoryTree categoryTree;
  final int? selectedId;

  @override
  State<CategorySynchronous> createState() => _CategorySynchronousState();
}

class _CategorySynchronousState extends State<CategorySynchronous> {
  List<CategoryLeaf> categorySelection = [];
  int selectedCategory = -1;

  void updateUri() {
    final List<int> categorySelectionIds = [];

    for (final CategoryLeaf category in categorySelection) {
      categorySelectionIds.add(category.id);
    }

    SystemNavigator.routeInformationUpdated(
      uri: Uri(path: "/catalog/category/${categorySelectionIds.last}"),
    );
  }

  List<CategoryLeaf>? applySelectedCategory(List<CategoryLeaf>? categoryTree) {
    if (widget.selectedId == null || categoryTree == null) return null;

    for (final CategoryLeaf leaf in categoryTree) {
      if (leaf.id == widget.selectedId) return [leaf];
      final List<CategoryLeaf>? foundSelection =
          applySelectedCategory(leaf.subLeaves);
      if (foundSelection != null) return [leaf, ...foundSelection];
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    categorySelection = applySelectedCategory(widget.categoryTree.leaves) ?? [];

    if (categorySelection.isEmpty) {
      SystemNavigator.routeInformationUpdated(
        uri: Uri(path: "/catalog/category"),
      );
    } else {
      selectedCategory = widget.selectedId!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double headerHeight = (categorySelection.isNotEmpty &&
            categorySelection.last.subLeaves != null)
        ? 72 + categorySelection.length * 48
        : max(72 + (categorySelection.length - 1) * 48, 72);
    return Stack(
      children: [
        Positioned(
          top: 12,
          right: 12,
          child: IconButton(
            onPressed: () {
              showPopupWindow(
                context,
                childFun: (pop) {
                  return EditCategoryStructurePopup(
                    key: GlobalKey(),
                    pop: pop,
                  );
                },
              );
            },
            iconSize: 24,
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            icon: const Icon(Icons.edit_rounded),
          ),
        ),
        SizedBox(
          height: headerHeight,
          child: Stack(
            children: List.generate(
              (categorySelection.isEmpty ||
                      categorySelection.last.subLeaves != null)
                  ? categorySelection.length + 1
                  : categorySelection.length,
              (index) {
                if (categorySelection.isEmpty || index == 0) {
                  return TopCategoryRow(
                    onPressed: (int rowIndex) {
                      selectedCategory =
                          widget.categoryTree.leaves[rowIndex].id;
                      if (index < categorySelection.length) {
                        categorySelection[index] =
                            widget.categoryTree.leaves[rowIndex];
                        categorySelection =
                            categorySelection.sublist(0, index + 1);
                      } else {
                        categorySelection
                            .add(widget.categoryTree.leaves[rowIndex]);
                      }

                      updateUri();

                      setState(() {});
                    },
                    categoryTree: widget.categoryTree,
                    categorySelection: categorySelection,
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(top: 72 + (index - 1) * 48),
                  child: SubCategoryRow(
                    onPressed: (int rowIndex) {
                      selectedCategory =
                          categorySelection[index - 1].subLeaves![rowIndex].id;
                      if (index < categorySelection.length) {
                        categorySelection[index] =
                            categorySelection[index - 1].subLeaves![rowIndex];
                        categorySelection =
                            categorySelection.sublist(0, index + 1);
                      } else {
                        categorySelection.add(
                            categorySelection[index - 1].subLeaves![rowIndex]);
                      }

                      updateUri();

                      setState(() {});
                    },
                    previousLeaf: categorySelection[index - 1],
                    currentSelectedCategoryLeaf:
                        categorySelection.length >= index + 1
                            ? categorySelection[index]
                            : null,
                  ),
                );
              },
            ).reversed.toList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: headerHeight),
          child: CategoryEdit(categorySelection: categorySelection),
        ),
      ].reversed.toList(),
    );
  }
}
