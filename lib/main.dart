import 'package:flutter/material.dart';

import 'pages/contact/contact-edit.dart';
import 'pages/home/home.dart';
import 'pages/contact/contact-add.dart';
import 'pages/search/search.dart';
import 'pages/about/about.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    AboutPage.tag: (context) => AboutPage(),
    SearchPage.tag: (context) => SearchPage(),
    ContactAddPage.tag: (context) => ContactAddPage(),
    ContactEditPage.tag: (context) => ContactEditPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Contacts',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
        hintColor: Colors.black,
      ),
      home: HomePage(),
      routes: routes,
    );
  }
}
