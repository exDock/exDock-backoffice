// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/utils/attributes/dropdown/dropdown_attribute.dart';
import 'package:exdock_backoffice/utils/attributes/images/single_image_attribute.dart';
import 'package:exdock_backoffice/utils/attributes/switch_attribute.dart';
import 'package:exdock_backoffice/utils/attributes/text_field_attribute.dart';
import 'package:exdock_backoffice/utils/attributes/text_field_number_attribute.dart';
import 'package:exdock_backoffice/utils/attributes/text_field_password.dart';
import 'package:exdock_backoffice/utils/attributes/text_field_price_attribute.dart';
import 'package:exdock_backoffice/utils/attributes/wysiwyg_attribute.dart';
import 'package:exdock_backoffice/utils/map_notifier.dart';

class GenerateAttribute extends StatelessWidget {
  const GenerateAttribute(
      {super.key, required this.attribute, required this.changeAttributeMap});

  final Map<String, dynamic> attribute;
  final MapNotifier changeAttributeMap;

  @override
  Widget build(BuildContext context) {
    if (attribute["attribute_type"] == "text") {
      return TextFieldAttribute(
        attribute: attribute,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (attribute["attribute_type"] == "wysiwyg") {
      return WysiwygAttribute(
        attribute: attribute,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (attribute["attribute_type"] == "image") {
      return SingleImageAttribute(
        attribute: attribute,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (attribute["attribute_type"] == "price") {
      return TextFieldPriceAttribute(
        attribute: attribute,
        changeAttributeMap: changeAttributeMap,
      );
    }
    // "number" is for backwards compatibility and should not be used
    if (attribute["attribute_type"] == "float" ||
        attribute["attribute_type"] == "number") {
      return TextFieldNumberAttribute(
        signed: true,
        decimal: true,
        attribute: attribute,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (attribute["attribute_type"] == "int") {
      return TextFieldNumberAttribute(
        signed: true,
        decimal: false,
        attribute: attribute,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (attribute['attribute_type'] == 'switch') {
      return SwitchAttribute(
        attribute: attribute,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (attribute['attribute_type'] == 'dropdown') {
      return DropdownAttribute(
        attribute: attribute,
        changeAttributeMap: changeAttributeMap,
      );
    }
    if (attribute['attribute_type'] == 'password') {
      return TextFieldPassword(
        attribute: attribute,
        changeAttributeMap: changeAttributeMap,
      );
    }
    return Text(
      "attribute_type not recognised: ${attribute["attribute_type"]}",
    );
  }
}
