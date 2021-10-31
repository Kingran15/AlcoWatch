import 'dart:convert';

import 'package:drunk_proj/data.dart';
import 'package:drunk_proj/functions.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

void createUser() {
  String name = UserData.instance.name;
  String number = UserData.instance.number;

  http.post(
    Uri.parse(baseURL + "createUser"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'number': rawPhoneNumber(number),
      'hash': hash
    })
  ).then((value) => print(value.body));
}

void addContacts() {
  String name = UserData.instance.name;
  ContactInfo primary = UserData.instance.primary;
  List<ContactInfo> secondaries = UserData.instance.secondaries;

  List<String> names = [primary.name];
  List<String> numbers = [rawPhoneNumber(primary.number)];

  for (var contact in secondaries) {
    names.add(contact.name);
    numbers.add(rawPhoneNumber(contact.number));
  }

  http.post(
      Uri.parse(baseURL + "addContact"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'hash': hash,
        'contactName': names,
        'contactNumber': numbers
      })
  ).then((value) => {print("User Response: " + value.body)});
}

void sendMessage() {
  String name = UserData.instance.name;

  http.post(
    Uri.parse(baseURL + "sendMessage"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'hash': hash,
      })
  );
}

void updateLocation(double lat, double long) {
  String name = UserData.instance.name;

  http.post(
      Uri.parse(baseURL + "updateLocation"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'hash': hash,
        'lat': lat,
        'long': long
      })
  );
}

void createAlarm(int milliTime) {
  String name = UserData.instance.name;

  http.post(
      Uri.parse(baseURL + "createAlarm"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'hash': hash,
        'amountTime': milliTime
      })
  );
}