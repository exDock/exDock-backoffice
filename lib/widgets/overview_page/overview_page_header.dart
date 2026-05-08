// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kumi_popup_window/kumi_popup_window.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/router/router.dart';
import 'package:exdock_backoffice/utils/id_set_notifier.dart';
import 'package:exdock_backoffice/widgets/buttons/exdock_button.dart';
import 'package:exdock_backoffice/widgets/input/exdock_search_bar.dart';
import 'package:exdock_backoffice/widgets/overview_page/bulk/bulk_action.dart';
import 'package:exdock_backoffice/widgets/overview_page/bulk/bulk_actions_button.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/popup/filters_popup.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/types/string_filter.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/columns_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/visible_columns_selection.dart';

class OverviewPageHeader extends StatefulWidget {
  const OverviewPageHeader({
    super.key,
    required this.columns,
    required this.visibleColumns,
    required this.bulkActions,
    required this.filters,
    required this.selectedIds,
    this.individualName,
    this.getFilters,
    this.newUrl,
  });

  final ColumnsNotifier columns;
  final ColumnsNotifier visibleColumns;
  final List<BulkAction> bulkActions;
  final FilterNotifier filters;
  final IdSetNotifier selectedIds;
  final String? individualName;
  final Future<List<FilterSetupData>> Function()? getFilters;
  final String? newUrl;

  @override
  State<OverviewPageHeader> createState() => _OverviewPageHeaderState();
}

class _OverviewPageHeaderState extends State<OverviewPageHeader> {
  void applyKeywordFilter(String searchString) {
    widget.filters.addFilter(
      StringFilterData(
        name: "Keyword",
        key: "keyword",
        value: searchString,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String addNewText = widget.individualName == null
        ? "add new"
        : "add new ${widget.individualName}";
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: kBoxShadowList,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ExdockSearchBar(
              onSubmitted: applyKeywordFilter,
              getSearchSuggestions: (searchText) {
                return [
                  "search result 1",
                  "search result 2",
                  "search result 3",
                  "search result 4",
                  "search result 5",
                ];
              },
            ),
            Row(
              children: [
                if (widget.bulkActions.isNotEmpty)
                  BulkActionsButton(
                    bulkActions: widget.bulkActions,
                  ),
                if (widget.bulkActions.isNotEmpty) const SizedBox(width: 12),
                if (widget.getFilters != null)
                  ExdockButton(
                    label: "filters",
                    onPressed: () {
                      showPopupWindow(context, childFun: (pop) {
                        return LayoutBuilder(
                          key: GlobalKey(),
                          builder: (context, constraints) {
                            final double height = constraints.maxHeight * .7;
                            final double width = constraints.maxWidth * .8;
                            return SizedBox(
                              height: height,
                              width: width,
                              child: Stack(
                                children: [
                                  Container(
                                    height: height,
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      boxShadow: kBoxShadowList,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    padding: const EdgeInsets.all(24),
                                    child: FiltersPopup(
                                      filterNotifier: widget.filters,
                                      pop: pop,
                                      getFilters: widget.getFilters!,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: IconButton(
                                        onPressed: () {
                                          pop.dismiss(context);
                                        },
                                        icon: const Icon(Icons.close_rounded),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      });
                    },
                    icon: Icons.filter_alt_rounded,
                  ),
                if (widget.getFilters != null) const SizedBox(width: 12),
                ExdockButton(
                  label: "view",
                  onPressed: () {
                    showPopupWindow(
                      context,
                      onDismissStart: (pop) {
                        widget.visibleColumns.notify(onlyIfChanged: true);
                      },
                      childFun: (pop) {
                        return VisibleColumnsSelection(
                          key: GlobalKey(),
                          columns: widget.columns,
                          visibleColumns: widget.visibleColumns,
                        );
                      },
                    );
                    // TODO: rows per page
                  },
                  icon: Icons.visibility_rounded,
                ),
                const SizedBox(width: 12),
                // TODO: add new page button
                ExdockButton(
                  label: addNewText,
                  onPressed: () {
                    if (widget.newUrl == null) {
                      return;
                    }
                    router.push(widget.newUrl!);
                  },
                  icon: Icons.add_rounded,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
