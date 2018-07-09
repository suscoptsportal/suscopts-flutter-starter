import 'package:meta/meta.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String name;
  final String token;

  User({
    @required this.name,
    @required this.token
  });

  @override
  String toString() {
    return this.name;
  }

  String getToken() {
    return "bearer "+this.token;
  }

}

Future SignOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
  prefs.remove('name');
}

User MapUser(Map<String, dynamic> map) {
  return new User(
    name: map['name'],
    token: map['token'],
  );
}

Future<User> SavedUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  User temp = MapUser({'name': prefs.getString('name'), 'token': prefs.getString('token')});
  return temp;
}