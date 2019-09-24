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
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cNickName = TextEditingController();
  final TextEditingController _cWork = TextEditingController();
  final TextEditingController _cPhoneNumber = TextEditingController();
  final TextEditingController _cEmail = TextEditingController();
  final TextEditingController _cWebSite = TextEditingController();

  @override
  void initState() {
    _cName.text = ContactEditPage.contact['name'];
    _cNickName.text = ContactEditPage.contact['nickName'];
    _cWork.text = ContactEditPage.contact['work'];
    _cPhoneNumber.text = ContactEditPage.contact['phoneNumber'];
    _cEmail.text = ContactEditPage.contact['email'];
    _cWebSite.text = ContactEditPage.contact['webSite'];
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
    final inputName = TextFormField(
      controller: _cName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nome',
        hintText: 'Nome',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    final inputNickName = TextFormField(
      controller: _cNickName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Apelido',
        hintText: 'Apelido',
        icon: Icon(Icons.person),
      ),
    );

    final inputWork = TextFormField(
      controller: _cWork,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Trabalho',
        hintText: 'Trabalho',
        icon: Icon(Icons.work),
      ),
    );

    final inputPhoneNumber = TextFormField(
      controller: _cPhoneNumber,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Telefone',
        hintText: 'Telefone',
        icon: Icon(Icons.phone),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return null;
      },
    );

    final inputEmail = TextFormField(
      controller: _cEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        hintText: 'E-mail',
        icon: Icon(Icons.email),
      ),
    );

    final inputWebSite = TextFormField(
      controller: _cWebSite,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Site da Web',
        hintText: 'Site da Web',
        icon: Icon(Icons.web),
      ),
    );

    Column content = Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 35, left: 10, right: 10),
                decoration: BoxDecoration(color: Colors.blue),
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height * 0.30),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.star),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          ContactEditPage.contact['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                inputName,
                inputNickName,
                inputWork,
                inputPhoneNumber,
                inputEmail,
                inputWebSite,
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 80.0),
                color: Colors.blue,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: Text("Salvar"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    ModelContact contact = ModelContact();
                    contact.insert({
                      'name': _cName.text,
                      'nickName': _cNickName.text,
                      'work': _cWork.text,
                      'phoneNumber': _cPhoneNumber.text,
                      'email': _cEmail.text,
                      'webSite': _cWebSite.text,
                      'created': DateTime.now().toString()
                    }).then((saved) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed(HomePage.tag);
                    });
                  }
                },
              ),
            ),
          ],
        )
      ],
    );

    // Container content = Column(
    //   child: Form(
    //     key: _formKey,
    //     child: ListView(
    //       shrinkWrap: true,
    //       padding: EdgeInsets.all(20),
    //       children: <Widget>[
    //         inputFirstName,
    //         inputLastName,
    //         inputPhoneNumber,
    //         inputEmail,
    //         inputWork,
    //         SizedBox(height: 10),
    //         Container(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             children: <Widget>[
    //               IconButton(
    //                 icon: Icon(Icons.phone),
    //                 onPressed: () => _launchCaller(phoneNumber),
    //               ),
    //               IconButton(
    //                 icon: Icon(Icons.message),
    //                 onPressed: () => _textMe(phoneNumber),
    //               ),
    //               IconButton(
    //                 icon: Icon(Icons.share),
    //                 onPressed: () {
    //                   Share.share("""
    //                     Name: $ContactEditPage.contact['firstName']
    //                     Phone: $phoneNumber
    //                   """); // Not finish - of course
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.grey,
      //   leading: IconButton(
      //     icon: Icon(Icons.close),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      //   title: Text("Alter contact"),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Text("Alter"),
      //       onPressed: () {
      //         if (_formKey.currentState.validate()) {
      //           ModelContact contact = ModelContact();
      //           contact.update(
      //             {
      //               'firstName': _cFirstName.text,
      //               'lastName': _cLastName.text,
      //               'phoneNumber': _cPhoneNumber.text,
      //               'email': _cEmail.text,
      //               'work': _cWork.text,
      //             },
      //             ContactEditPage.contact['id'],
      //           ).then((saved) {
      //             Navigator.of(context).pushReplacementNamed(HomePage.tag);
      //           });
      //         }
      //       },
      //     )
      //   ],
      // ),
      body: content,
    );
  }
}
