import 'package:exdock_backoffice/pages/content/templates/page_info/blocks/template_card/template_card_title.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:highlight/languages/htmlbars.dart';

class TemplateCode extends StatefulWidget {
  const TemplateCode({
    super.key,
    required this.block,
    required this.changeAttributeMap,
  });

  final MapEntry<String, dynamic> block;
  final MapNotifier changeAttributeMap;

  @override
  State<TemplateCode> createState() => _TemplateCodeState();
}

class _TemplateCodeState extends State<TemplateCode> {
  final controller = CodeController(
    text: "",
    language: htmlbars,
  );

  @override
  void initState() {
    controller.text =
        widget.block.value["attributes"][0]["current_attribute_value"] ?? "";
    widget.changeAttributeMap.value["template_data"] =
        widget.block.value["attributes"][0]["current_attribute_value"] ?? "";

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      widget.changeAttributeMap.updateEntry(
        "template_data",
        widget.block.value["attributes"][0]["current_attribute_value"] ?? "",
        controller.text,
      );
    });

    widget.changeAttributeMap.value["template_data"] =
        widget.block.value["attributes"][0]["current_attribute_value"];

    return TemplateCardTitle(
      title: 'Template Code',
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 120,
        child: CodeTheme(
          data: CodeThemeData(
            styles: atomOneLightTheme,
          ),
          child: SingleChildScrollView(
            child: CodeField(
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}
