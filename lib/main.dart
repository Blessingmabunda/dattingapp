import 'package:datingapp/pages/male/private/home.dart';
import 'package:datingapp/pages/male/private/home/view_services.dart';
import 'package:datingapp/pages/male/private/requests.dart';
import 'package:datingapp/pages/public/login.dart';
import 'package:datingapp/pages/public/sign_in.dart';
import 'package:datingapp/pages/public/welcome_page.dart';
import 'package:flutter/material.dart';
// import 'welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),

      // Use the static routeName from WelcomePage
      initialRoute: WelcomePage.routeName,

      routes: {
        WelcomePage.routeName: (context) => WelcomePage(),
        SignUp.routeName: (context) => SignUp(),
        Login.routeName: (context) => Login(),
        Home.routeName: (context) => Home(),

        //view services
        ViewService.routeName: (context) => ViewService(),
        //requests
        Requests.routeName: (context) => Requests(),

      },
    );
  }
}
