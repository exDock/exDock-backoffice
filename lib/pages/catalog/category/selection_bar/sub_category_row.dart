// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/pages/catalog/category/category_data.dart';

class SubCategoryRow extends StatelessWidget {
  const SubCategoryRow({
    super.key,
    required this.onPressed,
    required this.previousLeaf,
    this.currentSelectedCategoryLeaf,
  });

  final Function(int) onPressed;
  final CategoryLeaf previousLeaf;
  final CategoryLeaf? currentSelectedCategoryLeaf;

  static final ButtonStyle subCategoryRowButtonStyle = ButtonStyle(
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: kBoxShadowList,
      ),
      child: Row(
        children: [
          const Flexible(
            child: SizedBox(width: double.infinity),
          ),
          Flexible(
            flex: 4,
            child: Row(
              mainAxisAlignment: previousLeaf.subLeaves!.length > 1
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              children: List<Widget>.generate(
                previousLeaf.subLeaves!.length,
                (rowIndex) {
                  return TextButton(
                    onPressed: () {
                      onPressed(rowIndex);
                    },
                    style: subCategoryRowButtonStyle,
                    child: Text(
                      previousLeaf.subLeaves![rowIndex].name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: currentSelectedCategoryLeaf != null &&
                                    previousLeaf.subLeaves![rowIndex].id ==
                                        currentSelectedCategoryLeaf!.id
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                    ),
                  );
                },
              ),
            ),
          ),
          const Flexible(
            child: SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
