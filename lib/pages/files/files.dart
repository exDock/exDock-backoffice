// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/files/files_synchronous.dart';
import 'package:exdock_backoffice/utils/HTTP/get_request.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class Files extends StatefulWidget {
  const Files({super.key});

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  Future<Map<String, dynamic>> getFilesData() async {
    final HttpData httpData = await standardGetRequest(
      "/api/v1/file/getBlockData/files",
    );

    return jsonDecode(httpData.responseBody!) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFilesData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Placeholder();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return FilesSynchronous(
            blocks: snapshot.data!,
            changeAttributeMap: MapNotifier(),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
