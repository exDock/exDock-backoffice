// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/home/home_data.dart';
import 'package:exdock_backoffice/pages/home/widgets/dashboard_table_3_columns.dart';

class HomeLastStatistics extends StatelessWidget {
  const HomeLastStatistics({
    super.key,
    required this.lastOrders,
    required this.lastSearches,
  });

  final List<HomeDataOrder> lastOrders;
  final List<HomeDataSearch> lastSearches;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            color: Colors.black.withAlpha(128),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: DashboardTable3Columns(
                title: "Last orders",
                column0Name: "Customer name",
                column1Name: "items",
                column2Name: "total",
                values: List<List<String>>.generate(
                  lastOrders.length,
                  (index) {
                    return [
                      lastOrders[index].customerName,
                      lastOrders[index].itemCount.toString(),
                      "€ ${lastOrders[index].totalAmount}",
                    ];
                  },
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: DashboardTable3Columns(
                title: "Last searches",
                column0Name: "search term",
                column1Name: "results",
                column2Name: "uses",
                values: List<List<String>>.generate(
                  lastSearches.length,
                  (index) {
                    return [
                      lastSearches[index].searchTerm,
                      lastSearches[index].results.toString(),
                      lastSearches[index].uses.toString(),
                    ];
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
