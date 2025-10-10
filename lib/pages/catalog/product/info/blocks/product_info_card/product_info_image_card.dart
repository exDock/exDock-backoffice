// Dart imports:
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:exdock_backoffice/globals/styling.dart';
import 'package:exdock_backoffice/pages/catalog/product/info/product_info_card/product_info_card_title.dart';
import 'package:exdock_backoffice/utils/HTTP/http_data.dart';
import 'package:exdock_backoffice/utils/HTTP/post_requests.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class ProductInfoImageCard extends StatefulWidget {
  const ProductInfoImageCard({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  @override
  State<ProductInfoImageCard> createState() => _ProductInfoImageCardState();
}

class _ProductInfoImageCardState extends State<ProductInfoImageCard> {
  late final ValueNotifier<bool> unsavedChangesNotifier =
      ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    widget.changeAttributeMap.addListener(() {
      unsavedChangesNotifier.value = widget.changeAttributeMap.attributeChanged(
        ["product_image"],
      );
    });
  }

  Future<void> _uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      try {
        final List<String> segments = Uri.base.pathSegments;
        final String id = segments.last;
        const String name = "test";
        final Uint8List imageBytes = await pickedFile.readAsBytes();
        final String fileName = pickedFile.name;
        final String endpoint = "products%2F$id-$name%2F$fileName";
        final String baseRequestUrl = "/api/v1/image/upload/$endpoint";
        String contentType = pickedFile.mimeType ?? "image/jpeg";
        if (contentType.isEmpty) {
          contentType = "image/jpeg"; // Default to JPEG if mime type is empty
        }
        final String body = const Base64Encoder().convert(imageBytes);
        final HttpData uploadRequest = await standardPostRequest(
          baseRequestUrl,
          jsonEncode(body),
          {HttpHeaders.contentTypeHeader: contentType},
        );
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> imagesList = widget.block.value['images'];
    final List<Map<String, dynamic>> images = imagesList.map((image) {
      return image as Map<String, dynamic>;
    }).toList();
    final List<Widget> imageWidgets = [];
    for (final image in images) {
      final List<dynamic> extensions = jsonDecode(image['image_extensions']);
      imageWidgets.add(
        Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 200,
                maxWidth: 200,
                minHeight: 200,
                minWidth: 200,
              ),
              child: Image.network(
                fit: BoxFit.contain,
                image['image_url'],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 24),
              height: 200,
              width: 200,
              child: ListView.builder(
                itemCount: extensions.length,
                itemBuilder: (content, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      boxShadow: lightKBoxShadowList,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(extensions[index] as String),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }

    return ProductInfoCardTitle(
      title: widget.block.key,
      unsavedChangesNotifier: unsavedChangesNotifier,
      child: SizedBox(
        child: Wrap(
          spacing: 10,
          runSpacing: 5,
          direction: Axis.horizontal,
          children: [
            ...imageWidgets,
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: _uploadImage,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: lightKBoxShadowList,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.add_a_photo_outlined,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
