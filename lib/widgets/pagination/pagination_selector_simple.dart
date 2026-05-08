// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/pagination/page_notifier.dart';

class PaginationSelectorSimple extends StatefulWidget {
  const PaginationSelectorSimple({super.key, required this.pageNotifier});

  final PageNotifier pageNotifier;

  @override
  State<PaginationSelectorSimple> createState() =>
      _PaginationSelectorSimpleState();
}

class _PaginationSelectorSimpleState extends State<PaginationSelectorSimple> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          if (widget.pageNotifier.canDecrement)
            SizedBox(
              width: 48,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    widget.pageNotifier.decrement();
                  });
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
            )
          else
            const SizedBox(width: 48, height: 48),
          Text((widget.pageNotifier.value + 1).toString()),
          if (widget.pageNotifier.canIncrement)
            SizedBox(
                width: 48,
                child: TextButton(
                  onPressed: () {
                    if (widget.pageNotifier.canIncrement) {
                      setState(() {
                        widget.pageNotifier.increment();
                      });
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                ))
          else
            const SizedBox(width: 48, height: 48),
        ],
      ),
    );
  }
}
