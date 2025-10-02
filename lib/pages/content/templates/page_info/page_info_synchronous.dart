import 'dart:convert';

import 'package:exdock_backoffice/pages/content/templates/page_info/blocks/generate_block.dart';
import 'package:exdock_backoffice/pages/content/templates/page_info/blocks/page_info_block.dart';
import 'package:exdock_backoffice/pages/content/templates/page_info/blocks/top_bar/top_bar.dart';
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
    this.isNewTemplate = false,
  });

  final String url;
  final Map<String, dynamic> blocks;
  final MapNotifier changeAttributeMap;
  final bool isNewTemplate;

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, dynamic>> blocksEntriesList =
        blocks.entries.toList();

    saveValues() async {
      final Map<String, dynamic> body = {
        "_id": "/$url",
        "template_data": changeAttributeMap.value["template_data"],
      };

      if (changeAttributeMap.value.containsKey("Block Name")) {
        body["block_name"] = changeAttributeMap.value["Block Name"];
      } else {
        body["block_name"] = "";
      }

      if (isNewTemplate) {
        body["_id"] = "/${changeAttributeMap.value["Key"]}";

        await standardPostRequest(
          "/api/v1/template/create",
          jsonEncode(body),
        );
      } else {
        await standardPutRequest(
          "/api/v1/template/update",
          jsonEncode(body),
        );
      }
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
