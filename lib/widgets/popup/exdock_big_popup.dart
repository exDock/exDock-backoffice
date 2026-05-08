// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kumi_popup_window/kumi_popup_window.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/exdock_close_icon.dart';

class ExdockBigPopup extends StatelessWidget {
  const ExdockBigPopup({
    super.key,
    required this.pop,
    required this.title,
    required this.child,
  });

  final KumiPopupWindow pop;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width * .8,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Expanded(
                    child: child,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: ExdockCloseIcon(onPressed: () {
              pop.dismiss(context);
            }),
          ),
        ],
      ),
    );
  }
}
