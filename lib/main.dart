import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'startup.dart';
import 'search.dart';
import 'park.dart';

void main() => runApp(MaterialApp(home: MyApp()));

int parkNum = 0;
Park currentPark = parkList[parkNum];

final _auth = FirebaseAuth.instance;

class Connect extends StatefulWidget {
  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Color ageActivityColor = Colors.white;

  @override
  void initState(){
    super.initState();
    getCurrentUser();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    controller.forward();
    controller.addListener((){
      setState(() {
      });
    });
    Timer(Duration(milliseconds: 500), (){
      setState(() {
        ageActivityColor = Colors.black;
      });
    });
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
              icon: Icon(Icons.explore, color: Colors.white,),
              onPressed: () async {
                if(currentPark.address != null){
                  await MapsLauncher.launchQuery(currentPark.address);
                }
                else {
                  await MapsLauncher.launchQuery(currentPark.title);
                }
              }
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: (){
                setState(() {
                  dropdown = !dropdown;
                });
              },
            ),
            SizedBox(width: 10,)
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Container(color: Colors.black,)),
                  dropdown ? Container(
                    height: 48,
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
              SizedBox(height: 20,),
              Text(currentPark.title,style: TextStyle(fontSize: 43,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(controller.value)),),
              GestureDetector(child: Text('Change park',style: TextStyle(decoration:TextDecoration.underline,fontSize:15,color: Colors.blue.withOpacity(controller.value)),),onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
              },),
              SizedBox(height: 30,),
              Row(
                children: <Widget>[
                  SizedBox(width: controller.value * 65,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Age Groups',style: TextStyle(fontSize: 23,color: ageActivityColor,decoration: TextDecoration.underline),),
                      SizedBox(height: 10,),
                      Text('  - ' + currentPark.ageGroupsList[0] + ' \n  - ' + currentPark.ageGroupsList[1], style: TextStyle(fontSize: 15,color: ageActivityColor,),),
                    ],
                  ),
                  Expanded(child: SizedBox(width: 60,)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Activities',style: TextStyle(fontSize: 23,color: ageActivityColor,decoration: TextDecoration.underline),),
                      SizedBox(height: 10,),
                      Text('  - ' + currentPark.activitiesList[0] + '\n  - ' + currentPark.activitiesList[1], style: TextStyle(fontSize: 15,color: ageActivityColor),)
                    ],
                  ),
                  SizedBox(width: controller.value * 65,)
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: RaisedButton(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.explore),
                      Text('Directions'),
                    ],
                  ),
                  onPressed: null
                ),
              )
            ],
          )
        ),
      );
  }
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void initState(){
    super.initState();
    Timer(Duration(milliseconds: 1750), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Connect()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100,),
              Center(
                child: Image.asset('images/loadingImage.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: CircularProgressIndicator(backgroundColor: Colors.white,),
              )
            ],
          ),
        ),
        backgroundColor: Colors.lightBlue[800],
    );
  }
}

