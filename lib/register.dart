import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final _auth = FirebaseAuth.instance;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email;
  String password;
  bool showSpinner = false;
  wrongAccount(BuildContext context,){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text('You incorrectly entered your email or password. Please try again.'),
        actions: <Widget>[
          MaterialButton(
            child: Text('OK'),
            elevation: 5.0,
            onPressed: (){
              setState(() {
                showSpinner = false;
              });
              Navigator.of(context).pop();
            },
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create account'),),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
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
                            Text('Sign up with google')
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
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Connect())
                        );
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    }
                    catch (e) {
                      print(e);
                      wrongAccount(context);
                    }
                  },
                  child: Text('Create'),
                )
              ],
            )
        ),
      ),
    );
  }
}