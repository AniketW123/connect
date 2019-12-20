import 'package:flutter/material.dart';
import 'register.dart';
import 'log_in.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool loggedIn;
final _auth = FirebaseAuth.instance;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    try{
      final user = _auth.currentUser();
      if (user != null) {
        loggedIn = true;
      }
      else{
        loggedIn = false;
      }
    }
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loggedIn ? Connect():Startup(),
    );
  }
}

class Startup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(leading:SizedBox(),title: Text('Welcome',),),
        body: SafeArea(child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                    onPressed:(){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register())
                      );
                    },
                    minWidth: 300.0,
                    height: 42.0,
                    child: Text('Register')
                ),
              ),
              SizedBox(height: 40,),
              Material(
                elevation: 5.0,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                    onPressed:(){
                      try{
                        final user = _auth.currentUser();
                        if (user != null) {
                          loggedIn = true;
                        }
                        else{
                          loggedIn = false;
                        }
                      }
                      catch(e){
                        print(e);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LogIn())
                      );
                    },
                    minWidth: 300.0,
                    height: 42.0,
                    child: Text('Log in')
                ),
              ),
            ],
          ),
        )),
      );
  }
}



