import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact-edit.dart';

class ContactViewPage extends StatefulWidget {
  static String tag = 'view-page';
  static Map contact;
  static String defaultMessage = "Não informado";

  @override
  _ContactViewPageState createState() => _ContactViewPageState();
}

class _ContactViewPageState extends State<ContactViewPage> {
  @override
  void initState() {
    super.initState();
  }

  _textMe(String number) async {
    // Android
    String uri = "sms:$number";
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      String uri = "sms:$number";
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  _launchCaller(String number) async {
    String url = "tel:$number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber = ContactViewPage.contact['phoneNumber'];
    final email = ContactViewPage.contact['email'];

    Scaffold content = Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.star),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactEditPage()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.indigo),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.40,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                SizedBox(height: 20),
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 160,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        ContactViewPage.contact['name'],
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1, // has the effect of softening the shadow
                    spreadRadius: 1, // has the effect of extending the shadow
                    offset: Offset(
                      1, // horizontal, move right 10
                      1, // vertical, move down 10
                    ),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(phoneNumber.toString().isNotEmpty
                        ? phoneNumber
                        : ContactViewPage.defaultMessage),
                    subtitle: Text(
                      "Telefone",
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: IconButton(
                      icon: Icon(Icons.phone, color: Colors.indigo),
                      onPressed: () {},
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {},
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(email.toString().isNotEmpty
                        ? email
                        : ContactViewPage.defaultMessage),
                    subtitle: Text(
                      "E-mail",
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: IconButton(
                        icon: Icon(Icons.email, color: Colors.indigo),
                        onPressed: () {}),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      "Enviar contato",
                    ),
                    subtitle: Text(
                      "Compartilhar",
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: IconButton(
                        icon: Icon(Icons.share, color: Colors.indigo),
                        onPressed: () {}),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: content,
    );
  }
}
