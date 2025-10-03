// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:exdock_backoffice/widgets/overview_page/content/columns/overview_page_column.dart';
import 'package:exdock_backoffice/widgets/overview_page/visible_columns_selection/columns_notifier.dart';

class VisibleColumnSelection extends StatefulWidget {
  const VisibleColumnSelection({
    super.key,
    required this.column,
    required this.visibleColumns,
    required this.onToggle, // Add callback for state changes
  });

  final OverviewPageColumnData column;
  final ColumnsNotifier visibleColumns;
  final Function(OverviewPageColumnData column, bool isVisible) onToggle;

  @override
  State<VisibleColumnSelection> createState() => _VisibleColumnSelectionState();
}

class _VisibleColumnSelectionState extends State<VisibleColumnSelection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isHovered = false;

  bool get _isVisible => widget.visibleColumns.containsColumn(widget.column);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Toggle the visibility state
    widget.onToggle(widget.column, !_isVisible);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: GestureDetector(
                onTap: _handleTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    gradient: _isVisible
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              colorScheme.primary,
                              colorScheme.primary.withAlpha(204),
                            ],
                          )
                        : LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              theme.cardColor,
                              theme.cardColor.withAlpha(179),
                            ],
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: _isVisible
                            ? colorScheme.primary.withAlpha(77)
                            : Colors.black.withAlpha(25),
                        blurRadius: _isHovered ? 12 : 8,
                        offset: _isHovered
                            ? const Offset(0, 6)
                            : const Offset(0, 4),
                        spreadRadius: _isHovered ? 2 : 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _isVisible
                          ? colorScheme.primary.withAlpha(77)
                          : theme.dividerColor.withAlpha(51),
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.column.name,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: _isVisible
                                          ? colorScheme.onPrimary
                                          : theme.textTheme.bodyLarge?.color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.column.columnKey,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: _isVisible
                                    ? colorScheme.onPrimary.withAlpha(204)
                                    : theme.textTheme.bodySmall?.color
                                        ?.withAlpha(179),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: _isVisible
                              ? colorScheme.onPrimary
                              : colorScheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(25),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            _isVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            key: ValueKey(_isVisible),
                            size: 16,
                            color: _isVisible
                                ? colorScheme.primary
                                : colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
