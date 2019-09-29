import 'package:exemplo/src/about/about_page.dart';
import 'package:flutter/material.dart';
import 'package:exemplo/src/home/home_module.dart';
import 'home/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      HomePage.tag: (context) => HomePage(),
      // SearchPage.tag: (context) => SearchPage(),
      // ContactAddPage.tag: (context) => ContactAddPage(),
      // ContactViewPage.tag: (context) => ContactViewPage(),
    };
    return MaterialApp(
      title: 'Flutter Slidy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomeModule(),
      routes: routes,
    );
  }
}
