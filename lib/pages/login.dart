import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suscopts_flutter_starter/library/general_api.dart';
import 'package:suscopts_flutter_starter/library/user.dart';
import 'dart:async';
import 'dart:convert';

class LoginPage extends StatefulWidget {

  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  

  bool loggedIn = false;
  String _email, _password;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();


  @override
  initState() {
    super.initState();
    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // print(prefs.getString('token'));
      if (prefs.getString('token') != null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
      }
    })();
    // Future<User> myuser = SavedUser();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: mainKey,
      appBar: AppBar(title: Text("SUSCOPTS APP STARTER")),
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(children: <Widget>[
                CircleAvatar(backgroundImage: new AssetImage('img/jesus.jpg')),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: "Email",
                        ),
                        validator: (str) =>
                            !str.contains('@') || !str.contains('.') ? "Not a Valid Email!" : null,
                        onSaved: (str) => _email = (str).toLowerCase(),
                      ),
                      TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                        validator: (str) {
                            str.length <= 6 ? "Not a Valid Password!" : null;},
                        onSaved: (str) => _password = str,
                        obscureText: true,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton.icon(
                            color: Colors.green,
                            label: Text("Sign In", style: TextStyle(color: Colors.white),),
                            icon: Icon(Icons.input, color: Colors.white,),
                            onPressed: onPressed,
                          )
                        )
                      )

                    ],
                  ),
                )
          ]))
    );
    
  }


  void onPressed() {
    var form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _onLoading();
    }
  }
  
  Future _onLoading() async {
    Widget snackbar;
    bool passed = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>  FittedBox(child: 
        new Dialog(
          child: Padding(child: Column(
            children: [
              CircularProgressIndicator(),
              Center(child: Text("signing in")),
            ],
          ), padding: EdgeInsets.all(40.0),))
        ),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await login(_email, _password).then((res){
      print(res);
      if (json.decode(res)['status'] == 'success') {

        User temp = MapUser(json.decode(res));
        prefs.setString('token', temp.getToken());
        prefs.setString('name', temp.toString());
        snackbar = SnackBar(
          content: Text('Welcome ${temp.name}'),
          duration: Duration(milliseconds: 2000),
        );
        // prefs.setInt('id', temp.getID());
        passed = true;
        mainKey.currentState.showSnackBar(snackbar);
      } else {
        snackbar = SnackBar(
          content: Text('Error '+json.decode(res)['message']),
          duration: Duration(milliseconds: 2000),
        );
        mainKey.currentState.showSnackBar(snackbar);
        setState(() {
                  _password = '';
                });
      }
    }).catchError((onError){
      snackbar = SnackBar(
        content:
            Text('Invalid Data ... '),
        duration: Duration(milliseconds: 2000),
      );
      print(onError);
      mainKey.currentState.showSnackBar(snackbar);
      
    });
    
    Navigator.pop(context);
    if(passed) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
    }

  }
  
  
}