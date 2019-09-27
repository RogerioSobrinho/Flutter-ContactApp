import 'dart:io';

import 'package:contacts/models/contact.dart';
import 'package:contacts/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactViewPage extends StatefulWidget {
  static String tag = 'edit-page';
  static Map contact;

  @override
  _ContactViewPageState createState() => _ContactViewPageState();
}

class _ContactViewPageState extends State<ContactViewPage> {
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final TextEditingController _cName = TextEditingController();
  // final TextEditingController _cNickName = TextEditingController();
  // final TextEditingController _cWork = TextEditingController();
  // final TextEditingController _cPhoneNumber = TextEditingController();
  // final TextEditingController _cEmail = TextEditingController();
  // final TextEditingController _cWebSite = TextEditingController();

  @override
  void initState() {
    // _cName.text = ContactViewPage.contact['name'];
    // _cNickName.text = ContactViewPage.contact['nickName'];
    // _cWork.text = ContactViewPage.contact['work'];
    // _cPhoneNumber.text = ContactViewPage.contact['phoneNumber'];
    // _cEmail.text = ContactViewPage.contact['email'];
    // _cWebSite.text = ContactViewPage.contact['webSite'];
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
    // final inputWork = Text(ContactViewPage.contact['work']);
    // final inputPhoneNumber = Text(ContactViewPage.contact['phoneNumber']);
    // final inputEmail = Text(ContactViewPage.contact['email']);
    // final inputWebSite = Text(ContactViewPage.contact['webSite']);

    Scaffold content = Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.star),
      //       onPressed: () {},
      //     ),
      //     IconButton(
      //       icon: Icon(Icons.more_vert),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
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
                    onPressed: () {},
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
                  Icons.people,
                  color: Colors.white,
                  size: 160,
                ),
                Row(
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
                    title: Text("999999999"),
                    subtitle: Text(
                      "Telefone",
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: Icon(Icons.phone, color: Colors.indigo),
                  ),
                  ListTile(
                    title: Text("999999999"),
                    subtitle: Text(
                      "E-mail",
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: Icon(Icons.email, color: Colors.indigo),
                  ),
                  ListTile(
                    title: Text(
                      "999999999",
                      style: TextStyle(color: Colors.black54),
                    ),
                    subtitle: Text("Compartilhar"),
                    leading: Icon(Icons.share, color: Colors.indigo),
                  ),

                  // SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 30, right: 10),
                  //   child: Icon(Icons.phone, color: Colors.indigo),
                  // ),
                  // SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5, right: 10),
                  //   child: Icon(Icons.email, color: Colors.indigo),
                  // ),
                  // SizedBox(height: 20),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 5, right: 10),
                  //   child: Icon(Icons.share, color: Colors.indigo),
                  // ),
                ],
              ),
              // Column(
              //   children: <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             phoneNumber.toString().isNotEmpty
              //                 ? phoneNumber
              //                 : "Não informado",
              //             style: TextStyle(fontSize: 18),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(top: 3),
              //             child: Text(
              //               "Telefone",
              //               style: TextStyle(color: Colors.black54),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(height: 20),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             email.toString().isNotEmpty
              //                 ? email
              //                 : "Não informado",
              //             style: TextStyle(fontSize: 18),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(top: 3),
              //             child: Text(
              //               "E-mail",
              //               style: TextStyle(color: Colors.black54),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(height: 20),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             "Enviar contato",
              //             style: TextStyle(fontSize: 18),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.only(top: 3),
              //             child: Text(
              //               "Compartilhar",
              //               style: TextStyle(color: Colors.black54),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
            ),
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
      //                   ContactViewPage.contact['name'],
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
    //                     Name: $ContactViewPage.contact['firstName']
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
      //             ContactViewPage.contact['id'],
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
