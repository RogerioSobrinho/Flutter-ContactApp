import 'package:contacts/layout.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/pages/home/home.dart';
import 'package:flutter/material.dart';

class ContactAddPage extends StatefulWidget {
  static String tag = 'add-page';
  @override
  _ContactAddPageState createState() => _ContactAddPageState();
}

class _ContactAddPageState extends State<ContactAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cFirstName = TextEditingController();
  final TextEditingController _cLastName = TextEditingController();
  final TextEditingController _cPhoneNumber = TextEditingController();
  final TextEditingController _cEmail = TextEditingController();
  final TextEditingController _cWork = TextEditingController();
  // final TextEditingController _cQtd = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    final inputFirstName = TextFormField(
      controller: _cFirstName,
      autofocus: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'First name',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );

    final inputLastName = TextFormField(
      controller: _cLastName,
      autofocus: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Last name',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    final inputPhoneNumber = TextFormField(
      controller: _cPhoneNumber,
      autofocus: false,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          hintText: 'Phone Number',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );

    final inputEmail = TextFormField(
      controller: _cEmail,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: 'Last name',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    final inputWork = TextFormField(
      controller: _cWork,
      autofocus: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: 'Last name',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    Container content = Container(
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          children: <Widget>[
            // SizedBox(height: 10),
            Text('First Name'),
            inputFirstName,
            Text('Last Name'),
            inputLastName,
            Text('Phone Number'),
            inputPhoneNumber,
            Text('Email'),
            inputEmail,
            Text('Work'),
            inputWork,
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
        title: Text("Add contact"),
        actions: <Widget>[
          IconButton(
            icon: Text("Save"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                ModelContact contact = ModelContact();
                contact.insert({
                  'firstName': _cFirstName.text,
                  'lastName': _cLastName.text,
                  'phoneNumber': _cPhoneNumber.text,
                  'email': _cEmail.text,
                  'work': _cWork.text,
                  'created': DateTime.now().toString()
                }).then((saved) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed(HomePage.tag);
                });
              }
            },
          )
        ],
      ),
      body: content,
    );

    // return Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.grey,
    //       leading: IconButton(
    //         icon: Icon(Icons.close),
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //       title: Text("Add contact"),
    //       actions: <Widget>[
    //         IconButton(
    //           icon: Text("Save"),
    //           onPressed: () {},
    //         )
    //       ],
    //     ),
    //     body: new ListView(
    //       children: <Widget>[
    //         ListTile(
    //           leading: Icon(Icons.account_box),
    //           title: new TextFormField(
    //             keyboardType: TextInputType.text,
    //             decoration: new InputDecoration(
    //               hintText: 'Rogerio',
    //               labelText: 'First name',
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           leading: IgnorePointer(),
    //           title: new TextFormField(
    //             keyboardType: TextInputType.text,
    //             decoration: new InputDecoration(
    //               hintText: 'Rogerio Sobrinho',
    //               labelText: 'Last name',
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           leading: Icon(Icons.phone),
    //           title: new TextFormField(
    //             keyboardType: TextInputType.phone,
    //             decoration: new InputDecoration(
    //               hintText: '+55 11123456789',
    //               labelText: 'Phone number',
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           leading: Icon(Icons.email),
    //           title: new TextFormField(
    //             keyboardType: TextInputType.phone,
    //             decoration: new InputDecoration(
    //               hintText: 'example@example.com',
    //               labelText: 'E-mail',
    //             ),
    //           ),
    //         ),
    //         ListTile(
    //           leading: Icon(Icons.work),
    //           title: new TextFormField(
    //             keyboardType: TextInputType.phone,
    //             decoration: new InputDecoration(
    //               hintText: 'Google',
    //               labelText: 'Work',
    //             ),
    //           ),
    //         ),
    //       ],
    //     ));
  }
}
