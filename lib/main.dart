import 'package:ParKonnect/add_park.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'startup.dart';
import 'search.dart';
import 'park.dart';
import 'feedback.dart';
import 'settings.dart';

void main() => runApp(MaterialApp(home: MyApp()));

int parkNum = 1;
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
      else{
        Navigator.push(context,MaterialPageRoute(builder: (context) => Startup()));
      }
    }
    catch(e){
      Navigator.push(context,MaterialPageRoute(builder: (context) => Startup()));
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[800],
          leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed:() {
              setState(() {

              });
            },
          ),
          title: Text('ParKonnect'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add, color: Colors.white,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPark()));
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Container(color: Colors.black,)),
                  dropdown ? Row(
                    children: <Widget>[
                      Container(
                        color: Colors.lightBlue[800],
                        child: Column(
                          children: <Widget>[
                            FlatButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings())
                                );
                              },
                              child: Text('Settings'),
                            )
                          ],
                        ),
                      ),
                      Container(width: 1, color: Colors.lightBlue,),
                      Container(
                        color: Colors.lightBlue[800],
                        child: Column(
                          children: <Widget>[
                            FlatButton(
                              onPressed: (){
                                _auth.signOut();
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Startup())
                                );
                              },
                              child: Text('Log out'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ):SizedBox(height: 48,),
                ],
              ),
              SizedBox(height: 20,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.lightBlue[800],borderRadius: BorderRadius.all(Radius.circular(15))),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(currentPark.title,textAlign:TextAlign.center,style: TextStyle(fontSize: 70,fontWeight: FontWeight.bold,color: Colors.black.withOpacity(controller.value)),),
                      GestureDetector(child: Text('Change park',style: TextStyle(decoration:TextDecoration.underline,fontSize: 20,color: Colors.white),),onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
                      },),
                      SizedBox(height: 45,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('Suggested\nAge Groups',textAlign:TextAlign.center,style: TextStyle(fontSize: 30,color: ageActivityColor,decoration: TextDecoration.underline),),
                              SizedBox(height: 10,),
                              Text('- ${currentPark.ageGroupsList[0]}\n- ${currentPark.ageGroupsList[1]}', style: TextStyle(fontSize: 20,color: ageActivityColor,),),
                            ],
                          ),
                          SizedBox(width: 20,),
                          Column(
                            children: <Widget>[
                              Text('Supported\nActivities',textAlign:TextAlign.center,style: TextStyle(fontSize: 30,color: ageActivityColor,decoration: TextDecoration.underline),),
                              SizedBox(height: 10,),
                              Text('- ${currentPark.activitiesList[0]}\n- ${currentPark.activitiesList[1]}', style: TextStyle(fontSize: 20,color: ageActivityColor),)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset('images/${currentPark.title.replaceAll(' ', '')}.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,),
                child: RaisedButton(
                  color: Colors.lightBlue[800].withOpacity(controller.value),
                  padding: EdgeInsets.fromLTRB(25,13,13,13),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.explore,color: Colors.white,),
                      SizedBox(width: 10,),
                      Text('Take me there',style: TextStyle(fontSize: 20, color: Colors.white),),
                    ],
                  ),
                  onPressed: ()async{
                    if(currentPark.address != null){
                      await MapsLauncher.launchCoordinates(currentPark.address[0], currentPark.address[1]);
                    }
                    else {
                      await MapsLauncher.launchQuery(currentPark.title);
                    }
                  }
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(child: Text('Feedback?',style: TextStyle(decoration:TextDecoration.underline,fontSize:15,color: Colors.lightBlue[800].withOpacity(controller.value)),),onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
              },),
              SizedBox(height: 30,)
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
    Timer(Duration(milliseconds: 1500), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Connect()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:Column(
            children: <Widget>[
              SizedBox(height: 100,),
              Center(
                child: Image.asset('images/LoadingImage.png'),
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

