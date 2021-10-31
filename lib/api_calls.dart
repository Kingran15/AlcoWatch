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
  String number = UserData.instance.number;
  ContactInfo primary = UserData.instance.primary;
  List<ContactInfo> secondaries = UserData.instance.secondaries;

  List<String> names = [primary.name];
  List<String> numbers = [primary.number];

  secondaries.map((contact) {
    names.add(contact.name);
    numbers.add(contact.number);
  });

  http.post(
      Uri.parse(baseURL + "addContacts"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'number': rawPhoneNumber(number),
        'hash': hash,
        'contactName': names,
        'contactNumber': numbers
      })
  ).then((value) => print("User Response: " + value.body));
}