import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _auth = FirebaseAuth.instance;

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  wrongAccount(BuildContext context,){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text('That account is invalid. Make sure you entered your email and password correctly.'),
        actions: <Widget>[
          MaterialButton(
            child: Text('OK'),
            elevation: 5.0,
            onPressed: (){
              showSpinner = false;
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Email',style: TextStyle(fontSize: 25),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 50),
                  child: TextField(
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter email',
                    ),
                    onChanged: (value){
                      email = value;
                    },
                  ),
                ),
                Text('Password',style: TextStyle(fontSize: 25),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 50),
                  child: TextField(
                    autocorrect: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter password',
                    ),
                    onChanged: (value){
                      password = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 30),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                        onPressed:(){
                          print('hello');
                        },
                        minWidth: 300.0,
                        height: 42.0,
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 20,),
                            Icon(Icons.mail_outline),
                            SizedBox(width: 40,),
                            Text('Sign in with google')
                          ],
                        )
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Connect())
                        );
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    }
                    catch(e){
                      print(e);
                      wrongAccount(context);
                    }
                  },
                  child: Text('Log in'),
                )],
            ),
          ),
        ),
      ),
    );
  }
}
