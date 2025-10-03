// Flutter imports:ck_backoffice/pages/catalog/product/info/id_data/category_list.dart';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/product/info/id_data/category_list.dart';
import 'package:exdock_backoffice/pages/catalog/product/info/product_info_card/product_info_card_title.dart';
import 'package:exdock_backoffice/utils/attributes/generate_attribute.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class IdDataBlock extends StatefulWidget {
  const IdDataBlock({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  @override
  State<IdDataBlock> createState() => _IdDataBlockState();
}

class _IdDataBlockState extends State<IdDataBlock> {
  late final ValueNotifier<bool> unsavedChangesNotifier =
      ValueNotifier<bool>(false);

  List<String> getAttributesList() {
    return List<String>.from(
      widget.block.value['attributes'].map((e) => e["attribute_id"]).toList(),
    );
  }

  @override
  void initState() {
    super.initState();

    widget.changeAttributeMap.addListener(
      () {
        unsavedChangesNotifier.value =
            widget.changeAttributeMap.attributeChanged(
          getAttributesList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> attributes = widget.block.value['attributes'];
    final Map<String, dynamic> categories = attributes.firstWhere(
      (element) => element['attribute_id'] == "product_categories",
      orElse: () => {},
    );
    final List<dynamic> categoryNamesDynamic =
        categories["current_attribute_value"] as List<dynamic>;
    final List<String> categoryNames = categoryNamesDynamic.map((_element) {
      return _element as String;
    }).toList();

    return ProductInfoCardTitle(
      title: widget.block.key,
      unsavedChangesNotifier: unsavedChangesNotifier,
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.block.value['attributes'].length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> currentAttribute =
                  widget.block.value['attributes'][index];
              if (currentAttribute['attribute_id'] != "product_categories") {
                Widget child = GenerateAttribute(
                  attribute: currentAttribute,
                  changeAttributeMap: widget.changeAttributeMap,
                );
                if (index != 0) {
                  child = Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: child,
                  );
                }
                return child;
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: CategoryList(categories: categoryNames),
          )
        ],
      ),
    );
  }
}
