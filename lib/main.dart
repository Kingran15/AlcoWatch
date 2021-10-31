import 'dart:async';

import 'package:drunk_proj/api_calls.dart' as api;
import 'package:drunk_proj/constants.dart';
import 'package:drunk_proj/data.dart';
import 'package:drunk_proj/functions.dart';
import 'package:drunk_proj/puzzle.dart';
import 'package:drunk_proj/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:geolocator/geolocator.dart';


void main() {
  runApp(AlcoWatch());
}

class AlcoWatch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child,
      ),
      home: Welcome(),
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: background,
        primaryColor: background,
        textTheme: textTheme,
      ),
      debugShowCheckedModeBanner: false,
    );
  }

}

class Welcome extends StatelessWidget {

  final name = new TextEditingController();
  final number = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: background,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              SizedBox(height: 140,),
              CustomText(
                text: "AlcoWatch",
                color: white,
                size: 50,
              ),
              CustomText(
                text: "Know when you’re tipsy,\nwhile others monitor your safety.",
                color: white,
                size: 20,
              ),
              SizedBox(height: 50,),
              CustomTextField(
                controller: name,
                placeholder: "Full Name",
              ),
              SizedBox(height: 20,),
              CustomTextField(
                controller: number,
                placeholder: "Phone Number",
                isNumber: true,
              ),
              SizedBox(height: 200,),
              CustomButton(
                text: "Get Started",
                onPress: () {
                  UserData.instance.name = name.text;
                  UserData.instance.number = number.text;
                  api.createUser();
                  push(AddContacts(), context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class AddContacts extends StatefulWidget {

  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {

  Contact primary;
  List<Contact> secondaries = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 140,),
            CustomText(
              text: "AlcoWatch",
              color: white,
              size: 50,
            ),
            CustomText(
              text: "Add your emergency contacts.",
              color: white,
              size: 20,
            ),
            SizedBox(height: 50,),
            primaryContactSelector(),
            SizedBox(height: 5,),
            CustomText(
              text: "Text and call this contact.",
              size: 20,
            ),
            SizedBox(height: 25,),
            secondaryContactsSelector(),
            SizedBox(height: 5,),
            CustomText(
              text: "Only text these contacts.",
              size: 20,
            ),
            Spacer(),
            CustomButton(
              text: "Continue",
              onPress: () {
                UserData.instance.secondaries.addAll(
                  secondaries.map<ContactInfo>((c) => ContactInfo(c.displayName, c.phones[0].number))
                );
                UserData.instance.primary = ContactInfo(primary.displayName, primary.phones[0].number);
                api.addContacts();
                push(ChooseSobrietyTest(), context);
              },
            ),
            SizedBox(height: 85,)
          ],
        ),
      ),
    );
  }

  Widget primaryContactSelector() => Builder(
    builder: (context) => GestureDetector(
      onTap: () async {
        if (await FlutterContacts.requestPermission()) {
          var list = [primary];
          await showCustomDialog(
            context,
            CustomDialog(
              "Primary Contact",
              ChooseContacts(
                true,
                await FlutterContacts.getContacts(withProperties: true),
                list,
              ),
            ),
          );
          setState(() {
            primary = list[0];
          });
        }
      },
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: white,
            width: 4,
          ),
        ),
        child: Center(
          child: CustomText(
            text: primary?.displayName ?? "Primary Contact",
            color: white,
            size: 20,
          ),
        ),
      ),
    ),
  );

  Widget secondaryContactsSelector() => GestureDetector(
    onTap: () async {
      if (await FlutterContacts.requestPermission()) {
        await showCustomDialog(
          context,
          CustomDialog(
            "Secondary Contacts",
            ChooseContacts(
              false,
              await FlutterContacts.getContacts(withProperties: true),
              secondaries,
            ),
          ),
        );
        setState(() {});
      }
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: white,
          width: 4,
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: secondaries.isNotEmpty ? 10 : 20),
          child: CustomText(
            text: secondaries.isEmpty ? "Secondary Contacts" : names(),
            color: white,
            size: 20,
          ),
        ),
      ),
    ),
  );

  String names() {
    var string = "";
    for (Contact c in secondaries) string += c.displayName + '\n';
    return string.substring(0, string.length - 1);
  }
}

class ChooseContacts extends StatefulWidget {

  final bool chooseOne;
  final List<Contact> contacts;
  final List<Contact> selected;

  ChooseContacts(this.chooseOne, this.contacts, this.selected);

  @override
  _ChooseContactsState createState() => _ChooseContactsState();
}

