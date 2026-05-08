// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/home/home_data.dart';
import 'package:exdock_backoffice/pages/home/widgets/dashboard_table_2_columns.dart';
import 'package:exdock_backoffice/pages/home/widgets/dashboard_table_3_columns.dart';

class HomeTopStatistics extends StatelessWidget {
  const HomeTopStatistics({
    super.key,
    required this.topProducts,
    required this.topSearches,
  });

  final List<HomeDataProduct> topProducts;
  final List<HomeDataSearch> topSearches;

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
              child: DashboardTable2Columns(
                title: "Top products",
                column0Name: "Product name",
                column1Name: "price",
                values: List<List<String>>.generate(
                  topProducts.length,
                  (index) {
                    return [
                      topProducts[index].productName,
                      "€ ${topProducts[index].price}",
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
                  topSearches.length,
                  (index) {
                    return [
                      topSearches[index].searchTerm,
                      topSearches[index].results.toString(),
                      topSearches[index].uses.toString(),
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
