// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/styling.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    super.key,
    required this.categories,
  });

  final List<String> categories;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Widget> categoryWidgets = [];

  @override
  Widget build(BuildContext context) {
    categoryWidgets = [];

    for (final String categoryName in widget.categories) {
      categoryWidgets.add(Container(
        constraints: const BoxConstraints(
          maxWidth: 125,
        ),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: lightKBoxShadowList,
          color: Colors.white,
        ),
        child: Row(
          children: [
            Text(categoryName),
            const Icon(Icons.close),
          ],
        ),
      ));
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: lightKBoxShadowList,
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.category_outlined),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text("Categories"),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Wrap(
            spacing: 10,
            runSpacing: 5,
            direction: Axis.horizontal,
            children: categoryWidgets,
          ),
        ],
      ),
    );
  }
}
