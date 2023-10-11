import 'package:flutter/material.dart';

class ButtonSlideAnimationComponent extends StatefulWidget {
  const ButtonSlideAnimationComponent(
      {required this.onPressed,
      this.height = 40,
      this.width = 300,
      this.content = const Text(
        'Conteúdo',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      this.color = Colors.purpleAccent,
      this.slideColor = Colors.purple,
      this.iconSize = 24,
      this.icon = Icons.check_circle_outline_rounded,
      this.slideDuration = const Duration(milliseconds: 200),
      this.completedAnimation = const Duration(milliseconds: 500),
      this.borderRadius = 5,
      Key? key})
      : super(key: key);
  final double height;
  final double width;
  final Color color;
  final Color slideColor;
  final double iconSize;
  final Widget content;
  final IconData icon;
  final Duration slideDuration;
  final Duration completedAnimation;
  final double borderRadius;

  final void Function() onPressed;

  @override
  State<ButtonSlideAnimationComponent> createState() =>
      _ButtonSlideAnimationComponentState();
}

class _ButtonSlideAnimationComponentState
    extends State<ButtonSlideAnimationComponent> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isPressed = true;
            widget.onPressed();
          });
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius),
                ),
              ),
              height: widget.height,
              width: widget.width,
              child: Center(
                child: widget.content,
              ),
            ),
            AnimatedContainer(
              duration: widget.slideDuration,
              decoration: BoxDecoration(
                color: widget.slideColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(widget.borderRadius),
                ),
              ),
              width: isPressed ? widget.width : 0,
              height: widget.height,
            ),
            AnimatedPositioned(
              child: isPressed
                  ? Icon(
                      widget.icon,
                      color: Colors.white,
                      size: widget.iconSize,
                    )
                  : const SizedBox(),
              duration: widget.completedAnimation,
              top: isPressed
                  ? (widget.height / 2) - (widget.iconSize / 2)
                  : widget.height,
              left: (widget.width / 2) - (widget.iconSize / 2),
              curve: Curves.bounceOut,
            ),
          ],
        ),
      ),
    );
  }
}
