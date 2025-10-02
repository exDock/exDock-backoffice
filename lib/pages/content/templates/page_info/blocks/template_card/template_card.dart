// Flutter imports:
// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:flutter/material.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5 - 96,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: kBoxShadowList,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
