import 'package:flutter/material.dart';
import 'pages/contact/contact-add.dart';
import 'pages/search/search.dart';

class Layout {
  static List<Widget> _getActions(BuildContext context) {
    List<Widget> items = List<Widget>();

    items.add(IconButton(
        icon: Icon(Icons.add),
        color: dark(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactAddPage()),
          );
        }));

    items.add(IconButton(
      icon: Icon(Icons.search),
      color: dark(),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      },
    ));

    items.add(IconButton(
      icon: Icon(Icons.more_vert),
      color: dark(),
      onPressed: () {},
    ));

    return items;
  }

  static Scaffold getContent(BuildContext context, content,
      [bool showButtonBar = false]) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: new Color(0xFFf5f5f5),
        elevation: 0.5,
        title: Text(
          "Telefone",
          style: TextStyle(
            color: dark(),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: showButtonBar ? _getActions(context) : [],
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return content;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            title: Text('Recentes'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Contatos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favoritos'),
          ),
        ],
      ),
    );
  }

  static Color primary([double opacity = 1]) =>
      Color.fromRGBO(62, 63, 89, opacity);
  static Color secondary([double opacity = 1]) =>
      Color.fromRGBO(150, 150, 150, opacity);
  static Color light([double opacity = 1]) =>
      Color.fromRGBO(242, 246, 247, opacity);
  static Color dark([double opacity = 1]) =>
      Color.fromRGBO(51, 51, 51, opacity);
}
