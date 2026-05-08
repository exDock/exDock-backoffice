// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/loading/exdock_loading_animation.dart';

class ExdockLoadingPageAnimation extends StatelessWidget {
  const ExdockLoadingPageAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    // Ability to customise in the future
    return const Center(
      child: ExdockLoadingAnimation(),
    );
  }
}
