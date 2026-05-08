// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/variables.dart';

class PageName extends StatefulWidget {
  const PageName({super.key});

  @override
  State<PageName> createState() => _PageNameState();
}

class _PageNameState extends State<PageName> {
  String capitalise(String input) {
    if (input.isEmpty) return "";
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  @override
  void initState() {
    super.initState();
    pathNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    pathNotifier.removeListener(() {
      setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> breadCrumbsList = pathNotifier.value.split("/");
    if (breadCrumbsList.isNotEmpty) breadCrumbsList.removeAt(0);
    if (breadCrumbsList.isNotEmpty) breadCrumbsList.removeLast();
    final String breadCrumbs = breadCrumbsList.join(" > ").replaceAll("-", " ");

    final Widget pageNameWidget = Text(
      capitalise(pathNotifier.value.split("/").last).replaceAll("-", " "),
      style: Theme.of(context).textTheme.headlineLarge,
    );
    if (breadCrumbs.isNotEmpty) {
      return Stack(
        children: [
          Text(
            breadCrumbs,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: pageNameWidget,
          ),
        ],
      );
    }
    return pageNameWidget;
  }
}
