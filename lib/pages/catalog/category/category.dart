// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/category/category_data.dart';
import 'package:exdock_backoffice/pages/catalog/category/category_synchronous.dart';

class Category extends StatelessWidget {
  const Category({super.key, this.selectedCategory});

  final int? selectedCategory;

  Future<CategoryTree> getCategoryTree() async {
    return CategoryTree([
      CategoryLeaf(1, "Root 1"),
      CategoryLeaf(
        2,
        "Root 2",
        subLeaves: [
          CategoryLeaf(4, "subLeave 2-1"),
          CategoryLeaf(5, "subLeave 2-2"),
          CategoryLeaf(6, "subLeave 2-3"),
        ],
      ),
      CategoryLeaf(
        3,
        "Root 3",
        subLeaves: [
          CategoryLeaf(7, "subLeave 3-1"),
          CategoryLeaf(
            8,
            "subLeave 3-2",
            subLeaves: [
              CategoryLeaf(10, "subLeave 3-2-1"),
            ],
          ),
          CategoryLeaf(9, "subLeave 3-3"),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategoryTree(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return CategorySynchronous(
            categoryTree: snapshot.data!,
            selectedId: selectedCategory,
          );
        }
        if (snapshot.hasError) {
          //
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
