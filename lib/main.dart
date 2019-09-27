import 'package:flutter/material.dart';

import 'pages/contact/contact-view.dart';
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
    ContactViewPage.tag: (context) => ContactViewPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Contacts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
      routes: routes,
    );
  }
}
