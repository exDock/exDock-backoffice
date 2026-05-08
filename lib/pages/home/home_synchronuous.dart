// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/home/home_data.dart';
import 'package:exdock_backoffice/pages/home/widgets/home_global_statistics.dart';
import 'package:exdock_backoffice/pages/home/widgets/home_graph.dart';
import 'package:exdock_backoffice/pages/home/widgets/home_last_statistics.dart';
import 'package:exdock_backoffice/pages/home/widgets/home_top_statistics.dart';

class HomeSynchronous extends StatelessWidget {
  const HomeSynchronous({super.key, required this.homeData});

  final HomeData homeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeGlobalStatistics(
                      lifetimeSales: homeData.lifetimeSales,
                      averageOrder: homeData.averageOrder,
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: HomeLastStatistics(
                        lastOrders: homeData.lastOrders,
                        lastSearches: homeData.lastSearches,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              const Flexible(child: HomeGraph()),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Flexible(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                child: HomeTopStatistics(
                  topProducts: homeData.topProducts,
                  topSearches: homeData.topSearches,
                ),
              ),
              const SizedBox(width: 24),
              const Expanded(child: Placeholder()),
            ],
          ),
        ),
      ],
    );
  }
}
