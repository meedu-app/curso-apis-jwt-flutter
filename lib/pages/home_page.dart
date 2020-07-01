import 'package:flutter/material.dart';
import 'package:flutter_api_rest/utils/auth.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text("Log Out"),
          onPressed: () => Auth.instance.logOut(context),
        ),
      ),
    );
  }
}
