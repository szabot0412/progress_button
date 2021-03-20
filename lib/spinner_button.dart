library spinner_button;

import 'package:flutter/material.dart';

import 'button_stagger_animation.dart';

class SpinnerButton extends StatefulWidget {
  /// The background color of the button.
  final Color color;

  /// The progress indicator color.
  final Color progressIndicatorColor;

  /// The size of the progress indicator.
  final double progressIndicatorSize;

  /// The color of the outer border
  final Color borderColor;

  /// The border radius while NOT animating.
  final BorderRadius borderRadius;

  /// The duration of the animation.
  final Duration animationDuration;

  /// Elevation of the button
  final double? elevation;

  /// The stroke width of progress indicator.
  final double strokeWidth;

  /// Function that will be called at the on pressed event.
  ///
  /// This will grant access to its [AnimationController] so
  /// that the animation can be controlled based on the need.
  final Function(AnimationController? controller) onPressed;

  /// The child to display on the button.
  final Widget child;

  final double? borderWidth;

  SpinnerButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.color = Colors.blue,
    this.strokeWidth = 2,
    this.elevation,
    this.borderWidth,
    this.borderColor = const Color(0xffff5745),
    this.progressIndicatorColor = Colors.white,
    this.progressIndicatorSize = 30,
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  _SpinnerButtonState createState() => _SpinnerButtonState();
}

class _SpinnerButtonState extends State<SpinnerButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ButtonStaggerAnimation(
        controller: _controller.view as AnimationController?,
        color: widget.color,
        borderWidth: widget.borderWidth,
        borderColor: widget.borderColor,
        strokeWidth: widget.strokeWidth,
        progressIndicatorColor: widget.progressIndicatorColor,
        progressIndicatorSize: widget.progressIndicatorSize,
        borderRadius: widget.borderRadius,
        onPressed: widget.onPressed,
        elevation: widget.elevation,
        child: widget.child,
      ),
    );
  }
}
