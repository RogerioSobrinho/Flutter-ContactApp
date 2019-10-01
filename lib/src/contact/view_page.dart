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

  bool existWhatsapp = false;
  Map contact;

  HomeBloc blocHome;
  // final eeee = ViewModule.to
  //     .getBloc<ViewBloc>(); (??) problem using two bloc import! What????

  @override
  void initState() {
    blocHome = HomeModule.to.getBloc<HomeBloc>();
    super.initState();
  }

  Future<void> getApps() async {
    try {
      if (Platform.isAndroid) {
        await AppAvailability.checkAvailability("com.whatsapp");
      } else if (Platform.isIOS) {
        await AppAvailability.checkAvailability("whatsapp://");
      }
      this.existWhatsapp = true;
    } catch (err) {
      this.existWhatsapp = false;
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
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: StreamBuilder(
          stream: blocHome.favoriteOut,
          builder: (conext, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Error: ${snapshot.error}');
            } else {
              return AppBar(
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                    color: Colors.white,
                    icon: snapshot.data
                        ? Icon(Icons.star)
                        : Icon(Icons.star_border),
                    onPressed: () {
                      blocHome.updateFavorite(
                          this.contact['id'], !snapshot.data);
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      EditPage.contact = this.contact;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditPage()),
                      );
                    },
                  ),
                  // IconButton(
                  //   color: Colors.white,
                  //   icon: Icon(Icons.more_vert),
                  //   onPressed: () {},
                  // ),
                ],
              );
            }
          },
        ),
      ),
      body: StreamBuilder(
        stream: blocHome.contactOut,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Error: ${snapshot.error}');
          } else {
            this.contact = snapshot.data;
            blocHome.setFavorite(snapshot.data['favorite'] == 1);
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
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
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
          ),
          Card(
            child: ListTile(
              title: Text(email.toString().isNotEmpty ? email : defaultMessage),
              subtitle: Text(
                "E-mail",
                style: TextStyle(color: Colors.black54),
              ),
              leading: IconButton(
                  icon: Icon(Icons.email, color: Colors.indigo),
                  onPressed: () {}),
            ),
          ),
          Card(
            child: ListTile(
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
          ),
          Card(
            child: existWhatsapp
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
                : Container(),
          ),
        ],
      ),
    );
  }
}
