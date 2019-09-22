import 'dart:io';

import 'package:contacts/models/contact.dart';
import 'package:contacts/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactEditPage extends StatefulWidget {
  static String tag = 'edit-page';
  static Map contact;

  @override
  _ContactEditPageState createState() => _ContactEditPageState();
}

class _ContactEditPageState extends State<ContactEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cFirstName = TextEditingController();
  final TextEditingController _cLastName = TextEditingController();
  final TextEditingController _cPhoneNumber = TextEditingController();
  final TextEditingController _cEmail = TextEditingController();
  final TextEditingController _cWork = TextEditingController();

  @override
  void initState() {
    _cFirstName.text = ContactEditPage.contact['firstName'];
    _cLastName.text = ContactEditPage.contact['lastName'];
    _cPhoneNumber.text = ContactEditPage.contact['phoneNumber'];
    _cEmail.text = ContactEditPage.contact['email'];
    _cWork.text = ContactEditPage.contact['work'];
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
    final phoneNumber = ContactEditPage.contact['phoneNumber'];
    final inputFirstName = TextFormField(
      controller: _cFirstName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'First Name',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );

    final inputLastName = TextFormField(
      controller: _cLastName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Last Name',
      ),
    );

    final inputPhoneNumber = TextFormField(
      controller: _cPhoneNumber,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );

    final inputEmail = TextFormField(
      controller: _cEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
      ),
    );

    final inputWork = TextFormField(
      controller: _cWork,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Work',
      ),
    );

    Container content = Container(
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          children: <Widget>[
            inputFirstName,
            inputLastName,
            inputPhoneNumber,
            inputEmail,
            inputWork,
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.phone),
                    onPressed: () => _launchCaller(phoneNumber),
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () => _textMe(phoneNumber),
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      Share.share("""
                        Name: $ContactEditPage.contact['firstName']
                        Phone: $phoneNumber
                      """); // Not finish - of course
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Alter contact"),
        actions: <Widget>[
          IconButton(
            icon: Text("Alter"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                ModelContact contact = ModelContact();
                contact.update(
                  {
                    'firstName': _cFirstName.text,
                    'lastName': _cLastName.text,
                    'phoneNumber': _cPhoneNumber.text,
                    'email': _cEmail.text,
                    'work': _cWork.text,
                  },
                  ContactEditPage.contact['id'],
                ).then((saved) {
                  Navigator.of(context).pushReplacementNamed(HomePage.tag);
                });
              }
            },
          )
        ],
      ),
      body: content,
    );
  }
}
