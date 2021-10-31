//@dart = 2.9

import 'package:flutter/cupertino.dart';

import 'constants.dart';

class CustomText extends StatelessWidget {

  final String text;
  final Color color;
  final double size;

  CustomText({this.text, this.color = white, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
      textAlign: TextAlign.center,
    );
  }

}

class CustomButton extends StatefulWidget {

  final double width;
  final String text;
  final VoidCallback onPress;

  CustomButton({this.width, this.text, this.onPress,});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  bool isPressedDown = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) => setState(() => isPressedDown = true),
      onPointerUp: (event) => setState(() => isPressedDown = false),
      onPointerCancel: (event) => setState(() => isPressedDown = false),
      child: GestureDetector(
        onTap: widget.onPress,
        child: AnimatedOpacity(
          opacity: isPressedDown ? 0.6 : 1,
          duration: Duration(milliseconds: isPressedDown ? 10 : 100),
          child: Container(
            height: 65,
            width: widget.width,
            decoration: BoxDecoration(
              color: dark,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: CustomText(
                text: widget.text,
                color: white,
                size: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class CustomTextField extends StatefulWidget {

  final TextEditingController controller;
  final String placeholder;

  CustomTextField({this.controller, this.placeholder});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTextField(
          cursorColor: CupertinoTheme.of(context).primaryColor,
          controller: widget.controller,
          style: TextStyle(
            fontSize: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: white,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(11),
          ),
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          placeholder: widget.placeholder,
          placeholderStyle: TextStyle(
            color: white.withAlpha(220),
            fontSize: 20,
          ),
        ),
      ],
    );
  }

}

class CustomDialog extends StatelessWidget {

  final Widget child;
  final String title;

  CustomDialog(this.title, this.child);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: MediaQuery.of(context).viewInsets,
      duration: Duration(milliseconds: 200),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(),
                          Align(
                            alignment: Alignment.center,
                            child: _title(context),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: child == null ? 0 : 15),
                    child ?? Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return CustomText(
      text: title,
      color: dark,
      size: 25,
    );
  }

}

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

class CustomModalDatePicker extends StatefulWidget {

  final DateTime initialDateTime;
  final CupertinoDatePickerMode mode;

  CustomModalDatePicker({DateTime initialDateTime, this.mode = CupertinoDatePickerMode.dateAndTime})
      : initialDateTime = initialDateTime ?? DateTime.now();

  @override
  _CustomModalDatePickerState createState() => _CustomModalDatePickerState();
}

class _CustomModalDatePickerState extends State<CustomModalDatePicker> {

  DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = widget.initialDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      padding: EdgeInsets.only(top: 6.0),
      color: white,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {},
                child: CupertinoDatePicker(
                  initialDateTime: widget.initialDateTime,
                  mode: widget.mode,
                  onDateTimeChanged: (dt) => dateTime = dt,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
              child: CustomButton(
                text: "Select",
                onPress: () => Navigator.of(context).pop(dateTime),
              ),
            )
          ],
        ),
      ),
    );
  }
}