//@dart = 2.9

import 'package:flutter/cupertino.dart';

import 'constants.dart';

class MemoryButton extends StatefulWidget {
  final int index;
  final IconData icon;

  const MemoryButton(this.index, this.icon, {Key key}) : super(key: key);

  @override
  _MemoryButtonState createState() => _MemoryButtonState();
}

class _MemoryButtonState extends State<MemoryButton> {
  bool pressed = false;

  @override
  void initState() {
    super.initState();
    pressed = false;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: pressed ? blue : lightGray,
      pressedOpacity: 1,
      minSize: 150,
      onPressed: () => _pressAction(),
      child: Icon(
        widget.icon,
        color: black,
      ),
    );
  }

  void _pressAction() {
    if(widget.index > 0) {
      setState(() => pressed = !pressed);
    }
  }
}

class AnimatedTimer extends StatefulWidget {
  const AnimatedTimer({Key key}) : super(key: key);

  @override
  _AnimatedTimerState createState() => _AnimatedTimerState();
}

class _AnimatedTimerState extends State<AnimatedTimer> with TickerProviderStateMixin{
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: AnimatedTimerPainter(
          animation: controller,
          backgroundColor: background,
          color: canvas,
        ));
  }

}

class AnimatedTimerPainter extends CustomPainter {
  AnimatedTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawLine(size.topLeft(Offset.zero), size.topRight(Offset.zero), paint);
    paint.color = color;
    double progress = 1.0 - animation.value;
    canvas.drawLine(size.topLeft(Offset.zero),
        Offset(progress * size.width, size.topRight(Offset.zero).dy), paint);
  }

  @override
  bool shouldRepaint(AnimatedTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
  
}