import 'dart:convert';

import 'package:exdock_backoffice/pages/content/pages/page_info/blocks/template_card/template_card_title.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/HTTP/post_requests.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:exdock_backoffice/widgets/buttons/exdock_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class TemplatePreview extends StatefulWidget {
  const TemplatePreview({
    super.key,
    required this.data,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> data;
  final MapNotifier changeAttributeMap;

  @override
  State<TemplatePreview> createState() => _TemplatePreviewState();
}

class _TemplatePreviewState extends State<TemplatePreview> {
  Future<String> fetchPreview() async {
    final List<String> ids = [
      "Product ID",
      "Category ID",
      "Credit memo ID",
      "Invoice ID",
      "Order ID",
      "Shipment ID",
      "Transaction ID",
      "Block Name"
    ];
    final Map<String, dynamic> body = {
      "templateData": widget.changeAttributeMap.value["template_data"] ?? "",
    };

    for (final id in ids) {
      if (widget.changeAttributeMap.value.containsKey(id)) {
        String newKey = id.toLowerCase();
        newKey = newKey.replaceAll(" ", "");
        newKey = newKey.replaceAll("id", "Id");
        newKey = newKey.replaceAll("blockname", "block_name");

        body[newKey] = widget.changeAttributeMap.value[id];
      }
    }

    final HttpData httpData = await standardPostRequest(
      "/api/v1/template/generate",
      jsonEncode(body),
    );

    return httpData.responseBody ?? "Error fetching preview";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchPreview(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Placeholder(
            child: Text("Error loading preview"),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == "Internal Server Error") {
            return TemplateCardTitle(
              button: ExdockButton(
                label: "load preview",
                onPressed: () {
                  setState(() {});
                },
              ),
              title: "Preview",
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 120,
                child: Center(
                  child: Text(
                    "Error generating preview.\nPlease check your template syntax and IDs.",
                    style: TextStyle(color: Colors.red[700]),
                  ),
                ),
              ),
            );
          }
          return TemplateCardTitle(
            button: ExdockButton(
              label: "load preview",
              onPressed: () {
                setState(() {});
              },
            ),
            title: "Preview",
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 120,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  color: Colors.grey[200],
                  child: Html(
                    data: snapshot.data ?? "",
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
