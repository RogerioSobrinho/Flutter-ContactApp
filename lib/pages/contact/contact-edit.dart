import 'package:flutter/material.dart';

class ContactEditPage extends StatefulWidget {
  static String tag = 'edit-page';
  @override
  _ContactEditPageState createState() => _ContactEditPageState();
}

class _ContactEditPageState extends State<ContactEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Create contact"),
          actions: <Widget>[
            IconButton(
              icon: Text("Save"),
              onPressed: () {},
            )
          ],
        ),
        body: new ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_box),
              title: new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Rogerio',
                  labelText: 'First name',
                ),
              ),
            ),
            ListTile(
              leading: IgnorePointer(),
              title: new TextFormField(
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  hintText: 'Rogerio Sobrinho',
                  labelText: 'Last name',
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: new TextFormField(
                keyboardType: TextInputType.phone,
                decoration: new InputDecoration(
                  hintText: '+55 11123456789',
                  labelText: 'Phone number',
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: new TextFormField(
                keyboardType: TextInputType.phone,
                decoration: new InputDecoration(
                  hintText: 'example@example.com',
                  labelText: 'E-mail',
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.work),
              title: new TextFormField(
                keyboardType: TextInputType.phone,
                decoration: new InputDecoration(
                  hintText: 'Google',
                  labelText: 'Work',
                ),
              ),
            ),
          ],
        ));
  }
}
