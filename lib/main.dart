import 'package:flutter/material.dart';

import 'pages/home/home.dart';
import 'pages/create/create.dart';
import 'pages/search/search.dart';
import 'pages/about/about.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    AboutPage.tag: (context) => AboutPage(),
    SearchPage.tag: (context) => SearchPage(),
    CreatePage.tag: (context) => CreatePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: routes,
    );
  }
}
