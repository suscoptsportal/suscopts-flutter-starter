import 'package:flutter/material.dart';
import 'package:suscopts_flutter_starter/library/user.dart';
import 'dart:async';

class HomePage extends StatefulWidget {

  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User myUser;

  @override
  initState() {
    super.initState();
    (() async {
      var temp = await SavedUser();
      setState(() {    
        myUser = temp;  
      });
    }());
    // Future<User> myuser = SavedUser();
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: Text('MAIN PAGE', style: TextStyle(color: Colors.white)),
      ),
      body: new Container(
      
        child:
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Expanded(
                Column(children: <Widget>[
                  Center(child: new Text("Take it from here. Good Luck with your creation. Welcome ${myUser}")),
                  Padding(
                    padding: EdgeInsets.all(20.0), 
                    child: RaisedButton(
                      child: Text('Sign Out'), 
                      onPressed: onPressed
                    )
                  )
                ])
              // )
            ]

          ),

      ),

    );
  }

  Future onPressed()  async {
    SignOut();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', ModalRoute.withName('/login'));
  }
}