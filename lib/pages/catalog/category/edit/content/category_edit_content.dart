// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/category/category_data.dart';
import 'package:exdock_backoffice/pages/catalog/category/edit/content/category_edit_content_synchronous.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class CategoryEditContent extends StatefulWidget {
  const CategoryEditContent({
    super.key,
    required this.selectedCategoryLeaf,
    required this.changeAttributeMap,
  });

  final CategoryLeaf selectedCategoryLeaf;
  final MapNotifier changeAttributeMap;

  @override
  State<CategoryEditContent> createState() => _CategoryEditContentState();
}

class _CategoryEditContentState extends State<CategoryEditContent> {
  Future<Map<String, dynamic>> getCategoryAttributes(int categoryId) async {
    return {
      "Content": {
        "block_type": "standard",
        "attributes": [
          {
            "attribute_id": "main_image",
            "attribute_name": "Main image",
            "attribute_type": "image",
            "current_attribute_value": {
              "main": "https://picsum.photos/200/1000", // nullable
              "mobile": null,
              "tablet": null,
            },
          },
          {
            "attribute_id": "short_description",
            "attribute_name": "Short description",
            "attribute_type": "wysiwyg",
            "current_attribute_value": "test short description value",
          },
          {
            "attribute_id": "description",
            "attribute_name": "Description",
            "attribute_type": "wysiwyg",
            "current_attribute_value": "test description value",
          },
        ],
      },
      "Search Engine Optimisation": {
        "block_type": "standard",
        "attributes": [
          {
            "attribute_id": "url_key",
            "attribute_name": "URL key",
            "attribute_type": "text",
            "current_attribute_value": "",
          },
        ],
      },
      "Products": {
        "block_type": "category_products",
        "current_products": [1, 3, 5, 7, 8, 9, 14],
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCategoryAttributes(widget.selectedCategoryLeaf.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Placeholder();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return CategoryEditContentSynchronous(
            blocks: snapshot.data!,
            changeAttributeMap: widget.changeAttributeMap,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
