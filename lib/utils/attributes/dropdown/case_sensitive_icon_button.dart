// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:material_symbols_icons/material_symbols_icons.dart';

// Project imports:
import 'package:exdock_backoffice/globals/styling.dart';

class CaseSensitiveIconButton extends StatefulWidget {
  const CaseSensitiveIconButton({super.key, required this.onChanged});

  final Function(bool) onChanged;

  @override
  State<CaseSensitiveIconButton> createState() =>
      _CaseSensitiveIconButtonState();
}

class _CaseSensitiveIconButtonState extends State<CaseSensitiveIconButton> {
  bool caseSensitiveSearch = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          caseSensitiveSearch = !caseSensitiveSearch;
        });
        widget.onChanged(caseSensitiveSearch);
      },
      padding: const EdgeInsets.all(0),
      style: ButtonStyle(
        backgroundColor: caseSensitiveSearch
            ? const WidgetStatePropertyAll(mainColour)
            : null,
        foregroundColor: caseSensitiveSearch
            ? const WidgetStatePropertyAll(Colors.white)
            : null,
      ),
      icon: const Icon(Symbols.match_case_rounded),
    );
  }
}
