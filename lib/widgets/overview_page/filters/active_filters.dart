// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_widget.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/types/filter.dart';
import 'package:exdock_backoffice/widgets/pagination/page_notifier.dart';
import 'package:exdock_backoffice/widgets/pagination/pagination_selector_simple.dart';

class ActiveFilters extends StatefulWidget {
  const ActiveFilters({
    super.key,
    required this.filters,
    required this.pageNotifier,
  });

  final FilterNotifier filters;
  final PageNotifier pageNotifier;

  @override
  State<ActiveFilters> createState() => _ActiveFiltersState();
}

class _ActiveFiltersState extends State<ActiveFilters> {
  final ScrollController _scrollController = ScrollController();

  List<FilterData> getSortedFilters() {
    return widget.filters.value.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("active filters:"),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: widget.filters,
              builder: (context, value, child) {
                final List<FilterData> sortedFilters = getSortedFilters();

                return ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: sortedFilters.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: FilterWidget(
                        allFilters: widget.filters,
                        filter: sortedFilters[index],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.filters.reset();
              });
            },
            child: const Text("Clear all"),
          ),
          PaginationSelectorSimple(pageNotifier: widget.pageNotifier),
        ],
      ),
    );
  }
}
