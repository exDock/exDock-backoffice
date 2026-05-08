// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:kumi_popup_window/kumi_popup_window.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/popup/exdock_big_popup.dart';

class EditCategoryStructurePopup extends StatelessWidget {
  const EditCategoryStructurePopup({super.key, required this.pop});

  final KumiPopupWindow pop;

  @override
  Widget build(BuildContext context) {
    return ExdockBigPopup(
      pop: pop,
      title: "Edit category structure",
      child: const Placeholder(),
    );
  }
}
