// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/content/row/overview_page_page.dart';

class OverviewPageContentBodySynchronous extends StatelessWidget {
  const OverviewPageContentBodySynchronous({
    super.key,
    required this.page,
    required this.tableWidth,
  });

  final OverviewPagePage page;
  final double tableWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: tableWidth,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: page.rows.length,
          itemBuilder: (context, index) {
            return page.rows[index];
          },
        ),
      ),
    );
  }
}
