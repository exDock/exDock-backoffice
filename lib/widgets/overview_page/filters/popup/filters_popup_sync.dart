// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kumi_popup_window/kumi_popup_window.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/buttons/exdock_button.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/widget_generator/filter_setup_widget_generator.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_staging_ground.dart';

class FiltersPopupSync extends StatefulWidget {
  const FiltersPopupSync({
    super.key,
    required this.filterNotifier,
    required this.pop,
    required this.filterSetupData,
  });

  final FilterNotifier filterNotifier;
  final KumiPopupWindow pop;
  final List<FilterSetupData> filterSetupData;

  @override
  State<FiltersPopupSync> createState() => _FiltersPopupSyncState();
}

class _FiltersPopupSyncState extends State<FiltersPopupSync> {
  late final FilterStagingGround filterStagingGround = FilterStagingGround(
    filterNotifier: widget.filterNotifier,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filters",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Expanded(
          // TODO: turn into grid
          child: ListView.builder(
            itemCount: widget.filterSetupData.length,
            itemBuilder: (context, index) => FilterSetupWidgetGenerator(
              filterSetupData: widget.filterSetupData[index],
              filterStagingGround: filterStagingGround,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ExdockButton(
                onPressed: () {
                  widget.pop.dismiss(context);
                },
                label: 'CANCEL',
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: ExdockButton(
                onPressed: () {
                  filterStagingGround.commit();
                  widget.pop.dismiss(context);
                },
                label: 'APPLY',
              ),
            ),
          ],
        )
      ],
    );
  }
}
