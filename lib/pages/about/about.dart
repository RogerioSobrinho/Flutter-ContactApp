import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  static String tag = 'about-page';
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us")),
      body: Container(),
    );
  }
}
