import 'package:drunk_proj/data.dart';

String baseURL = "";

void createUser() {
  String name = UserData.instance.name;
  String number = UserData.instance.number;
  // TODO api call
}

void addContacts() {
  ContactInfo primary = UserData.instance.primary;
  List<ContactInfo> secondaries = UserData.instance.secondaries;
  // TODO api call
}