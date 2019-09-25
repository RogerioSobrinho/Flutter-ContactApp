import 'dart:io';

import 'package:contacts/models/contact.dart';
import 'package:contacts/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../layout.dart';

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

    // final inputName = TextField(
    //   controller: _cName,
    //   decoration: InputDecoration(
    //     labelText: 'Nome',
    //     hintText: 'Nome',
    //     icon: Icon(Icons.person),
    //   ),
    // );

    // final inputNickName = TextFormField(
    //   controller: _cNickName,
    //   keyboardType: TextInputType.text,
    //   decoration: InputDecoration(
    //     labelText: 'Apelido',
    //     hintText: 'Apelido',
    //     icon: Icon(Icons.person),
    //   ),
    // // );
    // final inputWork = Text(ContactEditPage.contact['work']);
    // final inputPhoneNumber = Text(ContactEditPage.contact['phoneNumber']);
    // final inputEmail = Text(ContactEditPage.contact['email']);
    // final inputWebSite = Text(ContactEditPage.contact['webSite']);

    final picture = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 120.0,
          height: 120.0,
          child: CircleAvatar(
            child: Icon(
              Icons.camera_alt,
            ),
          ),
        ),
      ],
    );

    Scaffold content = Scaffold(
      appBar: AppBar(
        backgroundColor: Layout.primary(),
        elevation: 0,
        leading: IconButton(
          color: Layout.dark(),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.star),
            color: Layout.dark(),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            color: Layout.dark(),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              picture,
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                ContactEditPage.contact['name'],
                style: TextStyle(
                  color: Layout.dark(),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Icon(Icons.phone),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Telefone",
                      style: TextStyle(color: Color(0xFF333333)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(ContactEditPage.contact['phoneNumber']),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.person),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Apelido",
                      style: TextStyle(color: Color(0xFF333333)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(ContactEditPage.contact['name']),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Icon(Icons.person),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      "Apelido",
                      style: TextStyle(color: Color(0xFF333333)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(ContactEditPage.contact['name']),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // Row(
      //   children: <Widget>[
      //     Expanded(
      //       child: Container(
      //         decoration: BoxDecoration(color: Colors.blue),
      //         width: MediaQuery.of(context).size.width,
      //         height: (MediaQuery.of(context).size.height * 0.30),
      //         child: Column(
      //           children: <Widget>[
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.end,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: <Widget>[
      //                 IconButton(
      //                   icon: Icon(Icons.star),
      //                   color: Colors.white,
      //                   onPressed: () {},
      //                 ),
      //                 IconButton(
      //                   icon: Icon(Icons.more_vert),
      //                   color: Colors.white,
      //                   onPressed: () {},
      //                 ),
      //               ],
      //             ),
      //             picture,
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: <Widget>[
      //                 Text(
      //                   ContactEditPage.contact['name'],
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 18,
      //                   ),
      //                   maxLines: 1,
      //                   overflow: TextOverflow.ellipsis,
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      // Expanded(
      //   child: Form(
      //     key: _formKey,
      //     child: ListView(
      //       padding: EdgeInsets.all(20),
      //       children: <Widget>[
      //         inputName,
      //         inputNickName,
      //         inputWork,
      //         inputPhoneNumber,
      //         inputEmail,
      //         inputWebSite,
      //       ],
      //     ),
      //   ),
      // ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Container(
      //       padding: EdgeInsets.all(20),
      //       child: RaisedButton(
      //         padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 80.0),
      //         color: Colors.blue,
      //         textColor: Colors.white,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: new BorderRadius.circular(30.0),
      //         ),
      //         child: Text("Salvar"),
      //         onPressed: () {
      //           if (_formKey.currentState.validate()) {
      //             ModelContact contact = ModelContact();
      //             contact.insert({
      //               'name': _cName.text,
      //               'nickName': _cNickName.text,
      //               'work': _cWork.text,
      //               'phoneNumber': _cPhoneNumber.text,
      //               'email': _cEmail.text,
      //               'webSite': _cWebSite.text,
      //               'created': DateTime.now().toString()
      //             }).then((saved) {
      //               Navigator.of(context).pop();
      //               Navigator.of(context).pushReplacementNamed(HomePage.tag);
      //             });
      //           }
      //         },
      //       ),
      //     ),
      //   ],
      // )
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
