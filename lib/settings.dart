import 'package:flutter/material.dart';

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Settings())
        );
      },
      child: Text('Settings'),
    );
  }
}


class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
