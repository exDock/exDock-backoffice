// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/pages/stores/configuration/configuration_menu_sub_type.dart';

class ConfigurationSidebar extends StatefulWidget {
  final Map<String, List<ConfigurationMenuSubType>> menuItems;
  final Color backgroundColor;
  final Color textColor;
  final Color expandedSectionColor;

  const ConfigurationSidebar({
    super.key,
    required this.menuItems,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black87,
    this.expandedSectionColor = Colors.white,
  });

  @override
  State<ConfigurationSidebar> createState() => _ConfigurationSidebarState();
}

class _ConfigurationSidebarState extends State<ConfigurationSidebar>
    with TickerProviderStateMixin {
  // Track expanded sections
  Set<String> expandedSections = {};

  // Store animation controllers
  final Map<String, AnimationController> _rotationControllers = {};
  final Map<String, AnimationController> _expansionControllers = {};
  final Map<String, List<AnimationController>> _itemControllers = {};

  // Animation durations
  final Duration _rotationDuration = const Duration(milliseconds: 300);
  final Duration _expansionDuration = const Duration(milliseconds: 300);
  final Duration _itemFadeDuration = const Duration(milliseconds: 200);
  final Duration _staggerDelay = const Duration(milliseconds: 75);

  @override
  void initState() {
    super.initState();
    _initializeAnimationControllers();
  }

  void _initializeAnimationControllers() {
    // Initialize animation controllers for each section
    for (final sectionTitle in widget.menuItems.keys) {
      // Rotation controller for the arrow icon
      _rotationControllers[sectionTitle] = AnimationController(
        vsync: this,
        duration: _rotationDuration,
      );

      // Expansion controller for the section container
      _expansionControllers[sectionTitle] = AnimationController(
        vsync: this,
        duration: _expansionDuration,
      );

      // Individual controllers for each item in the section
      final items = widget.menuItems[sectionTitle] ?? [];
      _itemControllers[sectionTitle] = List.generate(
        items.length,
        (index) => AnimationController(
          vsync: this,
          duration: _itemFadeDuration,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Dispose all animation controllers
    for (final controller in _rotationControllers.values) {
      controller.dispose();
    }

    for (final controller in _expansionControllers.values) {
      controller.dispose();
    }

    for (final controllerList in _itemControllers.values) {
      for (final controller in controllerList) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _animateItems(String sectionTitle, bool isExpanded) {
    final items = _itemControllers[sectionTitle] ?? [];

    if (isExpanded) {
      // Staggered animation forward for each item
      for (int i = 0; i < items.length; i++) {
        Future.delayed(_staggerDelay * i, () {
          if (mounted) {
            items[i].forward();
          }
        });
      }
    } else {
      // Reverse all item animations at once when closing
      for (final controller in items) {
        controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: widget.backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: _buildMenuSections(),
      ),
    );
  }

  List<Widget> _buildMenuSections() {
    final List<Widget> sections = [
      const SizedBox(height: 24),
    ];

    const Widget divider = Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Material(
        color: Colors.grey,
        child: SizedBox(
          height: 1,
        ),
      ),
    );

    widget.menuItems.forEach((sectionTitle, subItems) {
      final bool isExpanded = expandedSections.contains(sectionTitle);
      final rotationController = _rotationControllers[sectionTitle]!;
      final expansionController = _expansionControllers[sectionTitle]!;

      // Update controllers based on expansion state
      if (isExpanded) {
        rotationController.forward();
        expansionController.forward();
        _animateItems(sectionTitle, true);
      } else {
        rotationController.reverse();
        expansionController.duration = const Duration(milliseconds: 150);
        expansionController.reverse();
        expansionController.duration = _expansionDuration;
        _animateItems(sectionTitle, false);
      }

      // Rotation animation for the arrow icon
      final rotationAnimation =
          Tween<double>(begin: 0, end: 0.5).animate(CurvedAnimation(
        parent: rotationController,
        curve: Curves.easeInOut,
      ));

      // Add section header
      sections.add(
        InkWell(
          onTap: () {
            setState(() {
              if (isExpanded) {
                expandedSections.remove(sectionTitle);
              } else {
                expandedSections.add(sectionTitle);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sectionTitle.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: widget.textColor,
                  ),
                ),
                AnimatedBuilder(
                  animation: rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: rotationAnimation.value * 3.14159 * 2,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: widget.textColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );

      // Create container for the items with a smooth slide animation
      sections.add(
        AnimatedBuilder(
          animation: expansionController,
          builder: (context, child) {
            return ClipRect(
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: expansionController.value,
                child: Container(
                  color: widget.expandedSectionColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildSubItems(sectionTitle, subItems),
                  ),
                ),
              ),
            );
          },
        ),
      );

      sections.add(divider);
    });

    return sections;
  }

  List<Widget> _buildSubItems(
      String sectionTitle, List<ConfigurationMenuSubType> subItems) {
    final List<Widget> itemWidgets = [];
    final itemControllerList = _itemControllers[sectionTitle] ?? [];

    for (int i = 0; i < subItems.length; i++) {
      if (i < itemControllerList.length) {
        final item = subItems[i];
        final itemController = itemControllerList[i];

        // Fade animation for individual item
        final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: itemController,
            curve: Curves.easeIn,
          ),
        );

        itemWidgets.add(
          FadeTransition(
            opacity: fadeAnimation,
            child: MaterialButton(
              onPressed: item.onPressed,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 14,
                      color: widget.textColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return itemWidgets;
  }
}
