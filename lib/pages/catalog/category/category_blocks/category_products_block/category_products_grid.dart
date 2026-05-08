// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:collection/collection.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/pages/catalog/category/category_blocks/category_products_block/category_product_card/category_product_card.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class CategoryProductsGrid extends StatefulWidget {
  const CategoryProductsGrid({
    super.key,
    required this.categoryProducts,
    required this.changeAttributeMap,
    required this.unsavedChangesNotifier,
  });

  final List<int> categoryProducts;
  final MapNotifier changeAttributeMap;
  final ValueNotifier<bool> unsavedChangesNotifier;

  @override
  State<CategoryProductsGrid> createState() => _CategoryProductsGridState();
}

class _CategoryProductsGridState extends State<CategoryProductsGrid> {
  final attributeName = "category_products";
  late List<int> _localProducts;
  final double productCardWidth = 150;

  @override
  void initState() {
    super.initState();
    _localProducts = List.from(widget.categoryProducts);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final int columnCount =
              (constraints.maxWidth / (productCardWidth + 12)).floor();
          final double spacing =
              (constraints.maxWidth / columnCount - productCardWidth) /
                  columnCount *
                  (columnCount + 1);

          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: List.generate(
              _localProducts.length,
              (index) => DragTarget<int>(
                onAcceptWithDetails: (draggedIndex) {
                  // move logic
                  setState(() {
                    final draggedItem = _localProducts[draggedIndex.data];
                    _localProducts.removeAt(draggedIndex.data);
                    _localProducts.insert(index, draggedItem);
                  });

                  // detect if there is change
                  if (!const ListEquality()
                      .equals(widget.categoryProducts, _localProducts)) {
                    widget.changeAttributeMap.addEntry(
                      attributeName,
                      _localProducts,
                    );

                    if (!widget.unsavedChangesNotifier.value) {
                      widget.unsavedChangesNotifier.value = true;
                    }
                  } else {
                    widget.changeAttributeMap.removeEntry(attributeName);
                    widget.unsavedChangesNotifier.value = false;
                  }
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: kBoxShadowList,
                    ),
                    child: Stack(
                      children: [
                        // The non-draggable product card
                        CategoryProductCard(
                          width: productCardWidth,
                          id: _localProducts[index],
                        ),
                        // The draggable handle
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Draggable<int>(
                            data: index,
                            feedback: Material(
                              borderRadius: BorderRadius.circular(10),
                              clipBehavior: Clip.hardEdge,
                              color: Colors.transparent,
                              elevation: 4.0,
                              child: SizedBox(
                                width: productCardWidth,
                                child: CategoryProductCard(
                                  id: _localProducts[index],
                                  // height: productCardHeight,
                                  width: productCardWidth,
                                ),
                              ),
                            ),
                            child: MouseRegion(
                              cursor: SystemMouseCursors.grab,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  boxShadow: kBoxShadowList,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.drag_indicator,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
