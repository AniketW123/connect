import 'package:flutter/material.dart';
import 'park.dart';
import 'activities.dart';

String activity = '';
final controller1 = TextEditingController();
final controller2 = TextEditingController();
String whichActBox;

class AdvancedSearch extends StatefulWidget {
  @override
  _AdvancedSearchState createState() => _AdvancedSearchState();
}

class _AdvancedSearchState extends State<AdvancedSearch> {

  void initState(){
    super.initState();
  }

  String lastCheckbox;

  Map<String, bool> checkboxes = {
    'preschool': false,
    'elementary': false,
    'middle': false,
    'high': false,
    'adult': false,
    'senior': false,
    'dark': false,
    'pets': false,
    'sit': false,
  };
  Row checkWithText({String val, String text}) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: checkboxes[val],
            onChanged: (value) {
              setState(() {
                checkboxes[val] = value;
              });
            }
        ),
        Text('$text', style: TextStyle(fontSize: 16),),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.lightBlue[800],title: Text('Advanced Search'),),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 25,),
            Column(
              children: <Widget>[
                Text('Recommended Age Groups', style: TextStyle(fontSize: 23),),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        checkWithText(val: 'preschool', text: 'Preschool  '),
                        checkWithText(val: 'elementary', text: 'Elementary'),
                        checkWithText(val: 'middle', text: 'Middle        '),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        checkWithText(val: 'high', text: 'High         '),
                        checkWithText(val: 'adult', text: 'Adult        '),
                        checkWithText(val: 'senior', text: 'Senior      '),
                      ],
                    ),
                ],),
                SizedBox(height: 20,),
                Text('Main Supported Activities', style: TextStyle(fontSize: 23),),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top:10.0, left: 30),
                        child: TextField(
                          enableInteractiveSelection: false,
                          controller: controller1,
                          onTap: (){
                            setState(() {
                              whichActBox = '1';
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Activities()));
                          },
                          onChanged:(text){
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Activity 1',
                          ),
                        ),
                      ),
                    ),
                    Text('  and  ', style: TextStyle(fontSize: 22),),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top:10.0, right: 30),
                        child: TextField(
                          enableInteractiveSelection: false,
                          controller: controller2,
                          onTap: (){
                            setState(() {
                              whichActBox = '2';
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Activities()));
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Activity 2',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25,),
            Text('Other', style: TextStyle(fontSize: 23),),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: checkWithText(val: 'dark', text: 'Lit in dark')),
                  Expanded(child: checkWithText(val: 'pets', text: 'Pet friendly')),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: checkWithText(val: 'sit', text: 'Places to sit'))
                ],
              ),
            ),
            SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  color: Colors.lightBlue[800],
                  child: Text('Apply filters'),
                  onPressed: (){
                    Navigator.pop(context);
                  }
                ),
                SizedBox(height: 30,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
