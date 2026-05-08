// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dropdown_button2/dropdown_button2.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/utils/attributes/dropdown/case_sensitive_icon_button.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class DropdownAttribute extends StatefulWidget {
  const DropdownAttribute({
    super.key,
    required this.attribute,
    required this.changeAttributeMap,
  });

  final Map<String, dynamic> attribute;
  final MapNotifier changeAttributeMap;

  @override
  State<DropdownAttribute> createState() => _DropdownAttributeState();
}

class _DropdownAttributeState extends State<DropdownAttribute> {
  final TextEditingController searchTextEditingController =
      TextEditingController();
  late String? currentValue = widget.attribute['current_attribute_value'];
  bool caseSensitiveSearch = false;
  WidgetStateProperty<Color>? caseSensitiveButtonColour;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> items = List.from(
      widget.attribute['possible_values'].map(
        (Map<String, String> value) {
          return DropdownMenuItem<String>(
            value: value['value'],
            child: Text(value['label'] ?? value['value'] ?? '-'),
          );
        },
      ),
    );

    return Row(
      children: [
        Text(widget.attribute['attribute_name']),
        const SizedBox(width: 24),
        Card(
          clipBehavior: Clip.hardEdge,
          elevation: 4,
          color: Theme.of(context).cardColor,
          child: DropdownButton2<String>(
            onChanged: (value) {
              widget.changeAttributeMap.updateAttributeEntry(
                widget.attribute,
                value,
              );
              setState(() {
                currentValue = value;
              });
            },
            value: currentValue,
            items: items,
            underline: const SizedBox(),
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8, left: 4),
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              offset: const Offset(0, -4),
              maxHeight: 300,
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: searchTextEditingController,
              searchInnerWidgetHeight: 64,
              searchInnerWidget: Container(
                height: 64,
                padding: const EdgeInsets.all(12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: darkColour,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchTextEditingController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            hintText: "search",
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      CaseSensitiveIconButton(onChanged: (newValue) {
                        setState(() {
                          caseSensitiveSearch = newValue;

                          // The text needs to be changed in order to trigger the search functionality
                          // Add a space, because you cannot see the space
                          searchTextEditingController.text =
                              "${searchTextEditingController.text} ";

                          searchTextEditingController.text =
                              searchTextEditingController.text.substring(
                            0,
                            searchTextEditingController.text.length - 1,
                          );
                        });
                      }),
                    ],
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                if (!caseSensitiveSearch) {
                  searchValue = searchValue.toLowerCase();
                }

                // Compares against the value
                if (item.value.toString().contains(searchValue)) return true;

                // Compares against the label
                String? labelText = (item.child as Text).data;
                if (!caseSensitiveSearch) labelText = labelText?.toLowerCase();
                if (labelText?.contains(searchValue) ?? false) return true;

                return false;
              },
            ),
            // This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                searchTextEditingController.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}
