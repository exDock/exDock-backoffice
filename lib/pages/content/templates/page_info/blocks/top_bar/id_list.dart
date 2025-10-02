import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/buttons/exdock_button.dart';
import 'package:exdock_backoffice/widgets/input/exdock_text_field.dart';
import 'package:exdock_backoffice/widgets/popup/exdock_big_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class IdList extends StatefulWidget {
  const IdList({
    super.key,
    required this.saveNotifier,
  });

  final MapNotifier saveNotifier;

  @override
  State<IdList> createState() => _IdListState();
}

class _IdListState extends State<IdList> {
  List<String> ids = [
    "Product ID",
    "Category ID",
    "Credit memo ID",
    "Invoice ID",
    "Order ID",
    "Shipment ID",
    "Transaction ID",
  ];
  List<String> names = [
    "Key",
    "Block Name",
  ];

  List<TextEditingController> controllers = [];
  List<TextEditingController> mainControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    for (final _ in ids) {
      controllers.add(TextEditingController());
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ExdockButton(
        label: "Set Variables",
        onPressed: () {
          showPopupWindow(
            context,
            childFun: (pop) {
              return ExdockBigPopup(
                key: GlobalKey(),
                pop: pop,
                title: "Template IDs",
                child: Column(
                  children: [
                    MasonryGridView.count(
                      padding: const EdgeInsets.all(24),
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      itemCount: 2,
                      itemBuilder: (content, index) {
                        return ExdockTextField(
                          labelText: names[index],
                          controller: mainControllers[index],
                          onChanged: (s) {
                            widget.saveNotifier.value[names[index]] = s;
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(
                        color: Theme.of(context).primaryColor,
                        thickness: 2,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    MasonryGridView.count(
                      padding: const EdgeInsets.all(24),
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      itemCount: ids.length,
                      itemBuilder: (content, index) {
                        return ExdockTextField(
                          labelText: ids[index],
                          controller: controllers[index],
                          onChanged: (s) {
                            widget.saveNotifier.value[ids[index]] = s;
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