class _ChooseContactsState extends State<ChooseContacts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: verticalSpace(10, widget.contacts.map<Widget>((contact) => GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.selected.contains(contact)) {
                      widget.selected.remove(contact);
                    } else {
                      if (widget.chooseOne) {
                        widget.selected[0] = contact;
                      } else {
                        widget.selected.add(contact);
                      }
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: !widget.selected.contains(contact) ? white : background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: CustomText(
                      text: contact.displayName,
                      size: 18,
                      color: !widget.selected.contains(contact) ? background : white,
                    ),
                  ),
                ),
              )).toList()),
            ),
          ),
        ),
        SizedBox(height: 20,),
        CustomButton(
          text: "Done",
          onPress: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class ChooseSobrietyTest extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 140,),
            CustomText(
              text: "AlcoWatch",
              color: white,
              size: 50,
            ),
            CustomText(
              text: "Select a sobriety test.",
              color: white,
              size: 20,
            ),
            SizedBox(height: 50,),
            CustomButton(
              text: "Balance Test",
              onPress: () => push(SelectTime(true), context),
            ),
            SizedBox(height: 5,),
            CustomText(
              text: "Stand on one leg while\nmaintaining your balance.",
              size: 20,
            ),
            SizedBox(height: 50,),
            CustomButton(
              text: "Memory Test",
              onPress: () => push(SelectTime(false), context),
            ),
            SizedBox(height: 5,),
            CustomText(
              text: "Complete a memory puzzle.",
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

}

class SelectTime extends StatefulWidget {

  final bool isBalanceTest;

  SelectTime(this.isBalanceTest);

  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {

  DateTime time;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 140,),
            CustomText(
              text: "AlcoWatch",
              color: white,
              size: 50,
            ),
            CustomText(
              text: "Select a time to take the test.",
              color: white,
              size: 20,
            ),
            SizedBox(height: 50,),
            timeSelector(),
            SizedBox(height: 5,),
            CustomText(
              text: "You will have to successfully\ncomplete the chosen test\nat this time.",
              size: 20,
            ),
            Spacer(),
            CustomButton(
              text: "Finish",
              onPress: () {
                api.createAlarm(time.millisecond - DateTime.now().millisecondsSinceEpoch);
                push(Countdown(widget.isBalanceTest, time), context);
              },
            ),
            SizedBox(height: 85,)
          ],
        ),
      ),
    );
  }

  Widget timeSelector() => Builder(
    builder: (context) => GestureDetector(
      onTap: () async {
        var value = await showModalPicker(context, CustomModalDatePicker(initialDateTime: DateTime.now(), mode: CupertinoDatePickerMode.dateAndTime,));
        if (value != null) {
          setState(() => time = value);
        }
      },
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: white,
            width: 4,
          ),
        ),
        child: Center(
          child: CustomText(
            text: time == null ? "Select Time" : displayTime(time.hour, time.minute),
            color: white,
            size: 20,
          ),
        ),
      ),
    ),
  );
}

class Countdown extends StatefulWidget {

  final bool isBalanceTest;
  final DateTime end;

  Countdown(this.isBalanceTest, this.end);

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 140,),
            CustomText(
              text: "AlcoWatch",
              color: white,
              size: 50,
            ),
            CustomText(
              text: "Your test will begin when the timer finishes.",
              color: white,
              size: 20,
            ),
            SizedBox(height: 50,),
            CountdownTimer(
              endTime: widget.end.millisecondsSinceEpoch + 1000 * 30,
              onEnd: onEnd,
              textStyle: TextStyle(
                fontSize: 60,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void onEnd() {
    if (widget.isBalanceTest) {
      // TODO do the balance test
    } else {
      push(Puzzle(maxTries), context);
    }
  }
}

class Result extends StatelessWidget {

  final bool passed;

  const Result(this.passed);

  @override
  Widget build(BuildContext context) {
    if(!passed) {
      Timer.periodic(
          const Duration(seconds: 15), (Timer t) => _sendLocationData());
    }

    return CupertinoPageScaffold(
      backgroundColor: background,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 140,),
            CustomText(
              text: "AlcoWatch",
              color: white,
              size: 50,
            ),
            CustomText(
              text: passed ?
                "You passed the test!\nYou aren’t drunk enough to need help." :
                "You failed the test!\nYour contacts have been notified.",
              color: white,
              size: 30,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void _sendLocationData() {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 10)
    ).then((pos) {
      if(pos != null && pos.latitude != null && pos.longitude != null) {
        api.updateLocation(pos.latitude, pos.longitude);
      }
    });
  }
}
