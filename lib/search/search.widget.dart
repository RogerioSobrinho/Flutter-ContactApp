import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Search"),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: new TextFormField(
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
            labelText: 'Search contact',
          ),
        ),
      ),
    );
  }
}
