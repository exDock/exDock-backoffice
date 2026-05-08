// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:dotted_decoration/dotted_decoration.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';

class OverviewPageRowCell extends StatelessWidget {
  const OverviewPageRowCell({
    super.key,
    required this.cellValue,
    required this.width,
    this.isLast = false,
  });

  final Widget? cellValue;
  final double width;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final Widget cell = Container(
      width: isLast ? width : null,
      decoration: BoxDecoration(
        border: Border(
          right: isLast
              ? BorderSide(
                  color: darkColour.withAlpha(50),
                  width: 1,
                )
              : BorderSide.none,
          bottom: BorderSide(
            color: darkColour.withAlpha(50),
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: cellValue ?? const Text("-"),
      ),
    );

    if (isLast) return cell;

    return Container(
      width: width,
      decoration: DottedDecoration(
        shape: Shape.line,
        linePosition: LinePosition.right,
        dash: const [0, 5, 10, 5],
      ),
      child: cell,
    );
  }
}
