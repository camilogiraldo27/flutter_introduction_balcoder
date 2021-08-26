import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum FadeDirection { opacity, top, bottom, right, left }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final FadeDirection fadeDirection;

  const FadeAnimation(
      {Key? key,
      required this.delay,
      required this.child,
      required this.fadeDirection})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(fadeDirection);
    final tween = MultiTween<FadeDirection>()
      ..add(FadeDirection.opacity, 0.0.tweenTo(1.0), 500.milliseconds)
      ..add(FadeDirection.top, (-30.0).tweenTo(0.0), 500.milliseconds,
          Curves.easeOut)
      ..add(FadeDirection.bottom, (30.0).tweenTo(0.0), 500.milliseconds,
          Curves.easeOut)
      ..add(FadeDirection.right, (-30.0).tweenTo(0.0), 500.milliseconds,
          Curves.easeOut)
      ..add(FadeDirection.left, (-30.0).tweenTo(0.0), 500.milliseconds,
          Curves.easeOut);

    return PlayAnimation<MultiTweenValues<FadeDirection>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(FadeDirection.opacity),
        child: Transform.translate(
            offset: Offset(
              (fadeDirection == FadeDirection.top ||
                      fadeDirection == FadeDirection.bottom)
                  ? 0
                  : value.get(fadeDirection) *
                      (fadeDirection == FadeDirection.left ? -1 : 1),
              (fadeDirection == FadeDirection.left ||
                      fadeDirection == FadeDirection.right)
                  ? 0
                  : value.get(fadeDirection) *
                      (fadeDirection == FadeDirection.top ? -1 : 1),
            ),
            child: child),
      ),
    );
  }
}
