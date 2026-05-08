// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/utils/user_parameters/user_parameter.dart';
import 'package:exdock_backoffice/widgets/input/exdock_text_field.dart';

class TextUserParameter extends UserParameter {
  TextUserParameter(
    super.key,
    super.parameterValueStorage, {
    this.name,
    this.initialValue,
  });

  final String? name;
  final String? initialValue;

  @override
  Widget getInputWidget() => ExdockTextField(
        controller: TextEditingController(text: initialValue),
        labelText: name ?? key,
        onChanged: (value) {
          if (value == "") {
            parameterValueStorage.remove(key);
            return;
          }
          parameterValueStorage[key] = value;
        },
      );
}
