import 'package:exdock_backoffice/pages/content/pages/page_info/blocks/page_card/page_card_title.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/exdock_card.dart';
import 'package:exdock_backoffice/widgets/exdock_switch.dart';
import 'package:exdock_backoffice/widgets/input/exdock_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PageVariables extends StatelessWidget {
  const PageVariables({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  @override
  Widget build(BuildContext context) {
    final names = [
      "URL",
      "Upper Key",
      "Product ID",
      "Category ID",
      "Credit memo ID",
      "Invoice ID",
      "Order ID",
      "Shipment ID",
      "Transaction ID",
      "List ID",
    ];
    final List<TextEditingController> mainControllers = [];
    final List<dynamic> attributes = block.value["attributes"];
    final List<Map<String, dynamic>> attributeList =
        List<Map<String, dynamic>>.from(attributes);

    for (final name in names) {
      final controller = TextEditingController();
      for (final entry in attributeList) {
        if (entry["attribute_id"] == name) {
          controller.text = entry["current_attribute_value"] ?? "";
        }
      }
      if (name == "URL") {
        controller.text = attributeList[0]["current_attribute_value"] ?? "";
      }
      mainControllers.add(controller);
    }

    return PageCardTitle(
      title: block.key.replaceAll("_", " "),
      child: MasonryGridView.count(
        padding: const EdgeInsets.all(24),
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
        shrinkWrap: true,
        crossAxisCount: 2,
        itemCount: names.length,
        itemBuilder: (content, index) {
          if (index == 0 || index == 1) {
            return ExdockTextField(
              labelText: names[index],
              controller: mainControllers[index],
              onChanged: (s) {
                String? oldValue = changeAttributeMap.value[names[index]];
                oldValue ??= "";
                changeAttributeMap.updateEntry(names[index], oldValue, s);
              },
            );
          }

          return ExdockCard(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 24),
                  child: Text(
                    names[index],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  child: ExDockSwitch(
                    isLong: true,
                    value: (changeAttributeMap.value[names[index]] ?? "") != "",
                    onChanged: (val) {
                      final oldValue =
                          changeAttributeMap.value["required_parameters"] ?? [];
                      final List<String>? params =
                          changeAttributeMap.value["required_parameters"];
                      if (params != null) {
                        if (val) {
                          params.add(names[index]);
                        } else {
                          params.remove(names[index]);
                        }
                        changeAttributeMap.updateEntry(
                          "required_parameters",
                          oldValue,
                          params,
                        );
                      } else {
                        if (val) {
                          changeAttributeMap.updateEntry(
                            "required_parameters",
                            oldValue,
                            [names[index]],
                          );
                        } else {
                          changeAttributeMap.updateEntry(
                            "required_parameters",
                            oldValue,
                            [],
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
