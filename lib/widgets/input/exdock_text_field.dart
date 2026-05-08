// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/exdock_card.dart';

class ExdockTextField extends StatelessWidget {
  const ExdockTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.isPassword = false,
    this.labelText,
    this.errorText,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final Function(String) onChanged;
  final String? labelText;
  final String? errorText;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return ExdockCard(
      height: 56,
      child: TextField(
        inputFormatters: inputFormatters,
        controller: controller,
        onChanged: onChanged,
        obscureText: isPassword,
        style: const TextStyle(fontSize: 14, height: 1.5),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          errorText: errorText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.blue,
        ),
      ),
    );
  }
}
