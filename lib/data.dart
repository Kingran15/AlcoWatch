class UserData {

  static final instance = UserData();

  String name;
  String number;
  ContactInfo primary;
  List<ContactInfo> secondaries = [];

}

class ContactInfo {

  final String name;
  final String number;

  ContactInfo(this.name, this.number);

}