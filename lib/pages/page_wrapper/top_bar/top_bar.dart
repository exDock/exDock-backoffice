// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/pages/page_wrapper/top_bar/account_widget.dart';
import 'package:exdock_backoffice/pages/page_wrapper/top_bar/notifications.dart';
import 'package:exdock_backoffice/pages/page_wrapper/top_bar/page_name.dart';
import 'package:exdock_backoffice/pages/page_wrapper/top_bar/search.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: kBoxShadowList,
      ),
      child: const Padding(
        padding: EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PageName(),
            Row(
              children: [
                Search(width: 400),
                SizedBox(width: 24),
                Notifications(),
                SizedBox(width: 24),
                AccountWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
