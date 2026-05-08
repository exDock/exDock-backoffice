// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/globals/globals.dart';
import 'package:exdock_backoffice/pages/page_wrapper/side_bar/side_bar_hover_menu_data.dart';

void removeHoverMenuOverlay(SideBarHoverMenuData sideBarHoverMenuData) {
  sideBarHoverMenuData.overlayEntry?.remove();
  sideBarHoverMenuData.overlayEntry = null;
}

void showHoverMenuOverlay(
  SideBarHoverMenuData sideBarHoverMenuData,
  Widget child,
) {
  removeHoverMenuOverlay(
      sideBarHoverMenuData); // Remove any existing overlay first

  sideBarHoverMenuData.overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      left: 100,
      top: 100,
      child: MouseRegion(
        onEnter: (_) {
          sideBarHoverMenuData.isHoveringMenu = true;
        },
        onExit: (_) {
          sideBarHoverMenuData.isHoveringMenu = false;
          startHoverMenuDismissTimer(sideBarHoverMenuData);
        },
        child: Material(
          color: darkColour,
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: child,
          ),
        ),
      ),
    ),
  );

  sideBarHoverMenuData.overlayState.insert(sideBarHoverMenuData.overlayEntry!);
}

void startHoverMenuDismissTimer(SideBarHoverMenuData sideBarHoverMenuData) {
  sideBarHoverMenuData.dismissTimer?.cancel();
  sideBarHoverMenuData.dismissTimer =
      Timer(const Duration(milliseconds: 250), () {
    if (!sideBarHoverMenuData.isHoveringMenu &&
        !sideBarHoverMenuData.isHoveringButton) {
      removeHoverMenuOverlay(sideBarHoverMenuData);
    }
  });
}

Function(bool isHovering) onHoverStateChangeHoverMenu(
  SideBarHoverMenuData sideBarHoverMenuData,
  BuildContext context,
  Widget child,
) {
  return (bool isHovering) {
    if (isHovering) {
      // sideBarHoverMenuData.hoveredIndex = newHoveredIndex;
      sideBarHoverMenuData.isHoveringButton = true;
      showHoverMenuOverlay(
        sideBarHoverMenuData,
        child,
      );
    } else {
      sideBarHoverMenuData.isHoveringButton = false;
      startHoverMenuDismissTimer(sideBarHoverMenuData);
    }
  };
}
