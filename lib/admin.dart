import 'package:flutter/material.dart';

class AdminPassword extends StatelessWidget {

  String adminPassword = 'B00g00B00g00';
  incorrectPassword(BuildContext context,){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Text('That password is incorrect. Please try again.'),
        actions: <Widget>[
          MaterialButton(
            child: Text('OK'),
            elevation: 5.0,
            onPressed: (){
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
      appBar: AppBar(
        title: Text('Admin'),),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom:15,top: 20),
              child: Text('Enter password below',style: TextStyle(fontSize: 25),),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Password',
                ),
                onSubmitted: (value){
                  if (value == adminPassword){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Admin())
                    );
                  }
                  else{
                    incorrectPassword(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin'),),
    );
  }
}
