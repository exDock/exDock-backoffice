import 'dart:convert';

import 'package:exdock_backoffice/pages/catalog/product/info/top_bar/top_bar.dart';
import 'package:exdock_backoffice/pages/content/pages/page_info/blocks/generate_block.dart';
import 'package:exdock_backoffice/pages/content/pages/page_info/blocks/page_info_block.dart';
import 'package:exdock_backoffice/router/router.dart';
import 'package:exdock_backoffice/utils/HTTP/post_requests.dart';
import 'package:exdock_backoffice/utils/HTTP/put_requests.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:flutter/material.dart';

class PageInfoSynchronous extends StatelessWidget {
  const PageInfoSynchronous({
    super.key,
    required this.url,
    required this.blocks,
    required this.changeAttributeMap,
    this.isNewPage = false,
  });

  final String url;
  final Map<String, dynamic> blocks;
  final MapNotifier changeAttributeMap;
  final bool isNewPage;

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, dynamic>> blocksEntriesList =
        blocks.entries.toList();

    saveValues() async {
      final Map<String, dynamic> body = {
        "_id": changeAttributeMap.value["URL"],
      };

      if (changeAttributeMap.value.containsKey("Upper Key")) {
        body["upper_key"] = changeAttributeMap.value["Upper Key"];
      } else {
        body["upper_key"] = "";
      }

      if (changeAttributeMap.value.containsKey("required_parameters")) {
        final List<String> params =
            changeAttributeMap.value["required_parameters"];
        final List<String> formattedParams = [];

        for (String param in params) {
          param = param.trim().toLowerCase();
          final List<String> splitParam = param.split(" ");
          for (int i = 1; i < splitParam.length; i++) {
            splitParam[i] =
                "${splitParam[i][0].toUpperCase()}${splitParam[i].substring(1)}";
          }
          final String formattedParam = splitParam.join();
          formattedParams.add(formattedParam);
        }

        body["required_parameters"] = formattedParams;
      } else {
        body["required_parameters"] = [];
      }

      if (changeAttributeMap.value.containsKey("templates")) {
        body["templates"] = changeAttributeMap.value["templates"];
      } else {
        body["templates"] = [];
      }

      if (isNewPage) {
        await standardPostRequest(
          "/api/v1/url/create",
          jsonEncode(body),
        );
      } else {
        await standardPutRequest(
          "/api/v1/url/update",
          jsonEncode(body),
        );
      }

      router.push("/content/pages");
    }

    return Stack(
      children: [
        TopBar(
          name: "/$url",
          saveNotifier: changeAttributeMap,
          saveValues: saveValues,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80),
          child: PageInfoBlock(
            block: List<Widget>.generate(
              blocks.length,
              (index) {
                return GenerateBlock(
                  block: blocksEntriesList[index],
                  changeAttributeMap: changeAttributeMap,
                );
              },
            ),
            changeAttributeMap: changeAttributeMap,
          ),
        )
      ].reversed.toList(),
    );
  }
}
