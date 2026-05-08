// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';

class ExdockButton extends StatefulWidget {
  const ExdockButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.hoverColor,
    this.icon,
  });

  final String label;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? hoverColor;
  final IconData? icon;

  @override
  State<ExdockButton> createState() => _ExdockButtonState();
}

class _ExdockButtonState extends State<ExdockButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Widget child = Text(
      widget.label,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).cardColor,
          ),
    );
    if (widget.icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          const SizedBox(width: 12),
          Icon(widget.icon!, color: Theme.of(context).cardColor),
        ],
      );
    }

    child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Center(
        child: child,
      ),
    );

    if (widget.onPressed != null) {
      child = InkWell(
        onTap: widget.onPressed,
        child: child,
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.hoverColor ?? darkColour
                : widget.backgroundColor ?? mainColour,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            child: child,
          ),
        ),
      ),
    );
  }
}
