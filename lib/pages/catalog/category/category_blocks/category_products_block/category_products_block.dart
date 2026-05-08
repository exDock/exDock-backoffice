// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/category/category_blocks/category_products_block/category_products_grid.dart';
import 'package:exdock_backoffice/utils/blocks/group_cards/category_edit_group_card.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class CategoryProductsBlock extends StatefulWidget {
  const CategoryProductsBlock({
    super.key,
    required this.currentProducts,
    required this.changeAttributeMap,
  });

  final List<int> currentProducts;
  final MapNotifier changeAttributeMap;

  @override
  State<CategoryProductsBlock> createState() => _CategoryProductsBlockState();
}

class _CategoryProductsBlockState extends State<CategoryProductsBlock> {
  late final ValueNotifier<bool> unsavedChangesNotifier =
      ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    widget.changeAttributeMap.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CategoryEditGroupCard(
      unsavedChangesNotifier: unsavedChangesNotifier,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Products",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Text("TODO: search"),
            ],
          ),
          const SizedBox(height: 24),
          CategoryProductsGrid(
            categoryProducts: widget.currentProducts,
            changeAttributeMap: widget.changeAttributeMap,
            unsavedChangesNotifier: unsavedChangesNotifier,
          ),
        ],
      ),
    );
  }
}
