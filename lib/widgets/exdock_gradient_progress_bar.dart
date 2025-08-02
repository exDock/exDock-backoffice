// Dart imports:
import 'dart:math' as math;

// Flutter imports:
import 'package:flutter/material.dart';

class ExDockGradientProgressBar extends StatefulWidget {
  final double progress; // Value from 0.0 to 1.0
  final List<Color> gradientColors;
  final double height;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;
  final TextStyle? percentageTextStyle;
  final bool showPercentage;

  const ExDockGradientProgressBar({
    super.key,
    required this.progress,
    required this.gradientColors,
    this.height = 20.0,
    this.backgroundColor = Colors.grey,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 500),
    this.animationCurve = Curves.easeInOut,
    this.percentageTextStyle,
    this.showPercentage = false,
  });

  @override
  State<ExDockGradientProgressBar> createState() =>
      _ExDockGradientProgressBarState();
}

class _ExDockGradientProgressBarState extends State<ExDockGradientProgressBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final double clampedProgress = widget.progress.clamp(0.0, 1.0);
        final double currentWidth = maxWidth * clampedProgress;

        final int percentage = (clampedProgress * 100).round();

        final BorderRadius effectiveBorderRadius =
            widget.borderRadius ?? BorderRadius.circular(widget.height / 2);

        return Container(
          width: maxWidth,
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: effectiveBorderRadius,
          ),
          child: ClipRRect(
            borderRadius: effectiveBorderRadius,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: widget.gradientColors,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ).createShader(
                        Rect.fromLTWH(0, 0, maxWidth, bounds.height));
                  },
                  blendMode: BlendMode.srcATop,
                  child: AnimatedContainer(
                    duration: widget.animationDuration,
                    curve: widget.animationCurve,
                    width: currentWidth,
                    height: widget.height,
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                ),

                // Percentage Text
                if (widget.showPercentage)
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '$percentage%',
                      style: widget.percentageTextStyle ??
                          TextStyle(
                            color: Colors.white,
                            fontSize: math.max(widget.height * 0.5, 10.0),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 2,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
