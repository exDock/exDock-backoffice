// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_html/flutter_html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Project imports:
import 'package:exdock_backoffice/pages/content/pages/page_info/blocks/page_block/page_tree.dart';
import 'package:exdock_backoffice/utils/HTTP/connect_websocket_stream.dart';
import 'package:exdock_backoffice/utils/authentication/authentication_data.dart';

class PagePreview extends StatefulWidget {
  const PagePreview({
    super.key,
    required this.templateIds,
  });

  final List<String> templateIds;

  @override
  State<PagePreview> createState() => _PagePreviewState();
}

class _PagePreviewState extends State<PagePreview> {
  final String _previewData = "Initial Preview Data";
  ValueNotifier<String>? _previewNotifier;
  late Future<WebSocketChannel> _channel;

  void handleWsData(ValueNotifier values, Map<String, dynamic> data) {
    if (data.containsKey("type") && data["type"] == "pagePreview") {
      final String previewData = data["previewCode"];
      values.value = previewData;
    }
  }

  @override
  void initState() {
    _previewNotifier = ValueNotifier<String>(_previewData);

    try {
      const String baseUrl = "http://127.0.0.1:9001";
      final Uri uri = Uri.parse("$baseUrl/page/preview");
      _channel = getWebsocketChannel(
        uri.convertToWs(),
        _previewNotifier!,
        handleWsData,
      );
    } catch (e) {
      if (e is NotAuthenticatedException) {
        throw NotAuthenticatedException("");
      }
      throw Exception("Error parsing URI: $e");
    }
    super.initState();
  }

  @override
  void dispose() {
    _previewNotifier?.dispose();
    _channel.then((channel) => channel.sink.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SendPreviewData data = SendPreviewData(
      templateIds: widget.templateIds,
      productId: "",
      categoryId: "",
      creditMemoId: "",
      invoiceId: "",
      orderId: "",
      shipmentId: "",
      transactionId: "",
    );

    _channel.then((channel) {
      channel.sink.add(data.toJson());
    });

    return ValueListenableBuilder(
      valueListenable: _previewNotifier!,
      builder: (BuildContext context, value, Widget? child) {
        return SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 100,
            child: Html(
              data: value,
            ),
          ),
        );
      },
    );
  }
}
