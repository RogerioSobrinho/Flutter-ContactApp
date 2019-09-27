import 'package:contacts/layout.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static String tag = 'search-page';
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          child: new TextFormField(
            keyboardType: TextInputType.text,
            decoration: new InputDecoration(
              labelText: 'Pesquisar contatos',
            ),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
