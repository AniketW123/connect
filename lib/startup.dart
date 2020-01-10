import 'package:flutter/material.dart';
import 'register.dart';
import 'log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool loggedIn = false;
final _auth = FirebaseAuth.instance;

class Startup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[800],
        appBar: AppBar(leading:SizedBox(),title: Text('Welcome',),backgroundColor: Colors.lightBlue[800],),
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset('images/LoadingImage.png'),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
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
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 55),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
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
                  ),
                ),
                SizedBox(height: 40,)
              ],
            ),
          )
        ),
      );
  }
}



