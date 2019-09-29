import 'dart:io';
import 'dart:async';
import 'package:exemplo/src/home/home_bloc.dart';
import 'package:exemplo/src/home/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'edit_page.dart';

class ViewPage extends StatefulWidget {
  static String tag = 'view-page';

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  static String defaultMessage = "Não informado";
  final bloc = HomeModule.to.getBloc<HomeBloc>(); //pega a injeção do BLoC
  bool existWhatsapp = false;

  Future<void> getApps() async {
    try {
      if (Platform.isAndroid) {
        await AppAvailability.checkAvailability("com.whatsapp");
      } else if (Platform.isIOS) {
        await AppAvailability.checkAvailability("whatsapp://");
      }
      setState(() {
        this.existWhatsapp = true;
      });
    } catch (err) {
      setState(() {
        this.existWhatsapp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getApps();
    ListView content(context, Map snapshot) {
      return ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              buildHeader(context, snapshot['name']),
              buildInformation(
                  snapshot['phoneNumber'], snapshot['email'], snapshot['name']),
            ],
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.star),
            onPressed: () {},
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditPage()),
              );
            },
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder(
        stream: bloc.contactOut,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Error: ${snapshot.error}');
          } else {
            return content(context, snapshot.data);
          }
        },
      ),
    );
  }

  void whatsAppOpen(phoneNumber, message) async {
    await FlutterLaunch.launchWathsApp(phone: phoneNumber, message: message);
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

  Container buildHeader(BuildContext context, String name) {
    return Container(
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
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding buildInformation(phoneNumber, email, nome) {
    return Padding(
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
                  : defaultMessage),
              subtitle: Text(
                "Telefone",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                icon: Icon(Icons.phone, color: Colors.indigo),
                onPressed: () {
                  _launchCaller(phoneNumber);
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  _textMe(phoneNumber);
                },
              ),
            ),
            ListTile(
              title: Text(email.toString().isNotEmpty ? email : defaultMessage),
              subtitle: Text(
                "E-mail",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                  icon: Icon(Icons.email, color: Colors.indigo),
                  onPressed: () {}),
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
                  onPressed: () {
                    Share.share("""
                      Nome: $nome
                      Tel: $phoneNumber
                    """);
                  }),
            ),
            existWhatsapp
                ? ListTile(
                    title: Text(
                      "Abrir no Whatsapp",
                    ),
                    subtitle: Text(
                      "Whatsapp",
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: IconButton(
                        icon: Icon(FontAwesomeIcons.whatsapp,
                            color: Colors.indigo),
                        onPressed: () {
                          whatsAppOpen(phoneNumber.toString(), "");
                        }),
                  )
                : ListTile(),
          ],
        ),
      ),
    );
  }
}
