// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kumi_popup_window/kumi_popup_window.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/loading/exdock_loading_page_animation.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_notifier.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/popup/filters_popup_sync.dart';

class FiltersPopup extends StatelessWidget {
  const FiltersPopup({
    super.key,
    required this.filterNotifier,
    required this.pop,
    required this.getFilters,
  });

  final FilterNotifier filterNotifier;
  final KumiPopupWindow pop;
  final Future<List<FilterSetupData>> Function() getFilters;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFilters(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return FiltersPopupSync(
            filterNotifier: filterNotifier,
            pop: pop,
            filterSetupData: snapshot.data!,
          );
        }

        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return const ExdockLoadingPageAnimation();
      },
    );
  }
}
