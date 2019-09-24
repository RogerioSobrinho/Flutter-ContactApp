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
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cNickName = TextEditingController();
  final TextEditingController _cWork = TextEditingController();
  final TextEditingController _cPhoneNumber = TextEditingController();
  final TextEditingController _cEmail = TextEditingController();
  final TextEditingController _cWebSite = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inputName = TextFormField(
      controller: _cName,
      autofocus: true,
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

    Column content = Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        picture,
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

    return Scaffold(
      body: content,
    );
  }
}
