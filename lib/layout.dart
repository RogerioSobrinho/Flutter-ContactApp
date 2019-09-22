import 'package:flutter/material.dart';

import 'pages/about/about.dart';
import 'pages/create/create.dart';
import 'pages/home/home.dart';
import 'pages/search/search.dart';

class Layout {
  static FloatingActionButton _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreatePage()),
        );
      },
      child: Icon(Icons.add),
    );
  }

  static List<Widget> _getActions(BuildContext context) {
    List<Widget> items = List<Widget>();
    items.add(IconButton(
      icon: Icon(Icons.search),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      },
    ));
    return items;
  }

  static Drawer _getDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text("rogerioa.sobrinho@gmail.com"),
            accountName: Text("Rogerio Sobrinho"),
            currentAccountPicture: CircleAvatar(
              child: Text("R"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(HomePage.tag);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About Us"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  static Scaffold getContent(BuildContext context, content,
      [bool showButtonSearch = false, bool showButtonAdd = false]) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary(),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text("Contacts"),
        actions: showButtonSearch ? _getActions(context) : [],
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return content;
        },
      ),
      floatingActionButton:
          showButtonAdd ? _floatingActionButton(context) : null,
      drawer: _getDrawer(context),
    );
  }

  static Color primary([double opacity = 1]) =>
      Color.fromRGBO(62, 63, 89, opacity);
  static Color secondary([double opacity = 1]) =>
      Color.fromRGBO(150, 150, 150, opacity);
  static Color light([double opacity = 1]) =>
      Color.fromRGBO(242, 234, 228, opacity);
  static Color dark([double opacity = 1]) =>
      Color.fromRGBO(51, 51, 51, opacity);

  static Color danger([double opacity = 1]) =>
      Color.fromRGBO(217, 74, 74, opacity);
  static Color success([double opacity = 1]) =>
      Color.fromRGBO(5, 100, 50, opacity);
  static Color info([double opacity = 1]) =>
      Color.fromRGBO(100, 150, 255, opacity);
  static Color warning([double opacity = 1]) =>
      Color.fromRGBO(166, 134, 0, opacity);
}
