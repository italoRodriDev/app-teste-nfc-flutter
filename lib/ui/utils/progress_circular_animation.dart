import 'package:flutter/material.dart';

class ProgressCircularAnimation extends StatefulWidget {
  String label;

  ProgressCircularAnimation({Key? key, required this.label}) : super(key: key);

  @override
  State<ProgressCircularAnimation> createState() =>
      _ProgressCircularAnimationState();
}

class _ProgressCircularAnimationState extends State<ProgressCircularAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    // -> Iniciando animation controller
    animController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          });
    animController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // -> Liberando recursos
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        alignment: Alignment.center,
        child: Column(
          children: [
            CircularProgressIndicator(
              value: animController.value,
              semanticsLabel: 'Carregando',
              strokeWidth: 10.0,
            ),
            const SizedBox(height: 20),
            Text(widget.label)
          ],
        ));
  }
}
