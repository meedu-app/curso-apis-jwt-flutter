import 'package:flutter/material.dart';
import 'package:flutter_api_rest/helpers/dendency_injection.dart';
import 'package:flutter_api_rest/pages/home_page.dart';
import 'package:flutter_api_rest/pages/login_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_rest/pages/register_page.dart';
import 'package:flutter_api_rest/pages/splash_page.dart';

void main() {
  DependencyInjection.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      routes: {
        RegisterPage.routeName: (_) => RegisterPage(),
        LoginPage.routeName: (_) => LoginPage(),
        HomePage.routeName: (_) => HomePage()
      },
    );
  }
}
