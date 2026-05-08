// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/catalog/product/info/product_info_card/product_info_card_title.dart';
import 'package:exdock_backoffice/utils/attributes/generate_attribute.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class StandardBlock extends StatefulWidget {
  const StandardBlock({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  @override
  State<StandardBlock> createState() => _StandardBlockState();
}

class _StandardBlockState extends State<StandardBlock> {
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
    widget.changeAttributeMap.addListener(() {
      unsavedChangesNotifier.value = widget.changeAttributeMap.attributeChanged(
        getAttributesList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProductInfoCardTitle(
      title: widget.block.key,
      unsavedChangesNotifier: unsavedChangesNotifier,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.block.value['attributes'].length,
        itemBuilder: (context, index) {
          Widget child = GenerateAttribute(
            attribute: widget.block.value['attributes'][index],
            changeAttributeMap: widget.changeAttributeMap,
          );
          if (index != 0) {
            child = Padding(
              padding: const EdgeInsets.only(top: 24),
              child: child,
            );
          }
          return child;
        },
      ),
    );
  }
}
