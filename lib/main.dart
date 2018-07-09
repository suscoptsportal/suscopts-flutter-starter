import 'package:flutter/material.dart';
import 'package:suscopts_flutter_starter/pages/login.dart';
import 'package:suscopts_flutter_starter/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUSCOPTS starter',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => new LoginPage(),
        '/home': (BuildContext context) => new HomePage()
      },
      home: new LoginPage(),
    );
  }
}


