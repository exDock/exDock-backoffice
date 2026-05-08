// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/input/exdock_text_field.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_setup/filter_setup.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/filter_staging_ground.dart';
import 'package:exdock_backoffice/widgets/overview_page/filters/types/range_filter.dart';

class FilterSetupRange extends StatefulWidget {
  const FilterSetupRange({
    super.key,
    required this.filterStagingGround,
    required this.filterSetupData,
  });

  final FilterStagingGround filterStagingGround;
  final FilterSetupData filterSetupData;

  @override
  State<FilterSetupRange> createState() => _FilterSetupRangeState();
}

class _FilterSetupRangeState extends State<FilterSetupRange> {
  num? minValue;
  num? maxValue;

  TextInputFormatter numberFormatter = TextInputFormatter.withFunction(
    (oldValue, newValue) {
      if (RegExp(r'^\d*\.?\d*$').hasMatch(newValue.text)) {
        return newValue;
      }
      return oldValue;
    },
  );

  void onChanged() {
    if (minValue == null && maxValue == null) {
      widget.filterStagingGround.filtersToRemove
          .add(widget.filterSetupData.key);
      return;
    }

    widget.filterStagingGround.changeFilter(
      RangeFilterData(
        name: widget.filterSetupData.name,
        key: widget.filterSetupData.key,
        min: minValue,
        max: maxValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${widget.filterSetupData.name}: "),
        Expanded(
          child: ExdockTextField(
            labelText: "from",
            inputFormatters: [numberFormatter],
            controller: TextEditingController(
                text: (widget.filterStagingGround.filterNotifier
                        .value[widget.filterSetupData.key] as RangeFilterData?)
                    ?.min
                    .toString()),
            onChanged: (value) {
              minValue = num.tryParse(value);
              onChanged();
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text("-"),
        ),
        Expanded(
          child: ExdockTextField(
            labelText: "to",
            inputFormatters: [numberFormatter],
            controller: TextEditingController(
                text: (widget.filterStagingGround.filterNotifier
                        .value[widget.filterSetupData.key] as RangeFilterData?)
                    ?.max
                    .toString()),
            onChanged: (value) {
              maxValue = num.tryParse(value);
              onChanged();
            },
          ),
        ),
      ],
    );
  }
}
