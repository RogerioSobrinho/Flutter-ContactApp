import 'package:contacts/layout.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';

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

  @override
  Widget build(BuildContext context) {
    final inputName = TextFormField(
      controller: _cName,
      autofocus: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Nome',
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
        icon: Icon(Icons.person),
      ),
    );

    final inputWork = TextFormField(
      controller: _cWork,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Trabalho',
        icon: Icon(Icons.work),
      ),
    );

    final inputPhoneNumber = new MaskedTextField(
      maskedTextFieldController: _cPhoneNumber,
      mask: "(xxx) xxxxx.xxxx",
      maxLength: 16,
      keyboardType: TextInputType.phone,
      inputDecoration: new InputDecoration(
        labelText: "Telefone",
        icon: Icon(Icons.phone),
      ),
    );

    final inputEmail = TextFormField(
      controller: _cEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
      ),
    );

    final inputWebSite = TextFormField(
      controller: _cWebSite,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Site da Web',
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
        SizedBox(height: 20),
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
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(HomePage.tag);
          },
        ),
        title: Text("Criar novo contato"),
        actions: <Widget>[
          Container(
            width: 80,
            child: IconButton(
              icon: Text(
                'SALVAR',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  ModelContact contact = ModelContact();
                  contact.update(
                    {
                      'name': _cName.text,
                      'nickName': _cNickName.text,
                      'work': _cWork.text,
                      'phoneNumber': _cPhoneNumber.text,
                      'email': _cEmail.text,
                      'webSite': _cWebSite.text,
                    },
                    ContactEditPage.contact['id'],
                  ).then((saved) {
                    Navigator.of(context).pushReplacementNamed(HomePage.tag);
                  });
                }
              },
            ),
          )
        ],
      ),
      body: content,
    );
  }
}
