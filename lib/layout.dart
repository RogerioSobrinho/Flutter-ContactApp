import 'package:flutter/material.dart';
import 'pages/contact/contact-add.dart';
import 'pages/search/search.dart';

class Layout {
  static List<Widget> _getActions(BuildContext context, bool search) {
    List<Widget> items = List<Widget>();

    if (search) {
      items.add(
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
        ),
      );
    }

    return items;
  }

  static Scaffold getContent(BuildContext context, content,
      [bool showButtonBar = false, bool showSearchButton = false]) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        actions: showButtonBar ? _getActions(context, showSearchButton) : [],
      ),
      body: new Builder(
        builder: (BuildContext context) {
          return content;
        },
      ),
      floatingActionButton: showButtonBar
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactAddPage()),
                );
              },
            )
          : null,
    );
  }
}
