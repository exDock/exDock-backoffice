import 'dart:convert';

import 'package:exdock_backoffice/pages/files/blocks/files/file_entry.dart';
import 'package:exdock_backoffice/utils/HTTP/get_request.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:flutter/material.dart';

class Files extends StatelessWidget {
  const Files({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  Future<List<dynamic>> getFilesFromServer() async {
    final String path = changeAttributeMap.value["path"];

    if (path.isEmpty) {
      return block.value["attributes"][0]["current_attribute_value"]
          as List<dynamic>;
    }

    final HttpData httpData = await standardGetRequest(
      "/api/v1/file/getAll/$path",
    );

    if (httpData.responseBody == null) {
      return [];
    }

    final Map<String, dynamic> responseMap = jsonDecode(httpData.responseBody!);
    return responseMap["files"] as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFilesFromServer(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Placeholder();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          final List<dynamic> files = snapshot.data as List<dynamic>;

          final List<Widget> fileWidgets = files.map((fileJson) {
            final EngineFile file = EngineFile(
              fileName: fileJson["fileName"] as String,
              extension: fileJson["extension"] as String,
              fileSize: fileJson["fileSize"] as int,
            );

            return FileEntry(
              file: file,
              changeAttributeMap: changeAttributeMap,
            );
          }).toList();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: ValueListenableBuilder(
                valueListenable: changeAttributeMap,
                builder: (context, value, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...fileWidgets,
                    ],
                  );
                }),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class EngineFile {
  final String fileName;
  final String extension;
  final int fileSize;

  EngineFile({
    required this.fileName,
    required this.extension,
    required this.fileSize,
  });
}
