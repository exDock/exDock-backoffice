// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/pages/page_wrapper/side_bar/exdock_navigation_rail.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key, required this.width});

  final double width;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: kBoxShadowList,
      ),
      child: Column(
        verticalDirection: VerticalDirection.up,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(
            child: ExDockNavigationRail(),
          ),
          Container(
            height: widget.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: kBoxShadowList,
            ),
            child: const Center(
              child: Text("exDock"),
            ),
          ),
        ],
      ),
    );
  }
}
