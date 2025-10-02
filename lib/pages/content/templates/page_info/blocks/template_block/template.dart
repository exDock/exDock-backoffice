import 'package:exdock_backoffice/pages/content/templates/page_info/blocks/template_block/template_code.dart';
import 'package:exdock_backoffice/pages/content/templates/page_info/blocks/template_block/template_preview.dart';
import 'package:flutter/material.dart';

class Template extends StatelessWidget {
  const Template({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> block;
  final dynamic changeAttributeMap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TemplateCode(
          block: block,
          changeAttributeMap: changeAttributeMap,
        ),
        const SizedBox(width: 24),
        TemplatePreview(
          data: block,
          changeAttributeMap: changeAttributeMap,
        ),
      ],
    );
  }
}
