// Flutter imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hoverable_navigation_rail/hoverable_navigation_rail_destination.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

// Project imports:
import 'package:exdock_backoffice/pages/page_wrapper/side_bar/side_bar_hover_menu.dart';
import 'package:exdock_backoffice/pages/page_wrapper/side_bar/side_bar_hover_menu_data.dart';
import 'package:exdock_backoffice/pages/page_wrapper/side_bar/simple_hover_menu_button.dart';

Map<String, HoverableNavigationRailDestination> navigationRailDestinations(
  BuildContext context,
  SideBarHoverMenuData sideBarHoverMenuData,
) {
  noHoverMenuOnHoverStateChange(isHovered) {
    if (isHovered) removeHoverMenuOverlay(sideBarHoverMenuData);
  }

  return {
    "/home": HoverableNavigationRailDestination(
      onHoverStateChange: noHoverMenuOnHoverStateChange,
      icon: const Icon(Icons.home_rounded),
      label: const Text("home"),
    ),
    "/sales": HoverableNavigationRailDestination(
      onHoverStateChange: noHoverMenuOnHoverStateChange,
      icon: const Icon(Symbols.request_quote_rounded),
      label: const Text("sales"),
    ),
    "/catalog": HoverableNavigationRailDestination(
      onHoverStateChange: onHoverStateChangeHoverMenu(
        sideBarHoverMenuData,
        context,
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  "Catalog",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
              const SimpleHoverMenuButton(
                route: "/catalog/category",
                buttonText: "category",
              ),
              const SimpleHoverMenuButton(
                route: "/catalog/product",
                buttonText: "product",
              ),
            ],
          ),
        ),
      ),
      icon: const Icon(Symbols.package_2_rounded),
      label: const Text("catalog"),
    ),
    "/customers": HoverableNavigationRailDestination(
      onHoverStateChange: noHoverMenuOnHoverStateChange,
      icon: const Icon(Symbols.emoji_people_rounded),
      label: const Text("customers"),
    ),
    "/marketing": HoverableNavigationRailDestination(
      onHoverStateChange: noHoverMenuOnHoverStateChange,
      icon: const Icon(Symbols.campaign_sharp),
      label: const Text("marketing"),
    ),
    "/content": HoverableNavigationRailDestination(
      onHoverStateChange: onHoverStateChangeHoverMenu(
        sideBarHoverMenuData,
        context,
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  "Catalog",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
              const SimpleHoverMenuButton(
                route: "/content/pages",
                buttonText: "pages",
              ),
              const SimpleHoverMenuButton(
                route: "/content/templates",
                buttonText: "templates",
              ),
            ],
          ),
        ),
      ),
      icon: const Icon(Symbols.newspaper_rounded),
      label: const Text("content"),
    ),
    "/reports": HoverableNavigationRailDestination(
      onHoverStateChange: noHoverMenuOnHoverStateChange,
      icon: const Icon(Symbols.monitoring_rounded),
      label: const Text("reports"),
    ),
    "/stores": HoverableNavigationRailDestination(
      icon: const Icon(Symbols.storefront_rounded),
      label: const Text("stores"),
      onHoverStateChange: onHoverStateChangeHoverMenu(
        sideBarHoverMenuData,
        context,
        SizedBox(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  "Settings",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
              const SimpleHoverMenuButton(
                route: "/stores/configuration",
                buttonText: "configuration",
              ),
            ],
          ),
        ),
      ),
    ),
    "/system": HoverableNavigationRailDestination(
      onHoverStateChange: noHoverMenuOnHoverStateChange,
      icon: const Icon(Symbols.host_rounded),
      label: const Text("system"),
    ),
  };
}
