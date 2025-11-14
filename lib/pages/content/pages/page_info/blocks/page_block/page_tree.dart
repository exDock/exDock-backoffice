import 'dart:async';
import 'dart:convert';

import 'package:exdock_backoffice/pages/content/pages/page_info/blocks/page_block/page_tree_item.dart';
import 'package:exdock_backoffice/pages/content/pages/page_info/blocks/page_card/page_card_title.dart';
import 'package:exdock_backoffice/utils/HTTP/connect_websocket_stream.dart';
import 'package:exdock_backoffice/utils/authentication/authentication_data.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/buttons/exdock_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PageTree extends StatefulWidget {
  const PageTree({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  @override
  State<PageTree> createState() => _PageTreeState();
}

class _PageTreeState extends State<PageTree> {
  List<String> _templatesList = [];
  List<String> _oldTemplatesList = [];
  ValueNotifier<String>? _temp;
  late Future<WebSocketChannel>? _channel;
  Timer? _debounceTimer;

  void sendNewPreviewData() {
    final String productId =
        widget.changeAttributeMap.value["Product ID"] ?? "";
    final String categoryId =
        widget.changeAttributeMap.value["Category ID"] ?? "";
    final String creditMemoId =
        widget.changeAttributeMap.value["Credit memo ID"] ?? "";
    final String invoiceId =
        widget.changeAttributeMap.value["Invoice ID"] ?? "";
    final String orderId = widget.changeAttributeMap.value["Order ID"] ?? "";
    final String shipmentId =
        widget.changeAttributeMap.value["Shipment ID"] ?? "";
    final String transactionId =
        widget.changeAttributeMap.value["Transaction ID"] ?? "";

    final SendPreviewData data = SendPreviewData(
      templateIds: _templatesList,
      productId: productId,
      categoryId: categoryId,
      creditMemoId: creditMemoId,
      invoiceId: invoiceId,
      orderId: orderId,
      shipmentId: shipmentId,
      transactionId: transactionId,
    );

    _channel?.then((channel) {
      channel.sink.add(data.toJson());
    });
  }

  void handleWsData(ValueNotifier values, Map<String, dynamic> data) {
    // Handle WebSocket data if needed
  }

  void _handleTreeChange() {
    _oldTemplatesList = List<String>.from(_templatesList);

    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(seconds: 1), () {
      sendNewPreviewData();
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      final String item = _templatesList.removeAt(oldIndex);
      _templatesList.insert(newIndex, item);
      _handleTreeChange();
    });
  }

  void _connectWebSocket() {
    try {
      const String baseUrl = "http://127.0.0.1:9001";
      final Uri uri = Uri.parse("$baseUrl/page/preview");
      _channel = getWebsocketChannel(
        uri.convertToWs(),
        _temp!,
        handleWsData,
      );
    } catch (e) {
      if (e is NotAuthenticatedException) {
        throw NotAuthenticatedException("");
      }
      throw Exception("Error parsing URI: $e");
    }
  }

  @override
  void initState() {
    final List<dynamic>? templates =
        widget.block.value["attributes"][0]["current_attribute_value"];
    if (templates == null) {
      _templatesList = [];
    } else {
      _templatesList = List<String>.from(templates);
    }
    _temp = ValueNotifier<String>("");
    widget.changeAttributeMap.addListener(_handleTreeChange);

    super.initState();
  }

  @override
  void dispose() {
    _temp?.dispose();
    _channel?.then((channel) => channel.sink.close());
    _debounceTimer?.cancel();
    widget.changeAttributeMap.removeListener(_handleTreeChange);

    super.dispose();
  }

  void updateTemplatesCallback(
    List<String> oldTemplates,
    List<String> updatedTemplates,
  ) {
    widget.changeAttributeMap
        .updateEntry("templates", oldTemplates, updatedTemplates);
    setState(() {
      _templatesList = updatedTemplates;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageCardTitle(
      middleButton: ExdockButton(
          label: "add template",
          onPressed: () {
            setState(() {
              _templatesList.add("new_template");
              _handleTreeChange();
            });
          }),
      button: ExdockButton(
        label: "load preview",
        onPressed: () async {
          final List<String> url = Uri.base.toString().split("/");
          String finalUrl = "";

          for (int i = 0; i < url.length - 2; i++) {
            finalUrl += "${url[i]}/";
          }
          finalUrl += "page_preview?templateIds=${_templatesList.join(";")}";
          _connectWebSocket();

          if (!await launchUrl(
            Uri.parse(finalUrl),
            webOnlyWindowName: "_blank",
          )) {
            throw Exception('Could not launch URL');
          }
        },
      ),
      title: widget.block.key.toString().replaceAll("_", " "),
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 325,
        child: ReorderableListView(
          onReorder: _onReorder,
          children: <Widget>[
            for (int index = 0; index < _templatesList.length; index++)
              PageTreeItem(
                key: Key('$index'),
                templateName: _templatesList[index],
                changeAttributeMap: widget.changeAttributeMap,
                templates: _templatesList,
                updateTemplatesCallback: updateTemplatesCallback,
              ),
          ],
        ),
      ),
    );
  }
}

class SendPreviewData {
  SendPreviewData({
    required this.templateIds,
    required this.productId,
    required this.categoryId,
    required this.creditMemoId,
    required this.invoiceId,
    required this.orderId,
    required this.shipmentId,
    required this.transactionId,
  });

  final List<String> templateIds;
  final String productId;
  final String categoryId;
  final String creditMemoId;
  final String invoiceId;
  final String orderId;
  final String shipmentId;
  final String transactionId;

  String toJson() {
    final Map<String, dynamic> data = {
      "templateIds": templateIds,
      "productId": productId,
      "categoryId": categoryId,
      "creditMemoId": creditMemoId,
      "invoiceId": invoiceId,
      "orderId": orderId,
      "shipmentId": shipmentId,
      "transactionId": transactionId,
    };
    return jsonEncode(data);
  }
}
