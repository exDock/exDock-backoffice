// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

// Project imports:
import 'package:exdock_backoffice/utils/attributes/images/single_image_attribute_popup.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class SingleImageAttribute extends StatefulWidget {
  const SingleImageAttribute(
      {super.key, required this.attribute, required this.changeAttributeMap});

  /// "[image]" attribute
  ///
  /// value: [Map<String, String?>] {
  /// - "[main]": "https://example.com/path",
  /// - "[mobile]": "https://example.com/path",
  /// - "[tablet]": "https://example.com/path",
  ///
  /// }
  ///
  /// If [mobile] or [tablet] are [null], they will fall back on [main].
  /// [main] can also be [null]
  final Map<String, dynamic> attribute;
  final MapNotifier changeAttributeMap;

  @override
  State<SingleImageAttribute> createState() => _SingleImageAttributeState();
}

class _SingleImageAttributeState extends State<SingleImageAttribute> {
  String currentDevice = "main";
  late final currentAttributeValue =
      widget.attribute["current_attribute_value"];
  late final _localAttributeValue = Map<String, dynamic>.from(
    widget.attribute["current_attribute_value"],
  );

  void _changeDevice(String device) {
    setState(() {
      currentDevice = device;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleImageDeviceTypeSelector(
                name: "main",
                onPressed: () {
                  _changeDevice("main");
                },
              ),
              SingleImageDeviceTypeSelector(
                name: "mobile",
                onPressed: () {
                  _changeDevice("mobile");
                },
              ),
              SingleImageDeviceTypeSelector(
                name: "tablet",
                onPressed: () {
                  _changeDevice("tablet");
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Container(
              width: 1,
              decoration: BoxDecoration(color: Theme.of(context).disabledColor),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                showPopupWindow(
                  context,
                  childFun: (pop) {
                    return SingleImageAttributePopup(
                      key: GlobalKey(),
                      pop: pop,
                      scope: currentDevice,
                      currentImage: _localAttributeValue[currentDevice],
                      onNewImage: (newImage) {
                        _localAttributeValue[currentDevice] = newImage;

                        if (_localAttributeValue['main'] ==
                                currentAttributeValue['main'] &&
                            _localAttributeValue['tablet'] ==
                                currentAttributeValue['tablet'] &&
                            _localAttributeValue['mobile'] ==
                                currentAttributeValue['mobile']) {
                          // Attribute has not changed
                          widget.changeAttributeMap.removeEntry(
                            widget.attribute['attribute_id'],
                          );
                        } else {
                          // Attribute has changed
                          widget.changeAttributeMap.addEntry(
                            widget.attribute['attribute_id'],
                            _localAttributeValue,
                          );
                        }

                        pop.dismiss(context);
                      },
                    );
                  },
                );
              },
              child: _localAttributeValue[currentDevice] != null
                  ? ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 500),
                      child: Image.network(_localAttributeValue[currentDevice]),
                    )
                  : const NoImagePresent(),
            ),
          ),
        ],
      ),
    );
  }
}

class NoImagePresent extends StatelessWidget {
  const NoImagePresent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DottedDecoration(
        shape: Shape.box,
        borderRadius: BorderRadius.circular(5),
        dash: const [10, 10],
        strokeWidth: 2,
        color: Theme.of(context).disabledColor,
      ),
      child: const SizedBox(
        height: 100,
        child: Center(
          child: Text("no image uploaded"),
        ),
      ),
    );
  }
}

class SingleImageDeviceTypeSelector extends StatelessWidget {
  const SingleImageDeviceTypeSelector({
    super.key,
    required this.name,
    required this.onPressed,
  });

  final String name;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        textStyle:
            WidgetStatePropertyAll(Theme.of(context).textTheme.bodyMedium),
        foregroundColor: WidgetStatePropertyAll(
            Theme.of(context).textTheme.bodyMedium?.color),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      child: Text(name),
    );
  }
}
