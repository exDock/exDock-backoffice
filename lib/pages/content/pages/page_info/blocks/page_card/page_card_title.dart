// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/content/pages/page_info/blocks/page_card/page_card.dart';

class PageCardTitle extends StatelessWidget {
  const PageCardTitle({
    super.key,
    this.width = double.infinity,
    required this.title,
    required this.child,
    this.button,
    this.middleButton,
  });

  final double width;
  final String title;
  final Widget child;
  final Widget? button;
  final Widget? middleButton;

  @override
  Widget build(BuildContext context) {
    return PageCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              if (middleButton != null) ...[
                const SizedBox(width: 12),
                middleButton!,
              ],
              if (button != null) ...[
                const SizedBox(width: 12),
                button!,
              ]
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
