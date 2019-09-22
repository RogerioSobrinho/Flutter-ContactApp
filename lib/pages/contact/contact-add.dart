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

  @override
  Widget build(BuildContext context) {
    final inputFirstName = TextFormField(
      controller: _cFirstName,
      autofocus: true,
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
      autofocus: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Last Name',
      ),
    );

    final inputPhoneNumber = TextFormField(
      controller: _cPhoneNumber,
      autofocus: false,
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
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
      ),
    );

    final inputWork = TextFormField(
      controller: _cWork,
      autofocus: false,
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
  }
}
