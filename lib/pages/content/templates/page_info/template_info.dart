// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:exdock_backoffice/pages/content/templates/page_info/template_info_synchronous.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/HTTP/post_requests.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
// Flutter imports:
import 'package:flutter/material.dart';

class TemplateInfo extends StatefulWidget {
  const TemplateInfo({
    super.key,
    required this.url,
    required this.isNewPage,
  });

  final String url;
  final bool isNewPage;

  @override
  State<TemplateInfo> createState() => _PageInfoState();
}

class _PageInfoState extends State<TemplateInfo> {
  Future<Map<String, dynamic>> getJsonPageData(
      String url, bool isNewPage) async {
    final Map<String, dynamic> body = {
      "page_name": "template_info",
    };

    if (!isNewPage) {
      body["address_names"] = [
        {"address": "template", "id": "/$url"}
      ];
    } else {
      body["address_names"] = [];
    }

    final HttpData httpData = await standardPostRequest(
      "/api/v1/getBlockData",
      jsonEncode(body),
    );

    return jsonDecode(httpData.responseBody!) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getJsonPageData(widget.url, widget.isNewPage),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Placeholder();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!;
            return TemplateInfoSynchronous(
              url: widget.url,
              blocks: data,
              changeAttributeMap: MapNotifier(),
              isNewTemplate: widget.isNewPage,
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
