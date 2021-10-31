import 'package:drunk_proj/constants.dart';
import 'package:flutter/cupertino.dart';

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