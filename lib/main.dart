import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'startup.dart';
import 'change_park.dart';

void main() => runApp(MyApp());

final _auth = FirebaseAuth.instance;

class Connect extends StatefulWidget {
  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> with SingleTickerProviderStateMixin {

  AnimationController controller;

  @override
  void initState(){
    super.initState();
    getCurrentUser();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: _ConnectState(),
    );
  }
  FirebaseUser loggedInUser;
  bool dropdown = false;
  void getCurrentUser() async {
    try{
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    }
    catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed:() {
              setState(() {

              });
            },
          ),
          title: Text('Parkonnect'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: (){
                setState(() {
                  dropdown = !dropdown;
                });
              },
            ),
            SizedBox(width: 20,)
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  dropdown ? Container(
                    color: Colors.lightBlue,
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          onPressed: (){
                            _auth.signOut();
                            loggedIn = false;
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Startup())
                            );
                          },
                          child: Text('Log out'),
                        )
                      ],
                    ),
                  ):SizedBox(height: 48,),
                ],
              ),
              SizedBox(height: 40,),
              Text('Brookside Park',style: TextStyle(fontSize: 43,fontWeight: FontWeight.bold),),
              GestureDetector(child: Text('Change park',style: TextStyle(color: Colors.blue),),onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePark()));
              },),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Age Groups',style: TextStyle(fontSize: 23),),
                      Container(height: 1.5,width: 120,color: Colors.black,),
                      SizedBox(height: 10,),
                      Text('- Preschool \n- Elementary  ', style: TextStyle(fontSize: 15),),
                    ],
                  ),
                  SizedBox(width: 60,),
                  Column(
                    children: <Widget>[
                      Text('Activities',style: TextStyle(fontSize: 23),),
                      Container(height: 1.5,width: 100,color: Colors.black,),
                      SizedBox(height: 10,),
                      Text('- Preschool \n- Elementary  ', style: TextStyle(fontSize: 15),)
                    ],
                  ),
                ],
              ),
            ],
          )
        ),
      );
  }
}

