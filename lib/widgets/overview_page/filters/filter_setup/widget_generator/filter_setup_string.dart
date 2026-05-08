// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/input/exdock_text_field.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_staging_ground.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/types/string_filter.dart';

class FilterSetupString extends StatelessWidget {
  const FilterSetupString({
    super.key,
    required this.filterStagingGround,
    required this.filterSetupData,
  });

  final FilterStagingGround filterStagingGround;
  final FilterSetupData filterSetupData;

  @override
  Widget build(BuildContext context) {
    return ExdockTextField(
      labelText: filterSetupData.name,
      controller: TextEditingController(
          text: (filterStagingGround.filterNotifier.value[filterSetupData.key]
                  as StringFilterData?)
              ?.value),
      onChanged: (value) {
        if (value == "") {
          filterStagingGround.filtersToRemove.add(filterSetupData.key);
          return;
        }

        filterStagingGround.changeFilter(
          StringFilterData(
            name: filterSetupData.name,
            key: filterSetupData.key,
            value: value,
          ),
        );
      },
    );
  }
}
