// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:hoverable_navigation_rail/hoverable_navigation_rail.dart';
import 'package:hoverable_navigation_rail/hoverable_navigation_rail_destination.dart';

// Project imports:
import 'package:exdock_backoffice/pages/page_wrapper/side_bar/navigation_rail_destinations.dart';
import 'package:exdock_backoffice/pages/page_wrapper/side_bar/side_bar_hover_menu.dart';
import 'package:exdock_backoffice/pages/page_wrapper/side_bar/side_bar_hover_menu_data.dart';

class ExDockNavigationRail extends StatefulWidget {
  const ExDockNavigationRail({super.key});

  @override
  State<ExDockNavigationRail> createState() => _ExDockNavigationRailState();
}

class _ExDockNavigationRailState extends State<ExDockNavigationRail> {
  final SideBarHoverMenuData sideBarHoverMenuData = SideBarHoverMenuData(
      false,
      false,
      OverlayState(), // temporary
      null,
      null,
      null);
  int selectedIndex = 0;
  late Map<String, HoverableNavigationRailDestination> destinations;

  @override
  void didChangeDependencies() {
    destinations = navigationRailDestinations(context, sideBarHoverMenuData);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    sideBarHoverMenuData.dismissTimer?.cancel();
    removeHoverMenuOverlay(sideBarHoverMenuData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sideBarHoverMenuData.overlayState = Overlay.of(context);
    return HoverableNavigationRail(
      labelType: NavigationRailLabelType.all,
      selectedIndex: selectedIndex,
      onDestinationSelected: (newIndex) {
        setState(() {
          selectedIndex = newIndex;
          context.push(destinations.keys.toList()[newIndex]);
        });
      },
      destinations: destinations.values.toList(),
    );
  }
}
