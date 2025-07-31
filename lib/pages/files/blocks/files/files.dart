import 'dart:convert';

import 'package:exdock_backoffice/pages/files/blocks/files/file_entry.dart';
import 'package:exdock_backoffice/utils/HTTP/get_request.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class Files extends StatelessWidget {
  const Files({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  Future<void> downloadFile() async {
    final String path = changeAttributeMap.value["path"];

    if (path.isEmpty) {
      return;
    }

    final HttpData httpData = await standardGetRequest(
      "/api/v1/file/getAll/$path",
    );

    if (httpData.responseBody == null) {
      print("Error downloading file: ${httpData.statusCode}");
      return;
    }

    final Map<String, dynamic> response = jsonDecode(httpData.responseBody!);
    final Uint8List bytes = base64Decode(response["data"] as String);
    final String fileName = response["fileName"] as String;
    final String fileExtension = response["fileExtension"] as String;

    _downloadBytes(bytes, fileName, _getMimeType(fileExtension));
  }

  void _downloadBytes(Uint8List bytes, String fileName, String mimeType) {
    if (kIsWeb) {
      final blob = html.Blob([bytes], mimeType);
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();

      html.Url.revokeObjectUrl(url);
    } else {
      final file = html.File([bytes], fileName, {'type': mimeType});
      final url = html.Url.createObjectUrl(file);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();

      html.Url.revokeObjectUrl(url);
    }
  }

  Future<dynamic> getFilesFromServer() async {
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

    final Map<String, dynamic> response = jsonDecode(httpData.responseBody!);

    if (response["contentType"] == "image") {
      return response;
    } else if (response.containsKey("files")) {
      return response["files"] as List<dynamic>;
    } else {
      return [];
    }
  }

  String _getMimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'txt':
        return 'text/plain';
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      case 'zip':
        return 'application/zip';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'pptx':
        return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
      default:
        return 'application/octet-stream'; // Generic binary
    }
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
          if (snapshot.data == null) {
            return const Center(child: Text("No files found."));
          }

          if (snapshot.data is Map<String, dynamic>) {
            final String type = snapshot.data["contentType"] as String;
            final String data = snapshot.data["data"] as String;

            return Column(
              children: [
                Center(
                  child: Image.memory(
                    base64Decode(data),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Align(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      onPressed: downloadFile,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.30,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.download),
                            SizedBox(width: 8),
                            Text("Download"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

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

          return Container(
            height: MediaQuery.of(context).size.height - 200,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: ValueListenableBuilder(
              valueListenable: changeAttributeMap,
              builder: (context, value, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return fileWidgets[index];
                  },
                  itemCount: fileWidgets.length,
                );
              },
            ),
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
