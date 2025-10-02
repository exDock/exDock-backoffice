import 'dart:convert';

import 'package:exdock_backoffice/pages/content/templates/page_info/page_info_synchronous.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/HTTP/post_requests.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:flutter/material.dart';

class PageInfo extends StatefulWidget {
  const PageInfo({
    super.key,
    required this.url,
    required this.isNewPage,
  });

  final String url;
  final bool isNewPage;

  @override
  State<PageInfo> createState() => _PageInfoState();
}

class _PageInfoState extends State<PageInfo> {
  Future<Map<String, dynamic>> getJsonPageData(
      String url, bool isNewPage) async {
    final Map<String, dynamic> body = {
      "page_name": "page_info",
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
            return PageInfoSynchronous(
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
