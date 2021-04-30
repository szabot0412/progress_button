import 'package:flutter/material.dart';

class ButtonStaggerAnimation extends StatelessWidget {
  // Animation fields
  final AnimationController? controller;

  // Display fields
  final Color? color;
  final Color? progressIndicatorColor;
  final double? progressIndicatorSize;
  final BorderRadius? borderRadius;
  final double? strokeWidth;
  final double? borderWidth;
  final Color? borderColor;
  final double? elevation;
  final Function(AnimationController? c)? onPressed;
  final Widget? child;

  ButtonStaggerAnimation({
    Key? key,
    this.controller,
    this.color,
    this.elevation,
    this.progressIndicatorColor,
    this.progressIndicatorSize,
    this.borderRadius,
    this.onPressed,
    required this.borderColor,
    this.strokeWidth,
    this.borderWidth,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _progressAnimatedBuilder);
  }

  Widget? _buttonChild() {
    if (controller!.isAnimating) {
      return Container();
    } else if (controller!.isCompleted) {
      return OverflowBox(
        maxWidth: progressIndicatorSize,
        maxHeight: progressIndicatorSize,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth!,
          valueColor: AlwaysStoppedAnimation<Color?>(progressIndicatorColor),
        ),
      );
    }
    return child;
  }

  AnimatedBuilder _progressAnimatedBuilder(
      BuildContext context, BoxConstraints constraints) {
    var buttonHeight = (constraints.maxHeight != double.infinity)
        ? constraints.maxHeight
        : 60.0;

    var widthAnimation = Tween<double>(
      begin: constraints.maxWidth,
      end: buttonHeight,
    ).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Curves.easeInOut,
      ),
    );

    var borderRadiusAnimation = Tween<BorderRadius>(
      begin: borderRadius,
      end: BorderRadius.all(Radius.circular(buttonHeight / 2.0)),
    ).animate(CurvedAnimation(
      parent: controller!,
      curve: Curves.easeInOut,
    ));

    return AnimatedBuilder(
      animation: controller!,
      builder: (context, child) {
        return SizedBox(
          height: buttonHeight,
          width: widthAnimation.value,
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(elevation),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: borderRadiusAnimation.value,
                side: borderWidth!=null ?
                    BorderSide(
                    color: borderColor ?? Color(0xffff5745),
                    width: borderWidth!)
                    : BorderSide.none,
              )),
              backgroundColor: MaterialStateProperty.all(color),

            ),
            child: _buttonChild(),
            onPressed: () {
              this.onPressed!(controller);
            },
          ),
        );
      },
    );
  }
}